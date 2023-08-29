function q = QoQ(a, b)
% Quaternion multiplication
% 
% inputs:
%   a - quaternion, a(4) is the real component
%   b - quaternion, b(4) is the real component
% outputs:
%   q = quaternion, real component is q(4)

q(4) = a(4)*b(4) - a(1)*b(1) - a(2)*b(2) - a(3)*b(3);
q(1) = a(4)*b(1) + a(1)*b(4) - a(2)*b(3) + a(3)*b(2);
q(2) = a(4)*b(2) + a(1)*b(3) + a(2)*b(4) - a(3)*b(1);
q(3) = a(4)*b(3) - a(1)*b(2) + a(2)*b(1) + a(3)*b(4);

end