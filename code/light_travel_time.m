function tau = light_travel_time(rsatrec, R)
% Calculates light travel time

% Inputs
%   rsatrec - satrec of the object
%   R - topocenter of the observer
% Output
%   tau - light travel time, sec

c = 299792458/1000; % km/s

tau = 0; 
diff = 100; % set to enter loop
while diff > 1e-7
    tmp = tau; % store previous tau
    [~, rt, ~] = sgp4(rsatrec, -tau); % propogate back
    tau = (1/c)*abs(norm(rt) - norm(R)); % calcuulate tau
    diff = tau - tmp; % check the difference with the previous tau
end