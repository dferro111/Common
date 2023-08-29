function DCM = Quat2DCM(q)

e1 = q(1);
e2 = q(2);
e3 = q(3);
e4 = q(4);

DCM(1,1) = 1 - 2*e2^2 - 2*e3^2;
DCM(2,2) = 1 - 2*e1^2 - 2*e3^2;
DCM(3,3) = 1 - 2*e1^2 - 2*e2^2;

DCM(1,2) = 2*(e1*e2 + e3*e4);
DCM(2,1) = 2*(e1*e2 - e3*e4);
DCM(1,3) = 2*(e1*e3 - e2*e4);
DCM(3,1) = 2*(e1*e3 + e2*e4);
DCM(2,3) = 2*(e2*e3 + e1*e4);
DCM(3,2) = 2*(e2*e3 - e1*e4);