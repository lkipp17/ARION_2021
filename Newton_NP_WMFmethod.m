%% 4 component mixing model
% equations from Newton et al 2013 (Schlosser lab method)
% started 4/15/17
% copied from Arctic GT folder on 6/27/19 to use with NABOS data

clear all; close all; clc;

% C is the design matrix, endmember values
    % salinity
    % d18O (permil)
    % nutrients (POs*) (nmol/kg)
    % mass conservation
% f is the fraction of each water mass for each sample
    % Atlantic
    % Pacific
    % Meteoric
    % Sea ice melt
% y is the vector of salinity/d18O/N/1 for each sample

%% load data

% % GN01
% load('/Users/Lauren/Documents/MATLAB/Arctic GT/data organization for tpd paper/TPD_summary.mat'); % data for both cruises
% TPD_sum(1:970,1) = 1; TPD_sum(971:1399) = 4;
% i = find(TPD_sum(:,1)==1 & TPD_sum(:,6)<=50 & TPD_sum(:,3)>84); % GN01, shallower than 500 m, north of 84
% cruise = [TPD_sum(i,1)];
% station = [TPD_sum(i,2)];
% pressure = [TPD_sum(i,5)];
% salt = [TPD_sum(i,8)]; 
% d18O = [TPD_sum(i,9)];
% P = [TPD_sum(i,11)];
% N = [TPD_sum(i,10)];
% dissoxy = [TPD_sum(i,13)];
% load('/Users/Lauren/Documents/MATLAB/Arctic GT/data organization for tpd paper/totalN.mat');
% N_tot = totN(i);


% % GN01 + GN04
% load('/Users/Lauren/Documents/MATLAB/Arctic GT/data organization for tpd paper/TPD_summary.mat'); % data for both cruises
% j = find(TPD_sum(:,1)==4 & TPD_sum(:,6)<=50 & TPD_sum(:,3)>84); % GN04, shallower than 500 m, north of 84
% cruise = [TPD_sum(i,1); TPD_sum(j,1)];
% station = [TPD_sum(i,2); TPD_sum(j,2)];
% pressure = [TPD_sum(i,5); TPD_sum(j,5)];
% salt = [TPD_sum(i,8); TPD_sum(j,8)]; 
% d18O = [TPD_sum(i,9); TPD_sum(j,9)];
% P = [TPD_sum(i,11); TPD_sum(j,11)];
% N = [TPD_sum(i,10); TPD_sum(j,10)];
% lat = [TPD_sum(i,3); TPD_sum(j,3)];
% lon = [TPD_sum(i,4); TPD_sum(j,4)];
% Newton_MW = [TPD_sum(i,17); TPD_sum(j,17)];
% Newton_SIM = [TPD_sum(i,16); TPD_sum(j,16)];
% Newton_ATL = [TPD_sum(i,14); TPD_sum(j,14)];
% Newton_PAC = [TPD_sum(i,15); TPD_sum(j,15)];
% Newton_WMF = [Newton_MW Newton_SIM Newton_ATL Newton_PAC];

% % ARKXXII2 (2007) from Bauch et al 2011
% load('/Users/Lauren/Documents/MATLAB/Arctic GT/Bauch_WMF_ARKXXII2.mat');
% i = find(latitude>84 & depth<=50); 
% salt = salinity(i);
% d18O = del18O(i);
% N = N(i);
% P = P(i);
% station = station(i);
% pressure = pressure(i);
% depth = depth(i);

% NABOS 2021
% load AR21_exportFeb22.mat;
% load matched_nuts.mat;

station = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','A5:A134');
salt = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','H5:H134');
d18O = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','K5:K134');
ID = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','B5:B134');
N = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','U5:U134');
P = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','V5:V134');
pressure = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','F5:F134'); % actually depth

%% ANP method
% P_atl = (N + 3)./17.5;
% P_pac = (N + 10.75)./13.93;

% FOR NEWTON NUMBERS: USE THESE EQUATIONS + MW d18O = -19
P_atl = (N + 2)./17;
P_pac = (N + 11)./14;

ANP = abs(P - P_atl)./(P_pac-P_atl);

WMFStations = unique(station);
for i = 1:length(WMFStations);
    tmpind = find(station==WMFStations(i));
        WMFStationInd(i,1) = WMFStations(i);
        WMFStationInd(i,2) = tmpind(1);
        WMFStationInd(i,3) = tmpind(end);
end

% remove ice samples
WMFStationInd(40,2) = 58;
WMFStationInd(43,2) = 62;
WMFStationInd(69,:)=[];

% fix duplicate 2 m sample at station 89
WMFStationInd(64,2) = 112;

clear i ind

for i = 1:length(WMFStationInd)
    iS = salt(WMFStationInd(i,2):WMFStationInd(i,3));
    id18O = d18O(WMFStationInd(i,2):WMFStationInd(i,3));
    iANP = ANP(WMFStationInd(i,2):WMFStationInd(i,3));
    ipres = pressure(WMFStationInd(i,2):WMFStationInd(i,3));
    m = min(ipres);
    surf = find(ipres == m);


    for j = 1:length(iS)
    y = [iS(j); id18O(j); iANP(j); 1];    

    C = [34.92 32.5 0 4; 
        0.3 -1.1 -19 id18O(surf)+2.6; 
        0 1 0 iANP(surf);
        1 1 1 1];

    f = (C^-1)*y
    fractions(j,:) = f';
    end
        output(WMFStationInd(i,2):(WMFStationInd(i,2)+length(ipres)-1),:) = [WMFStationInd(i,1)*ones(size(ipres)) fractions];
        clear fractions iS id18O iANP ipres m surf
end
% Atl Pac MW SIM
sum = output(:,2:5).*100;