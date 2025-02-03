load CTD_trace.mat;

Stations = meta(:,1);
for i = 1:length(Stations);
    tmpind = find(data(:,1)==Stations(i));
        StationInd(i,1) = Stations(i);
        StationInd(i,2) = tmpind(1);
        StationInd(i,3) = tmpind(end);
end
clear tmpind i;


for i = 1:length(Stations);
    Lat(StationInd(i,2):StationInd(i,3)) = meta(i,2);
    Lon(StationInd(i,2):StationInd(i,3)) = meta(i,3);
end
export = [Lat' Lon' data];

