function xdot = Propagator(t, x, muE, Re, jdi, muS, muM, ...
    d, h, mass, Cs, Cd, type, CD, Ad, dnsprm, terms)
% Propagate object orbit about Earth accounting for J2, Sun and Moon
% effects, Drag, SRP. Assumes that J2 transformation from ECI to ECEF is
% simply a rotation about Earth z axis by the GMST.
% 
% Inputs:
%   t - time, sec
%   x - state: [x y z, vx, vy, vz] in J2000
%   muE - earth grav param, km^3/s^2
%   Re - earth radius, km
%   jdi - initial julian date, days
%   muS - sun grav param
%   muM - moon grav param
%   d - diameter/base of characteristic surface, km
%   h - height of characteristic surface, km
%           (set to pi(d/4) if sphere)
%   mass - mass of object, kg
%   Cs - specular reflection coefficient
%   Cd - diffuse reflection coefficient
%   type - shape of the reflector
%   CD - drag coefficient
%   Ad - drag area, km^2
%   dnsprm - desntiy parameters in a table
%   terms - which terms are to be inlcuded in calculation
%       J2, 3B (Sun and Moon), SRP, Drag
% 
% Outputs:
%   state derivative

% Conversion factors
AU = 149597870; % km
sec2days = 1/3600/24; % days

% Calculate jday
JD = jdi + (t * sec2days);
% MJD = JD - get_jday(1858, 11, 17, 0, 0, 0);
GMST = get_sidereal_time(JD, 0);

% Get sun and moon positions
[rSun, ~, ~] = sun(JD);
[rMoon, ~, ~] = moon(JD);

a = 0;
% J2
if contains(terms, 'J2') || contains(terms,'all')
    % Get the acceleration from J2
%     C_J2E = R_J2000_ITRS(JD, MJD, GMST, coeffs, eop2, 0);
    
    % Convert ECI to ECEF for the calculation of J2 and rotate back
    C_J2E = R3(deg2rad(GMST*15));
    rECEF = C_J2E * x(1:3);
    aJ2ecef = J2_accel(rECEF, muE, Re); % ECEF
    aJ2eci = C_J2E' * aJ2ecef; % ECI
    
    a = a + aJ2eci;
end
if contains(terms, '3B') || contains(terms, 'all')
    % Third body effects
    aSun = Third_Body_accel(x(1:3), rSun*AU, muS);
    aMoon = Third_Body_accel(x(1:3), rMoon*Re, muM);
    
    a = a + aSun + aMoon;
end
% SRP
if contains(terms, 'SRP') || contains(terms, 'all')
    % Calculate SRP acceleration
    S = rSun / norm(rSun);
    % Assumes that the verticle is perpendicular to the Earth and Sun dirs
    if contains(type, 'cylinder')
        rm = x(1:3) / norm(x(1:3));
        N = cross(rm, S); 
    elseif contains(type, 'flat')
        N = S;
    else
        N = 0;
    end
    aSRP = SRP_accel(x(1:3), rSun*AU, d, h, S, N, Cs, Cd, mass, type);
    
    a = a + aSRP;
end
% Drag
if contains(terms, 'Drag') || contains(terms, 'all')
    % Calculates acceleration due to drag    
    aDrag = drag_accel(x(1:3), x(4:6), CD, Ad, mass, dnsprm); 
    
    a = a + aDrag;
end

% Run Eoms with accelerations
xdot = orbit_eoms(t, x, muE, a);


