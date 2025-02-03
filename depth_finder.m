%% depth at a given location
% started 3/29/23

load etopo2_arctic.mat;
% latitude = rows, longitude = columns

%% lat/lon of interest

lat_in = 73.8805;
lat_diff = abs(LAT(:,1)-lat_in);
min_lat_diff = min(lat_diff);
lat_ind = find(lat_diff==min_lat_diff);

lon_in = 168.0615667;
   if lon_in>0
       lon_in = lon_in - 360;
   elseif lon_in == lon_in
   end

lon_diff = abs(LON(1,:)-lon_in);
min_lon_diff = min(lon_diff);
lon_ind = find(lon_diff==min_lon_diff);

depth = data(lat_ind,lon_ind)

%% map
% addpath(genpath('/Users/Lauren/Documents/MATLAB/m_map'));
% map(73,84,115,194);
