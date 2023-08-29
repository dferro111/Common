function p = plot_circle(x,y,r,c)

nn = 500;
ta = linspace(0, 2*pi, nn);
for ii = 1:nn
    s(:,ii) = R_rt2ep(ta(ii)) * [r; 0];
end

p = plot(s(1,:)+x, s(2,:)+y, 'color', c);
fill(s(1,:)+x,s(2,:)+y, c, 'EdgeColor',c)