function xdot = orbit_eoms_stm(t, x, mu, JD0)
% EOMs that calculate both the trajectory and the state transition matrix
r = x(1:3);

xdot = zeros(size(x));

% Calculate GMST based off the integration time
sec2days = 1/3600/24;
JD = JD0 + (t * sec2days);
GMST = get_sidereal_time(JD, 0);

% Compute J2 Terms
Re = 6378.1;
C_J2E = R3(deg2rad(GMST*15));
rECEF = C_J2E * x(1:3);
[aJ2ecef, J] = J2_accel(rECEF, mu, Re);
aJ2eci = C_J2E' * aJ2ecef;

% Integrate acceleration
xdot(1:3) = x(4:6);
xdot(4:6) = -mu/norm(r)^3 * x(1:3) + aJ2eci;

% Gravity Jacobian
Gf = [zeros(3,3), eye(3);
    mu/norm(r)^5 * (3*(r*r') - norm(r)^2*eye(3)), zeros(3,3)];
GJ2 = [zeros(3,3), zeros(3,3); J, zeros(3,3)];

G = Gf + GJ2;

Phi = reshape(x(7:end),6,6);
Phidot = G * Phi;
xdot(7:end) = Phidot(:);