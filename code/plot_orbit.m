function p = plot_orbit(a, e, tRange, aop, color, varargin)
% Input all angles ad degrees

if length(tRange) > 2
    t = deg2rad(tRange);
else
    nn = 500;
    t = deg2rad(linspace(tRange(1), tRange(end), nn));
end
aop = deg2rad(aop);
ta = t - aop;
for ii = 1:nn
    r = (a*(1-e^2)) / (1 + e*cos(t(ii)));
    x(:,ii) = R_rt2ep(ta(ii)) * [r; 0];
end

p = plot(x(1,:), x(2,:), 'color', color, varargin{:});