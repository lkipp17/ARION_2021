
load AR21_exportFeb22.mat;
load Hydrochem_bottles.mat;

Stations = unique(Bottles(:,4));
Stations = Stations(2:103); % delete station 0
for i = 1:length(Stations);
    tmpind = find(Bottles(:,4)==Stations(i));
        StationInd(i,1) = Stations(i);
        StationInd(i,2) = tmpind(1);
        StationInd(i,3) = tmpind(end);
end
clear tmpind i;

Ra_stns = unique(AR21_Feb22(:,1));
Ra_stns = Ra_stns(2:73); % delete station 0
for i = 1:length(Ra_stns);
    tmpind = find(AR21_Feb22(:,1)==Ra_stns(i));
        Ra_StationInd(i,1) = Ra_stns(i);
        Ra_StationInd(i,2) = tmpind(1);
        Ra_StationInd(i,3) = tmpind(end);
end
clear tmpind i;
% 
% % Ra_stns(1,1) = 200; Stations (1,1) = 200; StationInd(1,1) = 200; Ra_StationInd(1,1) = 200; % changing from 0 to 200 because next line wouldn't work with 0s
% StationInd(1,1) = NaN; Ra_StationInd(1,1) = NaN; Ra_stns = Ra_stns(2:73);
% match_stns = StationInd(Ra_stns,:);
% tmpind = find(Stations == Ra_stns);

match_stns = StationInd(Ra_stns,:);

for i = 1:length(match_stns);
    idepth_Ra = Depth(Ra_StationInd(i,2):Ra_StationInd(i,3));
    idepth_CTD = Bottles(match_stns(i,2):match_stns(i,3),9);
    isal = Bottles(match_stns(i,2):match_stns(i,3),13);
    iT = Bottles(match_stns(i,2):match_stns(i,3),11);

    for j = 1:length(idepth_Ra);
        ind_sal = find(idepth_CTD-5 <= idepth_Ra(j) & idepth_Ra(j) <= idepth_CTD + 5);
        isalinity(j) = mean(isal(ind_sal));
        itemperature(j) = mean(iT(ind_sal));
%         if isnan(isalinity(j))
%             ind_dens2 = find(idepth_CTD-3 <= idepth_Ra(j) & idepth_Ra(j) <= idepth_CTD + 3);
%             isalinity(j) = mean(idens(ind_dens2));
%         end
    end
    
    Salinity(Ra_StationInd(i,2):Ra_StationInd(i,3)) = isalinity;
    Temperature(Ra_StationInd(i,2):Ra_StationInd(i,3)) = itemperature;
    clear idepth_Ra idepth_CTD isal iT isalinity itemperature
end