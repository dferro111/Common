function [aJ2, GJ2] = J2_accel_eci(r, mu, r0, tf_J)
% Computes J2 acceleration in ECI frame
% 
% Inputs:
%   r - position in ECI [km]
%   mu - grav param [km^3/s^2]
%   r0 - equitorial radius [km]
%   tf_J - true/false compute Jacobian
% Outputs:
%   aJ2 - acceleration in ECI due to J2

J2 = 1.0826e-3;

x = r(1);
y = r(2);
z = r(3);
r = norm(r);

% Just a constant
C = -3*mu*J2*r0^2 / (2*r^5);

aJ2 =  C * [(1 - 5*z^2 / r^2) * x; 
            (1 - 5*z^2 / r^2) * y; 
            (3 - 5*z^2 / r^2) * z];

if tf_J
    % Compute J2 Jacobian (hard coded in rn)
    GJ2 = zeros(3);
    GJ2(1,1) = 35*x^2*z^2/r^4 - 5*(x^2 + z^2)/r^2 + 1;
    GJ2(1,2) = 35*x*y*z^2/r^4 - 5*x*y/r^4;
    GJ2(1,3) = 35*x*z^3/r^4 - 15*x*z/r^2;
    GJ2(2,1) = 35*x*y*z^2/r^4 - 5*x*y/r^2;
    GJ2(2,2) = 35*y^2*z^2/r^4 - 5*(y^2 + z^2)/r^2 + 1;
    GJ2(2,3) = 35*y*z^3/r^4 - 15*y*z/r^2;
    GJ2(3,1) = 35*x*z^3/r^4 - 15*x*z/r^2;
    GJ2(3,2) = 35*y*z^3/r^4 - 15*y*z/r^2;
    GJ2(3,3) = 35*z^4/r^4 - 30*z^2/r^2 + 3;
    GJ2 = C * GJ2;
end