function jday = get_jday(year, month, day, hr, min, sec)
% Calculate Julian Date for a given date
% 
% Inputs:
%   year - input of the form xxxx (i.e. 2022)
%   month - value between 1-12
%   day - day of the month no larger than the day of the moth
%   hr - hours in UTC
%   min - minutes
%   sec - seconds
% Outputs:
%   jday - Time in Julian Date (days since 1/1/4713 BCE at 12h)


% Convert minutes/seconds to fraction day
min = min + sec / 60;
hr = hr + min / 60;
day = day + hr / 24;

% Determine y and m based on the month
if (month <= 2)
    y = year - 1;
    m = month + 12;
else
    y = year;
    m = month;
end

% Determine B term
if (year == 1582)
    if (month <= 10 && day <= 4)
        B = -2;
    end
elseif (year < 1582)
    B = -2;
elseif (year > 1582)
    B = floor(y/400) - floor(y/100);
else
    fprintf('ERROR: Dates between 10/4/1582 and 10/15/1582 do not exist!');
end

% Calculate JD
jday = floor(365.25*y) + floor(30.6001*(m+1)) + B + 1720996.5 + day;
end