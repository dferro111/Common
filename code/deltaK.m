function v = deltaK(i, j)
% Evaluates Kronecker delta
% returns 1 if i = j and 0 otherwise

MATLABZERO = 1e-16;
if (abs(i-j) > MATLABZERO)
    v = 0;
else
    v = 1;
end
end