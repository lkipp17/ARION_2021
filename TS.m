%% TS diagram with Ra
% updated 4.9.18
% updated for 2021 ARION 5.10.22

addpath(genpath('/Users/kipp/Documents/MATLAB/seawater toolbox'));

% Calcul desnity line
sss = 26:0.02:36;                 % gamme de salinité
ttt = -2:0.2:3;                  % gamme de temperature
[ss1,tt1] = meshgrid(sss,ttt);    % grille
ss1=ss1';
tt1=tt1';
pp1 = 0*ss1;
dens = sw_dens(ss1,tt1,pp1)-1000;   % calcul des densité correspondant à cette grille

% load AR21_Apr22.mat;
% S = AR21_Feb22(:,8);
% T = AR21_Feb22(:,9);
% Ra228 = AR21_Feb22(:,10);
% Ra226 = AR21_Feb22(:,12);
% RAR = AR21_Feb22(:,16);
% stn = AR21_Feb22(:,1);
% depth = AR21_Feb22(:,6);

ID = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','B5:B134');
Stn = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','A5:A134');
Depth = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','F5:F134');
Ra228 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','M5:M134');
Ra228_err = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','N5:N134');
Ra226 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','O5:O134');
Ra226_err = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','P5:P134');
RAR = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','S5:S134');
WMF = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_WMF.xlsx','water isotopes','U3:U132').*100; %currently in the same order as the master spreadsheet, but keep an eye on this
S = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','H5:H134');
T = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','I5:I134');

load Hydrochem_bottles.mat;
Bot_S = Bottles(:,13);
Bot_T = Bottles(:,11);

