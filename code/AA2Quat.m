function Q = AA2Quat(e, t)
% Angles in radians

Q = [e(1)*sin(t/2); 
     e(2)*sin(t/2);
     e(3)*sin(t/2);
     cos(t/2)];

