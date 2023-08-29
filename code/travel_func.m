function t = travel_func(r, obj)
% Calculates the travel function for a given object type.
% 
% Inputs:
%   r - distance from the object to observer, m
%   obj - type of the object
%           Ex:
%              'lambertian sphere'
%              'specular plate'
% Outputs:
%   t - travel function

% Determine travel function from object type
if contains(obj, 'sphere')
    if contains(obj, 'lambert')
        t = 1 / (2*pi * r^2); % Lambertian sphere
    elseif contains(obj, 'spec')
        t = 1; % Specular sphere
    end
elseif contains(obj, 'plate')
    if contains(obj, 'lambert')
        t = 1 / r^2; % lambertian plate
    elseif contains(obj, 'spec')
        t = 1; % specular plate
    end
else
    t = NaN;
end

end