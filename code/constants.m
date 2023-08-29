%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AAE 532 
% Dominic Ferro
% 9/7/22
% File including all constants from Table of Constants_Planets
% Gets updated as new constants are needed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Gravitational Constant (not in table)
G = 6.6743e-20; % km^3/kgs^2

% Conversion factors
AU = 1.4959787e8; % km
sec2hr = 1/3600;
hr2days = 1/24;
sec2days = sec2hr * hr2days;
days2yr = 1/365.2425; % accounts for leap years
sec2yr = sec2days * days2yr;

% Gravitational Parameters (km^3/s^2)
Sun.mu = 132712440017.99;
Moon.mu = 4902.8005821478;
Earth.mu = 398600.4415;
Jupiter.mu = 126712767.8578;
Titan.mu = 8978.1382;
Mars.mu = 42828.314258067;
Uranus.mu = 5794549.0070719;
Mercury.mu = 22032.080486418;
Venus.mu = 324858.59882646;
Ganymede.mu = 9887.834;
Europa.mu = 3202.739;
Saturn.mu = 37940626.061137;

% Semi-major axis of orbit
Moon.a = 384400; % around earth
Earth.a = 149597898;
Jupiter.a = 778279959;
Titan.a = 1221865;
Mars.a = 227944135;
Uranus.a = 2870480873;
Mercury.a = 57909101;
Venus.a = 108207284;
Ganymede.a = 1070400;
Europa.a = 671100;
Saturn.a = 1427387908;

% Radii [km]
Earth.R = 6378.1363;
Titan.R = 2574.730; 
Mars.R = 3397;
Moon.R = 1738.2;
Uranus.R = 25559;
Sun.R = 695990;
Jupiter.R = 71492;
Mercury.R = 2439.7;
Venus.R = 6051.9;
Ganymede.R = 2631.20;
Europa.R = 1560.80;
Saturn.R = 60268;

% Eccentricity
Earth.ecc = 0.01673163;
Moon.ecc = 0.0554;
Uranus.ecc = 0.04685740;
Saturn.ecc = 0.05550825;
Jupiter.ecc = 0.04853590;

