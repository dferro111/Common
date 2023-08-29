function E = calculate_E(M, e)
% Calculates Eccentric anomoly
% 
% Inputs:
%   M - mean anomoly, deg
%   e - eccentricity
% Outputs:
%   E - eccentric anomoly, deg

M = deg2rad(M);

if abs(M) > pi
    E = M - e/2;
else
    E = M + e/2;
end

diff = 100;
while abs(diff) > 1e-12
    temp = E; % Saves previous E
    E = E - (E - e*sin(E) - M) / (1 - e*cos(E));
    diff = E - temp;   
end

E = rad2deg(E);

end