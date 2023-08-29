function res = find_furthest_tle(filename)
% Finds the TLE that has the largest apoapsis distance out of the input tle
% file.
% 
% Inputs:
%   filename - path to file
% Outputs:
%   res - name and twoline2rv structure

[obj, cc, names] = parse_tle(filename);

idx = find([obj.satrec(:).alta] == max([obj.satrec(:).alta]));
name = names{idx(end)};

res.name = name;
res.r = obj.r(:,idx(end));
res.v = obj.v(:,idx(end));
res.satrec = obj.satrec(idx(end));

