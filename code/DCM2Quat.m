function Quat = DCM2Quat(DCM)
% DCM to Quaternion

[e, t] = DCM2AA(DCM);
Quat = AA2Quat(e, t);

% q4 = 0.5 * sqrt(1 + DCM(1,1) + DCM(2,2) + DCM(3,3)); 
% q1 = (DCM(2,3) - DCM(3,2)) / (4*q4);
% q2 = (DCM(3,1) - DCM(1,3)) / (4*q4);
% q3 = (DCM(1,2) - DCM(2,1)) / (4*q4);
% 
% Quat = [q1;q2;q3;q4];