function obj = grab_tle_data_str(s)
% read in a TLE object, retrive osculating state 
%
%
%
% Author: C. Frueh
% creation date  9/5/2017
% last modified: 8/25/2019
% 
% Modified by: Dominic Ferro
% - modified to act as a function and accept a TLE string cell and return
% object information. Designed for use in loops to grab data from many TLEs
% 
% 
% inputs: TLE file
% dependencies: vallado subroutines as uploaded on BB
% - twoline2rv and its dependencies
% - sgp4 and its dependencies
% 
% error corrections:
% ..

[satrec, startmfe, stopmfe, deltamin]=twoline2rv(721,...
                                        s{2},s{3},'c','d');

tsince = 0; % Do not propogate
% extract position and velocity
[satrec, r, v] = sgp4(satrec,tsince);

% Save data to object
obj.satrec = satrec;
obj.r = r;
obj.v = v;
obj.startmfe = startmfe;
obj.stopmfe = stopmfe;
obj.deltamin = deltamin;

