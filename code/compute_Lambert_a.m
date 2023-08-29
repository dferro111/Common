function [ag, tof] = compute_Lambert_a(TOF, mu, a_min, c, type)
% Uses a binary search style algorithm to find SMA solution given a TOF.
% Currently only has capability for 1A and 1B transfers.
% 
% Note: If the function does not converge, change the magnitude on ah
% 
% Inputs:
%   TOF - desired time of flight, sec
%   mu - grav constant, km^3/s^2
%   a_min - SMA for min energy orbit transfer, km
%   c - space triangle chord, km
%   type - type of orbit: '1A' '1B' '2A' '2B' '1H '2H'
% Outputs:
%   ag - converged value for SMA, km
% 
% ag = compute_Lambert_a(TOF, mu, a_min, c, type)

S = 2*a_min;

% Define initial bounds
al = a_min;
if abs(al) > 0
    ah = 1e10*a_min;
else
    ah = 1e15;
end

% Start loop
diffprev = realmax;
while true
    % Calculate SMA guess
    ag = 0.5*(al + ah);

    % 
    if contains(type, 'H')
        alpha0 = 2*asinh(sqrt(S / (2*abs(ag))));
        beta0 = 2*asinh(sqrt((S-c) / (2*abs(ag))));
    else
        alpha0 = 2*asin(sqrt(S / (2*ag)));
        beta0 = 2*asin(sqrt((S-c) / (2*ag)));
    end

    if contains(type, '1B')
        alpha = 2*pi - alpha0;
        beta = beta0;
    elseif contains(type, '1A')
        alpha = alpha0;
        beta = beta0;
    elseif contains(type, '2B')
        alpha = 2*pi - alpha0;
        beta = -beta0;
    elseif contains(type, '2A')
        alpha = alpha0;
        beta = -beta0;
    end

    if contains(type, 'H')
        if contains(type, '1')
            alpha = alpha0;
            beta = beta0;
        else
            alpha = alpha0;
            beta = -beta0;
        end
        tof = sqrt(abs(ag)^3/mu) ...
            * ((sinh(alpha) - alpha) - (sinh(beta) - beta));
    else
        tof = sqrt(ag^3/mu) * ((alpha - beta) - (sin(alpha) - sin(beta)));
    end

    diff = tof - TOF;
    if abs(diff - diffprev) < 1e-12
        break;
    end
    if contains(type, 'B') || contains(type, 'H')
        if diff < 1e-12
            al = ag;
        elseif diff > 1e-12
            ah = ag;
        end
    elseif contains(type, 'A')
        if diff > 1e-12
            al = ag;
        elseif diff < 1e-12
            ah = ag;
        end
    end
    diffprev = diff;
end

% opts = optimoptions('fsolve','MaxFunctionEvaluations',1e4);
% 
% S = 2*a_min;
% 
% ag = double(fsolve(@(a)KeplersEqn(a,S,c,mu,type) - TOF, a_min, opts))