function mjday = get_mjday(julday)
% Calculate modified julian date from a given date
%
% Depends on:
%   get_jday
% 
% Inputs:
%   JD - julian date, days
% Outputs:
%   mjday - Time in Modified Julian Date (days since 11/14/1858 at 0h)

mjday = julday - get_jday(1858, 11, 17, 0, 0, 0);
 
end