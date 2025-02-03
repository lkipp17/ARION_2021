%% average shelf Ra
% started 4/5/23
% copied first few lines from Ra_Si_flux.m
% updated 5/25/23 with finalized ADC datasets

% load AR21_Aug22.mat;
% AR21(1:3,:) = []; % delete station 0
load ADC_radium.mat;

% load Nuts_May22.mat;
% Nuts(1:24,:) = [];  % delete station 0
% Stations = unique(Nuts(:,4));
% for i = 1:length(Stations);
%     tmpind = find(Nuts(:,4)==Stations(i));
%         StationInd(i,1) = Stations(i);
%         StationInd(i,2) = tmpind(1);
%         StationInd(i,3) = tmpind(end);
% end
% clear tmpind i;

Ra_stns = unique(ADC_radium(:,2));
for i = 1:length(Ra_stns);
    tmpind = find(ADC_radium(:,2)==Ra_stns(i));
        Ra_StationInd(i,1) = Ra_stns(i);
        Ra_StationInd(i,2) = tmpind(1);
        Ra_StationInd(i,3) = tmpind(end);
end
clear tmpind i;

l = 2.29352E-07; % min-1

%% shelf avg
i_Ra = find(ADC_radium(:,2)>83 & ADC_radium(:,2) <90 & ADC_radium(:,6)<60);
shelf_Ra = mean(ADC_radium(i_Ra,11)).*10./l
stdev_Ra = std(ADC_radium(i_Ra,11)).*10./l
shelf_Ra = mean(ADC_radium(i_Ra,11))
stdev_Ra = std(ADC_radium(i_Ra,11))
max_shelf_Ra = max(ADC_radium(i_Ra,11))
min_shelf_Ra = min(ADC_radium(i_Ra,11))

%% surface RAR avg

