function p = plot_apsides(rp, ra, aop)

x1 = R_rt2ep(deg2rad(-aop)) * [rp; 0];
x2 = R_rt2ep(deg2rad(180 - aop)) * [ra+rp; 0];

p = quiver(x1(1), x1(2), x2(1), x2(2), '--', 'ShowArrowHead', 'off',...
    'AutoScale', 'off');