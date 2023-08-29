function DCM = AA2DCM(e, t)
% Angles in rad please
c = cos(t);
s = sin(t);

% Diagonal Terms
DCM(1,1) = e(1)^2*(1-c) + c;
DCM(2,2) = e(2)^2*(1-c) + c;
DCM(3,3) = e(3)^2*(1-c) + c;

% Off Diagonal Terms
DCM(1,2) = e(1)*e(2)*(1-c) + e(3)*s;
DCM(2,1) = e(2)*e(1)*(1-c) - e(3)*s;
DCM(1,3) = e(1)*e(3)*(1-c) - e(2)*s;
DCM(3,1) = e(3)*e(1)*(1-c) + e(2)*s;
DCM(2,3) = e(2)*e(3)*(1-c) + e(1)*s;
DCM(3,2) = e(3)*e(2)*(1-c) - e(1)*s;