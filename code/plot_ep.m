function q = plot_ep(s)


% ep
ehat = [s; 0];
phat = [0; s];
q(1) = quiver(0,0,ehat(1), ehat(2), 'm');
q(2) = quiver(0,0,phat(1), phat(2), 'y');