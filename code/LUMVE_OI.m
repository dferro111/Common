function [x0ref, P0, rest, resm, resn, xn] = LUMVE_OI(tm, zm, Rm, Rtm, ...
    x1, mu, JD0)
% LUMVE method for first orbit improvement. Takes measurements of right
% ascension and declination and associated covariance as well as an initial
% prediction and improves via linear least squares (LUMVE)
% 
% Inputs:
%   tm - an array of measurement times, sec
%   zm - an array of measurements, rad
%       [ra(:), dec(:)]'
%   Rm - an array of covariance matrices, rad^2
%   Rtm - an array of topocenter locations, km
%   x1 - initial prediction of initial state in ECI (typically from an IOD)
%                                       [r0, v0], [km, km/s]
%   mu - gravitational parameter, kg^3/s^2
%   JD0 - julian date of the first time
% 
% Outputs:
%   x0ref - improved initial state estimation
%   P0 - covariance associated with the estimation
%   rest - time of the residuals
%   resm - value of the residuals at each time
%   xn - state after every iterration
% 
% [x0ref, P0, rest, resm, resn, xn] = LUMVE_OI(tm, zm, Rm, Rtm, x1, mu)

% Conversion factors
rad2arcsec = 1/(deg2rad(1/3600));
sec2days = 1/24/3600;

% Random other initializations
opts = odeset('RelTol',1e-12, 'AbsTol',1e-12);

% Batch loop -- change to a while loop later
m = length(zm);

t0 = tm(1);
x0ref = x1;

n = 0;

% First prior estimate
dx0bar = zeros(6, 1);
dx0hat = dx0bar;
P0bar = zeros(6, 6);

again = true;
while again %for ii = 1:4
    xref = x0ref;
    tkm1 = t0;
    Phi = eye(6,6);

    % Set lambdas
    lambd = zeros(6,1);
    Lambd = zeros(6,6);

    rest(n+1,:,:) = zeros(m, 2);
    resm(n+1,:,:) = zeros(m, 2);

    % Accumulation Loop
    for kk = 1:m
        % Pull values for this time
        tk = tm(kk);
        zk = zm(:,kk)*rad2arcsec;
        Rk = Rm(:,:,kk)*rad2arcsec^2;
        Rtk = Rtm(:,kk);
        JDkm1 = JD0 + (tkm1 * sec2days);

        % Propagate the reference
        if (kk > 1)
            [~,x] = ode45(@(t,x)orbit_eoms_stm(t,x,mu,JDkm1),[tkm1,tk],...
                [xref,Phi(:)'],opts);
            xref = x(end,1:6);
            Phi = reshape(x(end,7:end)', 6,6);
        end

        % Compute the measurement of the reference state [arcsec]
        r = xref(1:3) - Rtk';
        x = r(1);
        y = r(2);
        z = r(3);
        wsq = x*x + y*y;
        w = sqrt(wsq);
        rhosq = wsq + z*z;
        [ra, dec] = get_ra_dec(r);
        zref = [ra, dec]*rad2arcsec;
%         zref = [atan2(y,x); atan2(z,w)]*rad2arcsec;

        % Compute the measurement mapping matrix
        Htilda = [-y/wsq, x/wsq, 0, 0, 0, 0;
            -x*z/(w*rhosq), -y*z/(w*rhosq), w/rhosq, 0, 0, 0]*rad2arcsec;
        H = Htilda * Phi;

        % Accumulate
        zkr = [shortest_angle(zk(1), zref(1), 'arcsec');
            shortest_angle(zk(2), zref(2), 'arcsec')];
        lambd = lambd + H' * (Rk \ zkr);
        Lambd = Lambd + H' * (Rk \ H);

        % Update reference
        tkm1 = tk;

        % Save residuals
        rest(n+1,kk,:) = zk;%tk;
        resm(n+1,kk,:) = zref;%zkr';
        resn(n+1,kk,:) = zkr';
    end

    % Estimate and covariance
    tmp = dx0hat; % Save previous for convergence test
    dx0hat = Lambd \ lambd;
    P0 = inv(Lambd);

    % Update things
    x0ref = x0ref + dx0hat';
    dx0bar = dx0bar - dx0hat;
    P0bar = P0;

    % Save state after each iterration for plotting
    n = n+1;
    xn(:,n) = x0ref;
    
    % Check if we need to interrate again
    fprintf('I: %i, dx0hat: [%d %d %d %d %d %d] [m]\n',...
        n, dx0hat)
    if all(abs(dx0hat - tmp) < 1e-8) || n == 10
        again = false;
    end


end