function val = CheckQuadrant(sine, cosine)
% Fix the quadrant of an angle returned from double values trig functions
% 
% Inputs:
%   sine - result from asind, deg
%   cosine - result from acosd, deg
% Outputs:
%   val - angle in the correct quadrant

if abs((sine - cosine)) < 1e-12
    val = sine;
elseif abs(((180 - sine) - cosine)) < 1e-12
    val = 180 - sine;
elseif abs((sine - -cosine)) < 1e-12
    val = sine;
elseif abs(((180 - sine) - -cosine)) < 1e-12
    val = 180 - sine;
else
    fprintf('Check failed\n');
    val = NaN;
end