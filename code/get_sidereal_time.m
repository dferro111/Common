function time = get_sidereal_time(JD, approx)
% Function to calculate Greenwich Mean Sidereal Time using full definition
% or an approximation.
% 
% Inputs:
%   JD - julian date of the time in UT, days
%   approx - flag to determine method of calculation
% Outputs:
%   time - Greenwich mean sidereal time, hr

% Conversion factors
days2sec = 24*60*60;
sec2hr = 1/60/60;

% Calculate JD0
JD0 = JD - mod(JD, 1);
if mod(JD, 1) > 0.5
    JD0 = JD0 + 0.5;
else
    JD0 = JD0 - 0.5;
end

% Calculate T parameters
T0 = (JD0 - 2451545) / 36525;
T1 = (JD - 2451545) / 36525;

% Time of day in seconds
UT = (JD - JD0) * days2sec;

if (approx)
    time = 6.664520 + 0.0657098244 * (JD0 - 2451544.5) ...
            + 1.0027279093 * (UT * sec2hr);
else
    time = 24110.54841 + 8640184.812866 * T0 + 0.093104 * T1^2 ...
            - 0.0000062 * T1^3 + 1.0027279093 * UT;
    time = time * sec2hr;
end

% Force the time to wrap every 24 hours
time = mod(time, 24);

end