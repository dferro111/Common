function DCM = EulerAngle2DCM(a, b, c, seq)
% Converts Euler angles to DCM
% 
% Inputs: 
%   a, b, c - Angles of rotation, rad
%   seq - Angle sequence entered as a 3 digit number
% Outputs:
%   DCM - Direction Cosine Matrix
% 
% DCM = EulerAngle2DCM(a, b, c, seq)

% Extract Sequence
tmp = seq;
r1 = floor(tmp / 100);
tmp = tmp - r1 * 100;
r2 = floor(tmp / 10);
tmp = tmp - r2 * 10;
r3 = tmp;

% Construct DCM
if r1 == 3
    A = R3(a);
elseif r1 == 2
    A = R2(a);
elseif r1 == 1
    A = R1(a);
else
    DCM = 0;
    return
end

if r2 == 3
    B = R3(b);
elseif r2 == 2
    B = R2(b);
elseif r2 == 1
    B = R1(b);
else
    DCM = 0;
    return
end

if r3 == 3
    C = R3(c);
elseif r3 == 2
    C = R2(c);
elseif r3 == 1
    C = R1(c);
else
    DCM = 0;
    return
end

DCM = C*B*A;

