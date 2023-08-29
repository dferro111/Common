function plot_asymptotes(arp, leng, delta, aop, varargin)

c = [arp ; 0];
delta = 180 - delta;
asymp1 = leng * [cosd(delta/2); sind(delta/2)];
asymp2 = leng * [cosd(delta/2); -sind(delta/2)];
asymp1m = leng * [-cosd(delta/2); sind(delta/2)];
asymp2m = leng * [-cosd(delta/2); -sind(delta/2)];

R = R_rt2ep(-deg2rad(aop));
c = R * c;
asymp1 = R * asymp1;
asymp2 = R * asymp2;
asymp1m = R * asymp1m;
asymp2m = R * asymp2m;

p(1) = quiver(c(1), c(2), asymp1(1), asymp1(2), 'off', 'LineStyle','--', ...
    'ShowArrowHead','off', varargin{:});
quiver(c(1), c(2), asymp1m(1), asymp1m(2), 'off', 'LineStyle','--', ...
    'ShowArrowHead','off', varargin{:});
quiver(c(1), c(2), asymp2(1), asymp2(2), 'off', 'LineStyle','--', ...
    'ShowArrowHead','off', varargin{:});
quiver(c(1), c(2), asymp2m(1), asymp2m(2), 'off', 'LineStyle','--', ...
    'ShowArrowHead','off', varargin{:});
