%% Ra v. fMET for eastern shelves
% copied from Ra_fMET.m
% started 6/7/22

clear all; close all; clc;

% RVDL 2003, all surf
% Ra_2003 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','RVDL_2003','J4:J44')./10;
% Ra_err_2003 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','RVDL_2003','K4:k44')./10;
% WMF_2003 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','RVDL_2003','P4:P44');
Ra_2003 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','RVDL_2003','J25:J44')./10;
Ra_err_2003 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','RVDL_2003','K25:k44')./10;
RAR_2003 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','RVDL_2003','L25:L44');
RAR_err_2003 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','RVDL_2003','M25:M44');
WMF_2003 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','RVDL_2003','P25:P44');

Ra_L = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','RVDL_2003','J4:J6')./10;
Ra_err_L = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','RVDL_2003','K4:k6')./10;
RAR_L = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','RVDL_2003','L4:L6')./10;
RAR_err_L = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','RVDL_2003','M4:M6')./10;
WMF_L = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','RVDL_2003','P4:P6');

% load('/Users/kipp/Documents/MATLAB/ARKXXII2_Ra_WMF.mat');
% m = find(ARKXXII2_Latitude>85);
% WMF_2007 = ARKXXII2_frac_riv(m);
% Ra_2007 = ARKXXII2_Ra228(m)./10;
% Ra_err_2007 = ARKXXII2_Ra228_err(m)./10;
% RAR_2007 = ARKXXII2_Ra228_Ra226(m);
% RAR_err_2007 = ARKXXII2_Ra228_Ra226_err(m);
% Depth_2007 = ARKXXII2_Depth(m);

