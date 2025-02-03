%% Ra v. fMET, updated w/ both sets of 2015 data & TPD synthesis WMF
% copied from Ra v fMET script in Arctic GT folder
% started 5/13/19
% updated 6/26/19 with 2018 NABOS data

clear all; close all; clc;

load('/Users/kipp/Documents/MATLAB/TPD_summary.mat'); % data for both cruises
TPD_sum(1:970,1) = 1; TPD_sum(971:1399) = 4;
i = find(TPD_sum(:,1)==1 & TPD_sum(:,6)<=50 & TPD_sum(:,3)>84); % GN01, shallower than 500 m, north of 84
% j = find(TPD_sum(:,1)==4 & TPD_sum(:,6)<=50 & TPD_sum(:,3)>84); % GN04, shallower than 500 m, north of 84
j = find(TPD_sum(:,1)==4 & TPD_sum(:,6)<=50); % GN04, shallower than 500 m, north of 84
k1 = 82;
WMF_2015 = [TPD_sum(i,17); TPD_sum(j,17)]; 
Ra_2015 = [TPD_sum(i,k1); TPD_sum(j,k1)];
k2 = 83;
Ra_err_2015 = [TPD_sum(i,k2); TPD_sum(j,k2)];
k3 = 98;
RAR_2015 = [TPD_sum(i,k3); TPD_sum(j,k3)];
k4 = 99;
RAR_err_2015 = [TPD_sum(i,k4); TPD_sum(j,k4)];

load('/Users/kipp/Documents/MATLAB/ARKXXII2_Ra_WMF.mat');
m = find(ARKXXII2_Latitude>85);
WMF_2007 = ARKXXII2_frac_riv(m);
Ra_2007 = ARKXXII2_Ra228(m)./10;
Ra_err_2007 = ARKXXII2_Ra228_err(m)./10;
RAR_2007 = ARKXXII2_Ra228_Ra226(m);
RAR_err_2007 = ARKXXII2_Ra228_Ra226_err(m);

