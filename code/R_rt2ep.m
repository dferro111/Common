function R = R_rt2ep(a)
% Rotate from rotating orbit frame to fixed orbit frame. a - rad
    R = [cos(a), -sin(a);
         sin(a), cos(a)];
end