%% TS figure
figure; %set(gcf,'Position',[680 558 560 420]);
hold on
xlabel('Salinity'); ylabel('Temperature');
[cc,h]=contour(sss,ttt,dens',16:1:30,'color',[0.6 0.6 0.6],'LineStyle','--','linewidth',0.2); 
clabel(cc,h,16:1:30); 
hold on
tt = colorbar;

scatter(Bot_S,Bot_T,50,'.','MarkerEdgeColor',[0.5 0.5 0.5]); 

% i = find(Ra_depth>50 & ~isnan(Ra226));

% scatter(S,T,60,Ra228,'Filled','MarkerEdgeColor','k','LineWidth',0.5) 
% colormap(parula); caxis([0 40]);
% set(get(tt,'ylabel'),'String','^{228}Ra (dpm 100L^{-1})','FontSize',18);

scatter(S,T,60,RAR,'Filled','MarkerEdgeColor','k','LineWidth',0.5) 
colormap(parula); caxis([0 3]);
set(get(tt,'ylabel'),'String','^{228}Ra/^{226}Ra','FontSize',18);

% scatter(S,T,60,Ra226,'Filled','MarkerEdgeColor','k','LineWidth',0.5) 
% colormap(parula); caxis([0 15]);
% set(get(tt,'ylabel'),'String','^{226}Ra (dpm 100L^{-1})','FontSize',18);

% scatter(S,T,60,stn,'Filled','MarkerEdgeColor','k','LineWidth',0.5) 
% colormap(jet); caxis([0 102]);
% set(get(tt,'ylabel'),'String','Stn','FontSize',16);

% scatter(S,T,60,depth,'Filled','MarkerEdgeColor','k','LineWidth',0.5) 
% colormap(parula); caxis([0 250]);
% set(get(tt,'ylabel'),'String','Depth','FontSize',16);

good_titles(16);
%%
% text(CTD_S(i)+0.05,CTD_PT(i),num2str(Ra_stn(i)),'color','k','fontsize',14)
% text(CTD_S(i)+0.15,CTD_PT(i),num2str(round(Ra_depth(i))),'color','r','fontsize',14)

% AWS data copied from depth_profiles_wTS, non-matching depths deleted
% AWS3_T = [-1.16;-0.97;-0.07;-1.13;-1.53;0.52;0.02;-0.41];
% AWS3_S = [25.90;28.12;31.24;31.22;32.92;34.80;34.88;34.94];
% AWS3_Ra228 = [4.55,5.45,6.69,6.95,4.82,0.72,0.38,0.12]';
% AWS3_Ra228_err = [0.45,0.25,0.52,0.43,0.10,0.33,0.08,0.04]';
% AWS3_depth = [5,25,50,85,150,400,1000,2000]';
% 
% AWS4_Ra228 = [37.1;44.1;59.8;67.6;54.7]./10;
% AWS4_depth = [5;25;35;55;85];
% AWS4_S = [26.01;29.23;30.71;31.75;32.36];
% AWS4_T = [-1.20;-0.72;-0.37;-0.79;-1.27];
% 
% AWS5_Ra228 = [49.0;56.1]./10;
% AWS5_depth = [5;125];
% AWS5_S = [26.56;32.86];
% AWS5_T = [-0.44;-1.54];
% 
% AWS_S = [AWS3_S;AWS4_S;AWS5_S]; AWS_T = [AWS3_T;AWS4_T;AWS5_T]; AWS_Ra228 = [AWS3_Ra228;AWS4_Ra228;AWS5_Ra228];
% scatter(AWS_S,AWS_T,60,AWS_Ra228,'^','filled','MarkerEdgeColor','k','LineWidth',0.5);

tt = colorbar;
% load('colormap_gmt_13.mat');
% colormap(co);
colormap(jet)
caxis([0 12]);
% caxis([4 17]);

% set(get(tt,'ylabel'),'String','^{228}Ra/^{226}Ra','FontSize',18);
set(get(tt,'ylabel'),'String','^{228}Ra (dpm 100L^{-1})','FontSize',18);
% set(get(tt,'ylabel'),'String','^{226}Ra (dpm 100L^{-1})','FontSize',18,'rotation',270,'verticalalignment','baseline');
good_titles(18);

% return

%%% different water masses
plot([30 36],[-1 -1],'k-','linewidth',2);
plot([32.8 32.8],[-1 3],'k-','linewidth',2);
% plot([30 31.5],[0 0],'k-','linewidth',2);
plot([31.5 31.5],[-2 -1],'k-','linewidth',2);
plot([30 30],[-1 9],'k-','linewidth',2);
plot([32.8 32.8],[-1 3],'k-','linewidth',2);
plot([30 36],[3 3],'k-','linewidth',2);
plot([31.5 36],[-1.6 -1.6],'k-','linewidth',2);

box on
% text(34,2,'AW','fontsize',13,'fontweight','bold');
text(32.9,2.8,'AW','fontsize',13,'fontweight','bold');
% text(31,2,'CSW','fontsize',13,'fontweight','bold');
text(30.1,2.8,'CSW','fontsize',13,'fontweight','bold');
% text(32.5,5.4,'ACW','fontsize',13,'fontweight','bold');
text(34.7,3.2,'ACW','fontsize',13,'fontweight','bold');
text(26.5,1,'MW','fontsize',13,'fontweight','bold');
text(34.7,-1.45,'RWW','fontsize',13,'fontweight','bold');
text(35,-1.8,'WW','fontsize',13,'fontweight','bold');

% ylim([-2 6.5]);xlim([24 36]);
ylim([-2 9]);xlim([24 36]);
% xlim([34.7 35]); ylim([-1.2 1.5]); %deep zoom
xlabel('Salinity','fontsize',15);
ylabel('Temperature (\circC)','fontsize',15);
set(gca,'fontsize',15)
return

%% SBI/seaonal TS diagrams
load '/Users/Lauren/Documents/MATLAB/Arctic GT/seriouslyallSBI_master.mat';
figure; set(gcf,'Position',[680 558 560 420]);

hold on
xlabel('Salinity'); ylabel('Temperature');
% contours pour denisty
% [cc,h]=contour(sss,ttt,dens',25:0.1:30,'color',[0.6 0.6 0.6],'LineStyle','--','linewidth',0.2); 
% clabel(cc,h,25:0.1:30); 
[cc,h]=contour(sss,ttt,dens',16:1:30,'color',[0.6 0.6 0.6],'LineStyle','--','linewidth',0.2); 
clabel(cc,h,16:1:30); 
hold on

i = strmatch('HLY0404',SBI_cruise);
j = find(~isnan(SBI_Ra228(i)));
scatter(SBI_sal(i(j)),SBI_temp(i(j)),60,SBI_Ra228(i(j)),'Filled','MarkerEdgeColor','k','LineWidth',0.5) 

% i = strmatch('HLY0403',SBI_cruise);
% j = find(~isnan(SBI_Ra228(i)));
% scatter(SBI_sal(i(j)),SBI_temp(i(j)),60,SBI_Ra228(i(j)),'Filled','MarkerEdgeColor','k','LineWidth',0.5) 

i = find(Ra_stn>3 & ~isnan(Ra228) & Latitude<85 & Ra_depth>2);
scatter(CTD_S(i),CTD_PT(i),60,Ra228(i),'^','Filled','MarkerEdgeColor','k','LineWidth',0.5) 

% text(CTD_S(i)+0.05,CTD_PT(i),num2str(Ra_stn(i)),'color','k','fontsize',14)
% text(CTD_S(i)+0.15,CTD_PT(i),num2str(round(Ra_depth(i))),'color','r','fontsize',14)

tt = colorbar;
% load('colormap_gmt_13.mat');
% colormap(co);
colormap(jet)
caxis([0 12]);
% caxis([4 17]);

% set(get(tt,'ylabel'),'String','^{228}Ra/^{226}Ra','FontSize',18);
set(get(tt,'ylabel'),'String','^{228}Ra (dpm 100L^{-1})','FontSize',18,'rotation',270,'verticalalignment','baseline');
% set(get(tt,'ylabel'),'String','^{226}Ra (dpm 100L^{-1})','FontSize',18,'rotation',270,'verticalalignment','baseline');
good_titles(18);

%%% different water masses
plot([30 36],[-1 -1],'k-','linewidth',2);
plot([32.8 32.8],[-1 3],'k-','linewidth',2);
plot([31.5 31.5],[-2 -1],'k-','linewidth',2);
plot([30 30],[-1 9],'k-','linewidth',2);
plot([32.8 32.8],[-1 3],'k-','linewidth',2);
plot([30 36],[3 3],'k-','linewidth',2);
plot([31.5 36],[-1.6 -1.6],'k-','linewidth',2);

box on
text(32.9,2.8,'AW','fontsize',13,'fontweight','bold');
text(30.1,2.8,'CSW','fontsize',13,'fontweight','bold');
text(34.7,3.2,'ACW','fontsize',13,'fontweight','bold');
text(26.5,1,'MW','fontsize',13,'fontweight','bold');
text(34.7,-1.45,'RWW','fontsize',13,'fontweight','bold');
text(35,-1.8,'WW','fontsize',13,'fontweight','bold');

% ylim([-2 6.5]);xlim([24 36]);
ylim([-2 9]);xlim([24 36]);
xlabel('Salinity','fontsize',15);
ylabel('Temperature (\circC)','fontsize',15);
set(gca,'fontsize',15)


%% oxy-sal figure
figure
plot(CTDSAL(136:3172),CTDOXY(136:3172),'.','MarkerSize',13,'Color',[0.7 0.7 0.7])
% plot(CTDSAL,CTDOXY,'.','MarkerSize',13,'Color',[0.7 0.7 0.7])
hold on
xlabel('Salinity'); ylabel('Oxygen');
% contours pour denisty
% [cc,h]=contour(sss,ttt,dens',16:1:37,'color',[0.6 0.6 0.6],'LineStyle','--','linewidth',0.2); 
% clabel(cc,h,16:1:30); 
hold on

% i = find(Ra_depth);
i = find(Ra_stn>6);
scatter(CTD_S(i),CTD_OXY(i),100,Ra228_Ra226(i),'Filled','MarkerEdgeColor','k') % starting at station 7

xlim([24 37]); ylim([150 450]);
% xlim([32 36]); ylim([-3 4]);
% xlim([34 35.5]); ylim([-2 1]); 

tt = colorbar;
colormap jet
caxis([0 2]);
% caxis([0 0.15]);

set(get(tt,'ylabel'),'String','^{228}Ra/^{226}Ra','FontSize',18);
good_titles(18);

%%
hold on
ASILCAT = SILCAT(136:3172); ACTDSAL = CTDSAL(136:3172); APT = PT(136:3172);
ii = find(ASILCAT>-900);
iSILCAT = ASILCAT(ii);
iCTDSAL = ACTDSAL(ii);
iPT = APT(ii);
scatter(iCTDSAL,iPT,170,iSILCAT,'Filled','MarkerEdgeColor','k');
tt = colorbar;
colormap jet
% caxis([2 15]);
set(get(tt,'ylabel'),'String','Si (umol/kg)','FontSize',18);
good_titles(18);