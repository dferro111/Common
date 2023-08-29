function EA = DCM2EA_313(DCM)


a = atan2(DCM(3,1), -DCM(3,2));
b = acos(DCM(3,3));
c = atan2(DCM(1,3), DCM(2,3));
% % ^ has a quadrant ambiguity : b = \pm acos()
% b2 = asin(sqrt(DCM(1,3)^2 + DCM(2,3)^2));

EA = [a ; b ; c];