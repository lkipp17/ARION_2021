%% match Ra data to water mass fractions for ODV
% started 2/9/17
clear all; close all;
% load Ra_010417
Ra226 = xlsread('/Users/Lauren/Documents/Research/Arctic GEOTRACES/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','ArcticODV.txt','K2:K310');
Ra226error = xlsread('/Users/Lauren/Documents/Research/Arctic GEOTRACES/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','ArcticODV.txt','L2:L310');
Ra228 = xlsread('/Users/Lauren/Documents/Research/Arctic GEOTRACES/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','ArcticODV.txt','N2:N310');
Ra228error = xlsread('/Users/Lauren/Documents/Research/Arctic GEOTRACES/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','ArcticODV.txt','O2:O310');
Depth = xlsread('/Users/Lauren/Documents/Research/Arctic GEOTRACES/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','ArcticODV.txt','I2:I310');
Ra_Station = xlsread('/Users/Lauren/Documents/Research/Arctic GEOTRACES/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','ArcticODV.txt','F2:F310');
Ra_Station = [-2; -1; Ra_Station];

load GT2015_WMF_recalc;
load('/Users/Lauren/Documents/MATLAB/Arctic GT/Schlosser_data.mat');
addpath(genpath('/Users/Lauren/Documents/MATLAB/Arctic GT/seawater toolbox'));
DEPTH = sw_dpth(ctdprs,Latitude);

WMFStations = unique(Station(:,1));
for i = 1:61 %length(WMFStations);
    tmpind = find(Station(:,1)==WMFStations(i));
        WMFStationInd(i,1) = WMFStations(i);
        WMFStationInd(i,2) = tmpind(1);
        WMFStationInd(i,3) = tmpind(end);
end

WMFStationInd(58,:) =[]; %(station 63)

RaStations = unique(Ra_Station(:,1));
for i = 1:length(RaStations);
    tmpind = find(Ra_Station(:,1)==RaStations(i));
        RaStationInd(i,1) = RaStations(i);
        RaStationInd(i,2) = tmpind(1);
        RaStationInd(i,3) = tmpind(end);
end
clear i
RaStationInd(1:2,:) =[]; RaStationInd(42,:) =[]; RaStationInd(42,:) =[];
RaStationInd(39,:) =[]; RaStationInd(31,:) =[]; RaStationInd(33,:) =[];
RaStationInd(32,:) =[];

%
for i = 1:60;
    
depth_Ra = Depth(RaStationInd(i,2):RaStationInd(i,3));
iRa228 = Ra228(RaStationInd(i,2):RaStationInd(i,3));
iRa228error = Ra228error(RaStationInd(i,2):RaStationInd(i,3));
iRa226 = Ra226(RaStationInd(i,2):RaStationInd(i,3));
iRa226error = Ra226error(RaStationInd(i,2):RaStationInd(i,3));
depth_WMF = DEPTH(WMFStationInd(i,2):WMFStationInd(i,3));
isalinity = Salinity(WMFStationInd(i,2):WMFStationInd(i,3));
ifmet = output(WMFStationInd(i,2):WMFStationInd(i,3),1);
% iLAT = LATITUDE(WMFStationInd(i,2):WMFStationInd(i,3));

% d = depth_Ra < 500;
% depth_Ra = depth_Ra(d);
 for j = 1:length(depth_Ra);
     indWMF = find(depth_WMF-5 <= depth_Ra(j) & depth_Ra(j) <= depth_WMF + 5);
     SAL(j,1) = mean(isalinity(indWMF));
     MET(j,1) = mean(ifmet(indWMF));
%      LAT(j,1) = mean(iLAT(indWMF));
 end
 AA(RaStationInd(i,2):(RaStationInd(i,2)+length(depth_Ra)-1),:) = [RaStationInd(i,1)*ones(size(depth_Ra)) depth_Ra SAL MET iRa228 iRa228error iRa226 iRa226error];
 clear SAL MET iRa228 LAT
end
