function [e, t] = DCM2AA(DCM)
% Converts DCM to Euler Axis-Angle, angle in rad

t = acos(0.5*(DCM(1,1) + DCM(2,2) + DCM(3,3) - 1));
e = 1/(2*sin(t)) * [DCM(2,3) - DCM(3,2); 
                    DCM(3,1) - DCM(1,3); 
                    DCM(1,2) - DCM(2,1)];
e = e / norm(e);