function psi = BRDF_plate_ex(o, s, r, n, rhos, A, C, type)
% Computes the Bidirectional Reflection Function for spherical objects
% 
% Assumes observer is looking directly at the object through a telescope
% 
% Inputs:
%   o - object to observer vector, m 
%   s - object to sun vector, m
%   n - unit normal vector for the reflecting surface
%  	rhos - angular size of the source
%   A - Aera of the plate, m^2
%   C - coefficient of diffusion/reflection
%   type - type of reflection
% Outputs:
%   psi - Bidirectional Reflection Function result
% 

% Normalize input vectors
o_n = o / norm(o);
s_n = s / norm(s);
r_n = r / norm(r);

% Calculate Angles off of normal
thetao = acos(dot(o_n, n));
thetas = acos(dot(s_n, n));

% Calculate perfect reflection direction
o_spec_perf = 2*cos(thetas)*n - s_n;

% Calculuate are of reflection on surface of earth
A_reflec = pi*(tan(rhos) * norm(o) + sqrt(A / pi))^2;

% Extension of the reflecting surface in plane spanned by o and n
d_reflec = sqrt(A / pi);

% Calculate segment of the disk below the plane
epsilons = (pi/2) - thetas;
A_segment = acos(epsilons / rhos) * rhos^2 ...
            - epsilons * sqrt(rhos^2 - epsilons^2);
        
% Determine value for mu0
if (thetas + rhos) < (pi/2)
    mu0 = 1;
elseif thetas < (pi/2) && (thetas + rhos) > (pi/2)
    mu0 = (pi*rhos^2 - A_segment)^2 / rhos^2;
elseif thetas > (pi/2) && (thetas - rhos) < (pi/2)
    mu0 = A_segment^2 / rhos^2;
elseif (thetas - rhos) >= (pi/2)
    mu0 = 0;
end

% Determine p - if the observer can see the object
o_spec_perf_n = o_spec_perf / norm(o_spec_perf);
sigma = acos(dot(o_n, o_spec_perf_n));
if sigma < atan((d_reflec + tan(rhos)) / norm(o)) || sigma < 1e-4
    p = 1;
else
    p = 0;
end

% Compute the BRDF
if contains(type, 'lamb')
    psi = (C / pi) * A * mu0 * cos(thetao);
elseif contains(type, 'spec')
    psi = C * mu0 * (A / A_reflec) * p;
end


end