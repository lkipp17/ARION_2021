%% Ra and Si fluxes

load AR21_Aug22.mat;
AR21(1:3,:) = []; % delete station 0
load Nuts_May22.mat;
Nuts(1:24,:) = [];  % delete station 0
Stations = unique(Nuts(:,4));
for i = 1:length(Stations);
    tmpind = find(Nuts(:,4)==Stations(i));
        StationInd(i,1) = Stations(i);
        StationInd(i,2) = tmpind(1);
        StationInd(i,3) = tmpind(end);
end
clear tmpind i;

Ra_stns = unique(AR21(:,1));
for i = 1:length(Ra_stns);
    tmpind = find(AR21(:,1)==Ra_stns(i));
        Ra_StationInd(i,1) = Ra_stns(i);
        Ra_StationInd(i,2) = tmpind(1);
        Ra_StationInd(i,3) = tmpind(end);
end
clear tmpind i;

l = 2.29352E-07; % min-1

% TPD avg
i_Ra = find(AR21(:,1)>43 & AR21(:,1) <49 & AR21(:,6)<60);
TPD_Ra = nanmean(AR21(i_Ra,10)).*10./l

i_S = find(Nuts(:,4)>43 & Nuts(:,4)<49 & Nuts(:,9)<60);
TPD_Si = nanmean(Nuts(i_S,58))

TPD_SiRa = TPD_Si/TPD_Ra

% shelf avg
i_Ra = find(AR21(:,1)>83 & AR21(:,1) <90 & AR21(:,6)<60);
shelf_Ra = nanmean(AR21(i_Ra,10)).*10./l
max_shelf_Ra = max(AR21(i_Ra,10))
min_shelf_Ra = min(AR21(i_Ra,10))

i_S = find(Nuts(:,4)>83 & Nuts(:,4)<90 & Nuts(:,9)<60);
shelf_Si = nanmean(Nuts(i_S,58))

shelf_SiRa = shelf_Si/shelf_Ra

% offshore avg - using stations west of TPD signal to avoid Pacific influence
i_Ra = find(AR21(:,1) <41 & AR21(:,6)<60);
off_Ra = nanmean(AR21(i_Ra,10)).*10./l

i_S = find(Nuts(:,4)<41 & Nuts(:,9)<60);
off_Si = nanmean(Nuts(i_S,58))

off_SiRa = off_Si/off_Ra

% delta ratio
del = (shelf_Si-off_Si)/(shelf_Ra-off_Ra)

%% Ra inventory over shelf
% avg concentration of inflowing waters = 8.425	dpm/100L
Ra_in = 8.425.*10/l; % atoms/m3
Ra_xs = shelf_Ra - Ra_in

Ra_xs_inv = Ra_xs*60 % atoms/m2
Ra_shelf_inv = shelf_Ra*60
