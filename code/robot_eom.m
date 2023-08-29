function xdot = robot_eom(t, x, F)

if size(x,1) < size(x,2)
    x = x';
end

xdot = F*x;