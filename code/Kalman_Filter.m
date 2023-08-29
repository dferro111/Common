function [mhatk, mhatkm1, Phatk, Pbark] = Kalman_Filter(m0, P0, t, ...
    z, R, F)
% Function for a linear Kalman Filter
% 
% Inputs:
%   m0 - initial state estimate
%   P0 - initial state covariance
%   t - time history of measurements
%   z - measurements at each time
%   R - measurement covariance
%   F - dynamics matrix
% Output:
%   xhatk - predicted state at each time
%   Phatk - predicted covariance at each time
% 
% Assumes: F is linear and neq F(t)

% Intial state
tkm1 = t(1);
mhatkm1(:,1) = m0;
Phatkm1(:,:,1) = P0;
Phi = eye(length(mhatkm1(:,1)));

n = length(t);
for ii = 1:n
    tk = t(ii);
    zk = z(2*ii-1:2*ii);
    Rk = R(:,:,ii);
    
    % Integrate STM
    if (tk > t(1))
        Phi = expm(F*(tk-tkm1));
    end

    % Compute values at tk
    mbark = Phi*mhatkm1(:,ii);
    Pbark(:,:,ii) = Phi*Phatkm1(:,:,ii)*Phi';

    % Compute residual    
    Ht = [1 0 0 0 0 0;
        0 1 0 0 0 0];
    
    % Update measurement
    Wk = Ht * Pbark(:,:,ii) * Ht' + Rk;
    Ck = Pbark(:,:,ii) * Ht';
    Kk = Ck / Wk;
    mhatk(:,ii) = mbark + Kk*(zk - Ht*mbark);
    Phatk(:,:,ii) = Pbark(:,:,ii) - Ck * Kk' - Kk * Ck' + Kk * Wk * Kk';

    % Reset and iterate
    mhatkm1(:,ii+1) = mhatk(:,ii);
    Phatkm1(:,:,ii+1) = Phatk(:,:,ii);
    tkm1 = tk;
end


