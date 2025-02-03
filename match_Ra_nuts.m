% updated 4/23 with final nutrient & radium data uploaded to ADC
% changed variable names in script accordingly

% load AR21_Apr22.mat;
% load Nuts_May22.mat;

load ADC_nuts.mat; 
load ADC_radium.mat;


Stations = unique(ADC_nuts(:,3));
Stations = [1:102];
for i = 1:length(Stations);
    tmpind = find(ADC_nuts(:,3)==Stations(i));
        StationInd(i,1) = Stations(i);
        StationInd(i,2) = tmpind(1);
        StationInd(i,3) = tmpind(end);
end
clear tmpind i;

Ra_stns = unique(ADC_radium(:,2));
Ra_stns = Ra_stns(2:73); % delete station 0 because array must be positive integers
for i = 1:length(Ra_stns);
    tmpind = find(ADC_radium(:,2)==Ra_stns(i));
        Ra_StationInd(i,1) = Ra_stns(i);
        Ra_StationInd(i,2) = tmpind(1);
        Ra_StationInd(i,3) = tmpind(end);
end
clear tmpind i;

match_stns = StationInd(Ra_stns,:);

for i = 1:length(match_stns);
    idepth_Ra = ADC_radium(Ra_StationInd(i,2):Ra_StationInd(i,3),6);
    idepth_CTD = ADC_nuts(match_stns(i,2):match_stns(i,3),9);
    iN = ADC_nuts(match_stns(i,2):match_stns(i,3),25);
    iP = ADC_nuts(match_stns(i,2):match_stns(i,3),23);
    iS = ADC_nuts(match_stns(i,2):match_stns(i,3),21);

    for j = 1:length(idepth_Ra);
        ind_sal = find(idepth_CTD-5 <= idepth_Ra(j) & idepth_Ra(j) <= idepth_CTD + 5 & ~isnan(iN));
        initrogen(j) = mean(iN(ind_sal));
        iphosphate(j) = mean(iP(ind_sal));
        isilicate(j) = mean(iS(ind_sal));
%         if isnan(isalinity(j))
%             ind_dens2 = find(idepth_CTD-3 <= idepth_Ra(j) & idepth_Ra(j) <= idepth_CTD + 3);
%             isalinity(j) = mean(idens(ind_dens2));
%         end
    end
    
    Nitrogen(Ra_StationInd(i,2):Ra_StationInd(i,3)) = initrogen;
    Phosphate(Ra_StationInd(i,2):Ra_StationInd(i,3)) = iphosphate;
    Silicate(Ra_StationInd(i,2):Ra_StationInd(i,3)) = isilicate;
    Depth(Ra_StationInd(i,2):Ra_StationInd(i,3)) = idepth_Ra;
    Station(Ra_StationInd(i,2):Ra_StationInd(i,3)) = Ra_StationInd(i,1);
    clear idepth_Ra idepth_CTD iP iN iphosphate initrogen isilicate
end

nutrients = [Nitrogen' Phosphate' Silicate';];
sum = [Station' Depth' nutrients];