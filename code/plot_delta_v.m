function p = plot_delta_v(r, ta, v1, fpa1, v2, fpa2, s)

ta = deg2rad(ta);
rep = R_rt2ep(ta) * [r;0];
v1ep = R_rt2ep(ta) * v1*[sind(fpa1); cosd(fpa1)]*s;
v1epn = v1ep / norm(v1ep);
v2ep = R_rt2ep(ta) * v2*[sind(fpa2); cosd(fpa2)]*s;

deltaVep = v2ep - v1ep;

p(1) = quiver(rep(1)+v1ep(1), rep(2)+v1ep(2), s/2*v1epn(1), s/2*v1epn(2));
p(2) = quiver(rep(1)+v1ep(1), rep(2)+v1ep(2), deltaVep(1), deltaVep(2),...
    'AutoScale', 'off');