% PS-78 (2011)
Ra_2011 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','PS78','K6:K44')./10;
Ra_err_2011 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','PS78','L6:L44')./10;
% RAR_2011 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','PS78','K6:K44')./xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','PS78','I6:I44');
WMF_2011 = [xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','PS78','P6:P44'); NaN; NaN;];

% NABOS 2017
load('/Users/kipp/Documents/MATLAB/NABOS_2018/NABOS_data_041719.mat','Ra228');
Ra_2018 = Ra228;
load('/Users/kipp/Documents/MATLAB/NABOS_2018/NABOS_data_041719.mat','Ra228_err');
Ra_err_2018 = Ra228_err;
% load('/Users/kipp/Documents/MATLAB/NABOS_2017/NABOS_fMET_062619.mat');
load('/Users/kipp/Documents/MATLAB/ARION_2021/NABOS_2018_WMF_3end.mat');
WMF_2018 = fractions(:,2).*100;
SIM_2018 = fractions(:,3).*100;

% ARION/NABOS 2021
%3 endmembers
load('/Users/kipp/Documents/MATLAB/ARION_2021/NABOS_2021_WMF_3end.mat');
WMF_2021 = fractions(:,2).*100;
SIM_2021 = fractions(:,3).*100;
% 4 endmembers
% WMF_2021 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_WMF.xlsx','water isotopes','U3:U132').*100; %currently in the same order as the master spreadsheet, but keep an eye on this
stn = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','A5:A134');
% ID = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','B5:B134');
depth_2021 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','F5:F134');
Ra_2021 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','M5:M134');
Ra_err_2021 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','N5:N134');
i = find(depth_2021<=50);

C13 = [215,25,28]./255; % red
C14 = [253,174,97]./255; % orangish
C15 = [171,217,233]./255; % light blue
C16 = [44,123,182]./255; % dark blue

%% figure
i = find(depth_2021<=50 & 34<stn & stn<100);
% i = find(depth_2021<=250);

figure;
hold on
errorbar(WMF_2015,Ra_2015,Ra_err_2015,'ok');
l2 = scatter(WMF_2015,Ra_2015,100,'Filled','MarkerEdgeColor','k','MarkerFaceColor',C13);
errorbar(WMF_2007,Ra_2007,Ra_err_2007,'dk');
l4 = scatter(WMF_2007,Ra_2007,100,'Filled','d','MarkerEdgeColor','k','MarkerFaceColor',[0.5 0.5 0.5]);
errorbar(WMF_2011,Ra_2011,Ra_err_2011,'vk');
l3 = scatter(WMF_2011,Ra_2011,100,'Filled','v','MarkerEdgeColor','k','MarkerFaceColor',C15);
errorbar(WMF_2021(i),Ra_2021(i),Ra_err_2021(i),'sk');
l1 = scatter(WMF_2021(i),Ra_2021(i),100,'Filled','s','MarkerEdgeColor','k','MarkerFaceColor',C14);
xlabel('% meteoric water'); ylabel('^{228}Ra (dpm 100L^{-1})'); xlim([0 30]); ylim([0 35]);
good_titles(20);   
legend([l1 l2 l3 l4],{'2021 (ESAS)' '2015 (>84N)' '2011' '2007 (>84N)'},'location','northwest');

%% 2018 & 2021 MET
figure;
hold on
errorbar(WMF_2018,Ra_2018,Ra_err_2018,'ok');
l2 = scatter(WMF_2018,Ra_2018,150,'Filled','MarkerEdgeColor','k','MarkerFaceColor',C16); % [0.4 0.4 0.4]
errorbar(WMF_2021(i),Ra_2021(i),Ra_err_2021(i),'ok');
l3 = scatter(WMF_2021(i),Ra_2021(i),150,'Filled','MarkerEdgeColor','k','MarkerFaceColor',C14);
xlabel('% meteoric water'); ylabel('^{228}Ra (dpm 100L^{-1})'); 
% xlim([0 25]); ylim([0 25]);
good_titles(20);   
legend([l2 l3],{'2018' '2021'},'location','northwest');

%% 2018 & 2021 MET- TPD
i = find(depth_2021<=50 & 35<stn & stn<53);

figure;
hold on
errorbar(WMF_2018,Ra_2018,Ra_err_2018,'ok');
l2 = scatter(WMF_2018,Ra_2018,150,'Filled','MarkerEdgeColor','k','MarkerFaceColor',C16); % [0.4 0.4 0.4]
errorbar(WMF_2021(i),Ra_2021(i),Ra_err_2021(i),'ok');
l3 = scatter(WMF_2021(i),Ra_2021(i),150,'Filled','MarkerEdgeColor','k','MarkerFaceColor',C14);
xlabel('% meteoric water'); ylabel('^{228}Ra (dpm 100L^{-1})'); 
xlim([0 35]); ylim([0 35]);
good_titles(20);   
legend([l2 l3],{'2018' '2021'},'location','northwest');

%% 2018 & 2021 SIM
figure;
hold on
errorbar(SIM_2018,Ra_2018,Ra_err_2018,'ok');
l2 = scatter(SIM_2018,Ra_2018,150,'Filled','MarkerEdgeColor','k','MarkerFaceColor',C16); % [0.4 0.4 0.4]
errorbar(SIM_2021(i),Ra_2021(i),Ra_err_2021(i),'ok');
l3 = scatter(SIM_2021(i),Ra_2021(i),150,'Filled','MarkerEdgeColor','k','MarkerFaceColor',C14);
xlabel('% sea ice melt'); ylabel('^{228}Ra (dpm 100L^{-1})'); 
% xlim([0 25]); ylim([0 25]);
good_titles(20);   
legend([l2 l3],{'2018' '2021'},'location','northwest');

%% RAR figure
figure;
errorbar(fMET.*100,RAR,RAR_err,'ok');
hold on
l1 = scatter(fMET.*100,RAR,150,'Filled','MarkerEdgeColor','k','MarkerFaceColor',C13);
errorbar(WMF_2015,RAR_2015,RAR_err_2015,'ok');
l2 = scatter(WMF_2015,RAR_2015,150,'Filled','MarkerEdgeColor','k','MarkerFaceColor',C14);
errorbar(WMF_2007,RAR_2007,RAR_err_2007,'ok');
l3 = scatter(WMF_2007,RAR_2007,150,'Filled','MarkerEdgeColor','k','MarkerFaceColor',C15);
xlabel('% meteoric water'); ylabel('^{228}Ra/^{226}Ra'); xlim([0 25]); ylim([0 3]);
good_titles(20);   
legend([l1 l2 l3],{'2018 (NABOS)' '2015 (GN01)' '2007 (GIPY11)'},'location','northwest');