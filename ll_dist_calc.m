%% lat/lon distance calculator
% started 6/1/23 from https://www.mathworks.com/help/map/ref/distance.html

% lat1 = 74.95351667; % station 83 (~100 m deep)
% lon1 = 171.716;
% lat2 = 75.55196667;
% lon2 = 174.1041833;

lat1 = 39.32; % catalyst project
lon1 = -74.4909;
lat2 = 39.2579;
lon2 = -74.3633;

wgs84 = wgs84Ellipsoid("nm");
d = distance(lat1,lon1,lat2,lon2,wgs84) % in m
% dist = d./1000 % in km

%%
load ADC_nuts.mat;
Stations = unique(ADC_nuts(:,3));
Stations = [1:102];
for i = 1:length(Stations);
    tmpind = find(ADC_nuts(:,3)==Stations(i));
        StationInd(i,1) = Stations(i);
        StationInd(i,2) = tmpind(1);
        StationInd(i,3) = tmpind(end);
end
clear tmpind i;

% stations 80-64, rows 64-80

nut_lats = ADC_nuts(StationInd(64:80,2),6);
nut_lons = ADC_nuts(StationInd(64:80,2),7);

lat1 = 75.55183333; % station 80 (~211 m deep)
lon1 = 174.1041667;
d = distance(lat1,lon1,nut_lats,nut_lons,wgs84);
dist = d./1000