%% Ra v. fMET, updated w/ both sets of 2015 data & TPD synthesis WMF
% copied from Ra v fMET script in Arctic GT folder
% started 5/13/19
% updated 6/26/19 with 2018 NABOS data

clear all; close all; clc;

load('/Users/kipp/Documents/MATLAB/TPD_summary.mat'); % data for both cruises
TPD_sum(1:970,1) = 1; TPD_sum(971:1399) = 4;
i = find(TPD_sum(:,1)==1 & TPD_sum(:,6)<=50 & TPD_sum(:,3)>84); % GN01, shallower than 50 m, north of 84
j = find(TPD_sum(:,1)==4 & TPD_sum(:,6)<=50 & TPD_sum(:,3)>84); % GN04, shallower than 50 m, north of 84
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
Depth_2007 = ARKXXII2_Depth(m);

% PS-78 (2011), depth is all 10 m
Ra_2011 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','PS78','K6:K44')./10;
Ra_err_2011 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','PS78','L6:L44')./10;
RAR_2011 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','PS78','K6:K44')./xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','PS78','I6:I44');
% Sal_2011 = [xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','PS78','M6:M44');NaN;];
WMF_2011 = [xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','PS78','P6:P44');NaN;NaN];

load('/Users/kipp/Documents/MATLAB/NABOS_2018/NABOS_data_041719.mat');
load('/Users/kipp/Documents/MATLAB/NABOS_2018/NABOS_fMET_062619.mat');

ID_2021 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','B5:B134');
Stn_2021 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','A5:A134');
Depth_2021 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','F5:F134');
Ra_2021 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','M5:M134');
Ra_err_2021 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','N5:N134');
RAR_2021 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','S5:S134');
WMF_2021 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_WMF.xlsx','water isotopes','U3:U132').*100; %currently in the same order as the master spreadsheet, but keep an eye on this
s = find(Depth_2021<50);

C13 = [215,25,28]./255; % red
C14 = [253,174,97]./255; % orangish
C15 = [171,217,233]./255; % light blue
C16 = [44,123,182]./255; % dark blue

C1 = [0.2081,0.1663,0.5292];
C2 = [0.0244,0.4350,0.8755];
C3 = [0.1986,0.7214,0.6310];
C4 = [0.9856,0.7372,0.2537];
C5 = [0.9763,0.9831,0.0538];

%% figure with all years (not 2011)
figure;
hold on
errorbar(WMF_2007,Ra_2007,Ra_err_2007,'ok');
l1 = scatter(WMF_2007,Ra_2007,150,'Filled','MarkerEdgeColor','k','MarkerFaceColor',C15);
errorbar(WMF_2015,Ra_2015,Ra_err_2015,'ok');
l2 = scatter(WMF_2015,Ra_2015,150,'Filled','MarkerEdgeColor','k','MarkerFaceColor',C13);
errorbar(fMET.*100,Ra228,Ra228_err,'ok');
l3 = scatter(fMET.*100,Ra228,150,'Filled','MarkerEdgeColor','k','MarkerFaceColor',[C16]);
errorbar(WMF_2021(s),Ra_2021(s),Ra_err_2021(s),'ok');
l4 = scatter(WMF_2021(s),Ra_2021(s),150,'Filled','MarkerEdgeColor','k','MarkerFaceColor',C14);
xlabel('% meteoric water'); ylabel('^{228}Ra (dpm 100L^{-1})'); 

% xlim([0 25]); ylim([0 25]);
good_titles(20);   
legend([l1 l2 l3 l4],{'2007 (>84N)' '2015 (>84N)' '2018 (ESAS)' '2021 (ESAS)'},'location','northeast');

%% all years incl 2011

h = find(Depth_2007 ==7);
% j = find(GT_lat>85); % GT_depth==2 & 
k = find(Depth_2021<=2 & 34<Stn_2021(:,1) & Stn_2021<63);
l = find(Depth_2021<=2 & 78<=Stn_2021 & Stn_2021<=89);

figure;
hold on
errorbar(WMF_2007(h),Ra_2007(h),Ra_err_2007(h),'ok');
l1 = scatter(WMF_2007(h),Ra_2007(h),70,'s','Filled','MarkerEdgeColor','k','MarkerFaceColor',C1);
errorbar(WMF_2011,Ra_2011,Ra_err_2011,'ok');
l2 = scatter(WMF_2011,Ra_2011,70,'>','Filled','MarkerEdgeColor','k','MarkerFaceColor',C2);
errorbar(WMF_2015,Ra_2015,Ra_err_2015,'ok');
l3 = scatter(WMF_2015,Ra_2015,70,'<','Filled','MarkerEdgeColor','k','MarkerFaceColor',C3);
errorbar(fMET.*100,Ra228,Ra228_err,'ok');
l4 = scatter(fMET.*100,Ra228,70,'d','Filled','MarkerEdgeColor','k','MarkerFaceColor',[C5]);
errorbar(WMF_2021(k),Ra_2021(k),Ra_err_2021(k),'ok');
l5 = scatter(WMF_2021(k),Ra_2021(k),70,'o','Filled','MarkerEdgeColor','k','MarkerFaceColor',C4);
errorbar(WMF_2021(l),Ra_2021(l),Ra_err_2021(l),'ok');
scatter(WMF_2021(l),Ra_2021(l),70,'o','Filled','MarkerEdgeColor','k','MarkerFaceColor',C4);
xlabel('% meteoric water'); ylabel('^{228}Ra (dpm 100L^{-1})'); 

xlim([0 30]); ylim([0 40]);
good_titles(20);   
legend([l1 l2 l3 l4 l5],{'2007' '2011' '2015' '2018' '2021'},'location','northeast');

%% just 2021
figure;
hold on
errorbar(WMF_2021(s),Ra_2021(s),Ra_err_2021(s),'ok');
l4 = scatter(WMF_2021(s),Ra_2021(s),150,Depth_2021(s),'Filled','MarkerEdgeColor','k');
xlabel('% meteoric water'); ylabel('^{228}Ra (dpm 100L^{-1})'); 
colormap('parula');
tt = colorbar; set(get(tt,'ylabel'),'String','Depth (m)','FontSize',16); caxis([0 50]);
% xlim([0 25]); ylim([0 25]);
good_titles(20);   

figure;
hold on
errorbar(WMF_2021(s),Ra_2021(s),Ra_err_2021(s),'ok');
l4 = scatter(WMF_2021(s),Ra_2021(s),150,Stn_2021(s),'Filled','MarkerEdgeColor','k');
xlabel('% meteoric water'); ylabel('^{228}Ra (dpm 100L^{-1})'); 
colormap('jet');
tt = colorbar; set(get(tt,'ylabel'),'String','Station','FontSize',16); caxis([0 102]);
% xlim([0 25]); ylim([0 25]);
good_titles(20);   
%% 2007 & 2015 only
figure;
hold on
errorbar(WMF_2015,Ra_2015,Ra_err_2015,'ok');
l2 = scatter(WMF_2015,Ra_2015,150,'Filled','MarkerEdgeColor','k','MarkerFaceColor',C16); % [0.4 0.4 0.4]
errorbar(WMF_2007,Ra_2007,Ra_err_2007,'ok');
l3 = scatter(WMF_2007,Ra_2007,150,'Filled','MarkerEdgeColor','k','MarkerFaceColor',C14);
% errorbar(18,17.1,3.6,'or','linewidth',2);
% h = herrorbar_riv(18,17.1,5,'or'); set(h,'linewidth',2);
% l4 = scatter(18,17.1,150,'filled','markeredgecolor','k','markerfacecolor',C13);
xlabel('% meteoric water'); ylabel('^{228}Ra (dpm 100L^{-1})'); xlim([0 25]); ylim([0 25]);
good_titles(20);   
% legend([l4 l2 l3],{'2018' '2015' '2007'},'location','northwest');

%% RAR figure with just 2007 & 2015 & 2018
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

%% RAR all years incl 2011

h = find(Depth_2007 ==7);
% j = find(GT_lat>85); % GT_depth==2 & 
k = find(Depth_2021<=10 & 34<Stn_2021(:,1) & Stn_2021<63);
l = find(Depth_2021<=10 & 78<=Stn_2021 & Stn_2021<=89);

figure;
hold on
errorbar(WMF_2007(h),RAR_2007(h),RAR_err_2007(h),'ok');
l1 = scatter(WMF_2007(h),RAR_2007(h),70,'s','Filled','MarkerEdgeColor','k','MarkerFaceColor',C1);
% errorbar(WMF_2011,RAR_2011,RAR_err_2011,'ok');
l2 = scatter(WMF_2011,RAR_2011,70,'>','Filled','MarkerEdgeColor','k','MarkerFaceColor',C2);
errorbar(WMF_2015,RAR_2015,RAR_err_2015,'ok');
l3 = scatter(WMF_2015,RAR_2015,70,'<','Filled','MarkerEdgeColor','k','MarkerFaceColor',C3);
errorbar(fMET.*100,RAR,RAR_err,'ok');
l4 = scatter(fMET.*100,RAR,70,'d','Filled','MarkerEdgeColor','k','MarkerFaceColor',[C5]);
% errorbar(WMF_2021(k),RAR_2021(k),RAR_err_2021(k),'ok');
l5 = scatter(WMF_2021(k),RAR_2021(k),70,'o','Filled','MarkerEdgeColor','k','MarkerFaceColor',C4);
% errorbar(WMF_2021(l),RAR_2021(l),RAR_err_2021(l),'ok');
scatter(WMF_2021(l),RAR_2021(l),70,'o','Filled','MarkerEdgeColor','k','MarkerFaceColor',C4);
xlabel('% meteoric water'); ylabel('^{228}Ra/^{228}Ra'); 

xlim([0 30]); ylim([0 3]);
good_titles(20);   
legend([l1 l2 l3 l4 l5],{'2007' '2011' '2015' '2018' '2021'},'location','NORTHWEST');