% % PS-78 (2011), depth is all 10 m
% Ra_2011 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','PS78','K6:K44')./10;
% Ra_err_2011 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','PS78','L6:L44')./10;
% % RAR_2011 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','PS78','K6:K44')./xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','PS78','I6:I44');
% % Sal_2011 = [xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','PS78','M6:M44');NaN;];
% WMF_2011 = [xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','PS78','P6:P44');NaN;NaN];

% ARK XI/1, Laptev 1995, RVDL 2012
Ra_1995 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','RVDL_2012','R54:R194')./10;
Ra_err_1995 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','RVDL_2012','S54:S194')./10;
RAR_1995 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','RVDL_2012','T54:T194');
RAR_err_1995 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','RVDL_2012','U54:U194');
Lon_1995 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','RVDL_2012','F54:F194');
Depth_1995 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','RVDL_2012','H54:H194');
WMF_1995 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','RVDL_2012','M54:M194');

load('/Users/kipp/Documents/MATLAB/NABOS_2018/NABOS_data_041719.mat');
load('/Users/kipp/Documents/MATLAB/NABOS_2018/NABOS_fMET_062619.mat');

ID_2021 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','B5:B134');
Stn_2021 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','A5:A134');
Depth_2021 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','F5:F134');
Ra_2021 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','M5:M134');
Ra_err_2021 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','N5:N134');
RAR_2021 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','S5:S134');
% RAR_err_2021;
WMF_2021 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_WMF.xlsx','water isotopes','U3:U132').*100; %currently in the same order as the master spreadsheet, but keep an eye on this

C13 = [215,25,28]./255; % red
C14 = [253,174,97]./255; % orangish
C15 = [171,217,233]./255; % light blue
C16 = [44,123,182]./255; % dark blue

C1 = [0.2081,0.1663,0.5292];
C2 = [0.0244,0.4350,0.8755];
C3 = [0.1986,0.7214,0.6310];
C4 = [0.9856,0.7372,0.2537];
C5 = [0.9763,0.9831,0.0538];


%% all years xy plot, surface
k = find(Depth_2021<=2);
% k = find(Depth_2021<=2 & 34<Stn_2021(:,1) & Stn_2021<63);
% l = find(Depth_2021<=2 & 78<=Stn_2021 & Stn_2021<=89);
v = find(Depth_1995<=11 & Lon_1995>108);
s = find(Depth_2021<50);

figure;
hold on

errorbar(WMF_2021(k),Ra_2021(k),Ra_err_2021(k),'ok');
l4 = scatter(WMF_2021(k),Ra_2021(k),70,'o','Filled','MarkerEdgeColor','k','MarkerFaceColor',C4);

errorbar(WMF_2003,Ra_2003,Ra_err_2003,'ok');
l2 = scatter(WMF_2003,Ra_2003,70,'s','Filled','MarkerEdgeColor','k','MarkerFaceColor',C2);
errorbar(WMF_L,Ra_L,Ra_err_L,'ok');
l2 = scatter(WMF_L,Ra_L,70,'s','Filled','MarkerEdgeColor','k','MarkerFaceColor',C2);
errorbar(WMF_1995(v),Ra_1995(v),Ra_err_1995(v),'ok');
l1 = scatter(WMF_1995(v),Ra_1995(v),70,'v','Filled','MarkerEdgeColor','k','MarkerFaceColor',C1);
errorbar(fMET.*100,Ra228,Ra228_err,'ok');
l3 = scatter(fMET.*100,Ra228,70,'d','Filled','MarkerEdgeColor','k','MarkerFaceColor',[C5]);
% errorbar(WMF_2021(k),Ra_2021(k),Ra_err_2021(k),'ok');
% l4 = scatter(WMF_2021(k),Ra_2021(k),70,'o','Filled','MarkerEdgeColor','k','MarkerFaceColor',C4);
% errorbar(WMF_2021(l),Ra_2021(l),Ra_err_2021(l),'ok');
% scatter(WMF_2021(l),Ra_2021(l),70,'o','Filled','MarkerEdgeColor','k','MarkerFaceColor',C4);
xlabel('% meteoric water'); ylabel('^{228}Ra (dpm 100L^{-1})'); 

% xlim([0 30]); 
ylim([0 30]);
good_titles(20);   
legend([l1 l2 l3 l4],{'1995' '2003' '2018' '2021'},'location','northeast');

%% all years xy plot, top 50 m
k = find(Depth_2021<=50);
% k = find(Depth_2021<=2 & 34<Stn_2021(:,1) & Stn_2021<63);
% l = find(Depth_2021<=2 & 78<=Stn_2021 & Stn_2021<=89);
v = find(Depth_1995<=50 & Lon_1995>108);

figure;
hold on

errorbar(WMF_2021(k),Ra_2021(k),Ra_err_2021(k),'ok');
l4 = scatter(WMF_2021(k),Ra_2021(k),70,'o','Filled','MarkerEdgeColor','k','MarkerFaceColor',C4);

errorbar(WMF_2003,Ra_2003,Ra_err_2003,'ok');
l2 = scatter(WMF_2003,Ra_2003,70,'s','Filled','MarkerEdgeColor','k','MarkerFaceColor',C2);
errorbar(WMF_L,Ra_L,Ra_err_L,'ok');
l2 = scatter(WMF_L,Ra_L,70,'s','Filled','MarkerEdgeColor','k','MarkerFaceColor',C2);
errorbar(WMF_1995(v),Ra_1995(v),Ra_err_1995(v),'ok');
l1 = scatter(WMF_1995(v),Ra_1995(v),70,'v','Filled','MarkerEdgeColor','k','MarkerFaceColor',C1);
errorbar(fMET.*100,Ra228,Ra228_err,'ok');
l3 = scatter(fMET.*100,Ra228,70,'d','Filled','MarkerEdgeColor','k','MarkerFaceColor',[C5]);
% errorbar(WMF_2021(k),Ra_2021(k),Ra_err_2021(k),'ok');
% l4 = scatter(WMF_2021(k),Ra_2021(k),70,'o','Filled','MarkerEdgeColor','k','MarkerFaceColor',C4);
% errorbar(WMF_2021(l),Ra_2021(l),Ra_err_2021(l),'ok');
% scatter(WMF_2021(l),Ra_2021(l),70,'o','Filled','MarkerEdgeColor','k','MarkerFaceColor',C4);
xlabel('% meteoric water'); ylabel('^{228}Ra (dpm 100L^{-1})'); 

% xlim([0 30]); 
ylim([0 40]);
good_titles(20);   
legend([l1 l2 l3 l4],{'1995' '2003' '2018' '2021'},'location','northeast');

%% RAR
k = find(Depth_2021<=50);
% k = find(Depth_2021<=2 & 34<Stn_2021(:,1) & Stn_2021<63);
% l = find(Depth_2021<=2 & 78<=Stn_2021 & Stn_2021<=89);
v = find(Depth_1995<=50 & Lon_1995>108);

figure;
hold on

% errorbar(WMF_2021(k),Ra_2021(k),Ra_err_2021(k),'ok');
l4 = scatter(WMF_2021(k),RAR_2021(k),70,'o','Filled','MarkerEdgeColor','k','MarkerFaceColor',C4);

errorbar(WMF_2003,RAR_2003,RAR_err_2003,'ok');
l2 = scatter(WMF_2003,RAR_2003,70,'s','Filled','MarkerEdgeColor','k','MarkerFaceColor',C2);
errorbar(WMF_L,RAR_L,RAR_err_L,'ok');
l2 = scatter(WMF_L,RAR_L,70,'s','Filled','MarkerEdgeColor','k','MarkerFaceColor',C2);
errorbar(WMF_1995(v),RAR_1995(v),RAR_err_1995(v),'ok');
l1 = scatter(WMF_1995(v),RAR_1995(v),70,'v','Filled','MarkerEdgeColor','k','MarkerFaceColor',C1);
errorbar(fMET.*100,RAR,RAR_err,'ok');
l3 = scatter(fMET.*100,RAR,70,'d','Filled','MarkerEdgeColor','k','MarkerFaceColor',[C5]);
% errorbar(WMF_2021(k),Ra_2021(k),Ra_err_2021(k),'ok');
% l4 = scatter(WMF_2021(k),Ra_2021(k),70,'o','Filled','MarkerEdgeColor','k','MarkerFaceColor',C4);
% errorbar(WMF_2021(l),Ra_2021(l),Ra_err_2021(l),'ok');
% scatter(WMF_2021(l),Ra_2021(l),70,'o','Filled','MarkerEdgeColor','k','MarkerFaceColor',C4);
xlabel('% meteoric water'); ylabel('^{228}Ra/^{226}Ra'); 

% xlim([0 30]); 
% ylim([0 40]);
good_titles(20);   
legend([l1 l2 l3 l4],{'1995' '2003' '2018' '2021'},'location','northeast');
