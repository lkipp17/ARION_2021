%% ARION/NABOS 2021 map compared to NABOS 2018 and GT 2015
% started 2/3/22
% updated 10/30/22

% clear all; close all; clc;
% load AR21_Apr22.mat; 
load AR21_Aug22.mat;

N18 = load('NABOS_data_041719.mat');
N18_Ra228 = N18.Ra228;
N18_Ra226 = N18.Ra226;
N18_RAR = N18.RAR;
N18_lat = N18.NABOS_lat;
N18_lon = N18.NABOS_lon;

for ii=1:length(AR21(:,5))
   if AR21(ii,5)>0
       AR21(ii,5) = AR21(ii,5) - 360;
   elseif AR21(ii,5) == AR21(ii,5)
   end
end

for ii=1:length(N18_lon)
   if N18_lon(ii)>0
       N18_lon(ii) = N18_lon(ii) - 360;
   elseif N18_lon(ii) == N18_lon(ii)
   end
end

for ii=1:length(AR21(:,10))
   if AR21(ii,10)==0
       AR21(ii,10) = NaN;
   elseif AR21(ii,10) == AR21(ii,10)
   end
end

for ii=1:length(AR21(:,16))
   if AR21(ii,16)==0
       AR21(ii,16) = NaN;
   elseif AR21(ii,16) == AR21(ii,16)
   end
end

%% load GEOTRACES data
 
GT_depth = xlsread('/Users/kipp/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','I2:I310');
i = find(GT_depth == 2);
GT_Ra226 = xlsread('/Users/kipp/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','K2:K310');
GT_Ra226_bar = GT_Ra226(i);
% Ra226_err = xlsread('/Users/Lauren/Dropbox (MIT)/WHOI (1)/Arctic/Arctic GEOTRACES/Arctic GEOTRACES master.xlsx','export','K2:K305');
% Ra226_err_bar = Ra226_err(i);
GT_Ra228 = xlsread('/Users/kipp/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','N2:N310');
GT_Ra228_bar = GT_Ra228(i);
% Ra228_err = xlsread('/Users/Lauren/Dropbox (MIT)/WHOI (1)/Arctic/Arctic GEOTRACES/Arctic GEOTRACES master.xlsx','export','M2:M305');
% Ra228_err_bar = Ra228_err(i);
GT_RAR = xlsread('/Users/kipp/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','AX2:AX310');
GT_RAR_bar = GT_RAR(i);
GT_stn = xlsread('/Users/kipp/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','F2:F310');
GT_stn = [-2; -1; GT_stn]; % dutch harbor and rinse are not read in; sub -2 and -1
GT_stn_bar = GT_stn(i);
GT_lat = xlsread('/Users/kipp/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','G2:G310');
GT_lat_bar = GT_lat(i);
GT_lon = xlsread('/Users/kipp/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','H2:H310');
for ii=1:length(GT_lon)
   if GT_lon(ii)>0
       GT_lon(ii) = GT_lon(ii) - 360;
   elseif GT_lon(ii) == GT_lon(ii)
   end
end
GT_lon_bar = GT_lon(i);

%% Ra-228- NABOS only

% map(73,84,115,194);
ortho_map(24.5);

[x,y] = m_ll2xy(AR21(:,5),AR21(:,4));
l = find(AR21(:,6)==2 & AR21(:,10)>0);
[Nx,Ny] = m_ll2xy(N18_lon,N18_lat);

hold on;
% l1 = scatter(x(l),y(l),50,AR21_Feb22(l,10),'o','filled','MarkerEdgeColor','k'); %Ra228 % change dot size back to 100
l2 = scatter(Nx,Ny,50,N18_Ra228,'^','filled','MarkerEdgeColor','k');

% colormap(cmocean('matter'));
colormap('parula');
tt = colorbar;
caxis([0 30]); % drag from 15 to 10
set(get(tt,'ylabel'),'String','^{228}Ra (dpm 100L^{-1})','FontSize',16); % ^{228}Ra (dpm 100L^{-1})
% legend([l1 l2], {'Sept 2021' 'Sept 2018'}, 'location','southwest','fontsize',16);
good_titles(16);

%% Ra-228- w GT

% ortho_map(20);
map(70,90,115,219);

[x,y] = m_ll2xy(AR21(:,5),AR21(:,4));
l = find(AR21(:,6)==2 & AR21(:,10)>0);
[Nx,Ny] = m_ll2xy(N18_lon,N18_lat);
[GTx,GTy] = m_ll2xy(GT_lon_bar,GT_lat_bar);

hold on;
l1 = scatter(x(l),y(l),100,AR21(l,10),'o','filled','MarkerEdgeColor','k'); %Ra228
l2 = scatter(Nx,Ny,100,N18_Ra228,'^','filled','MarkerEdgeColor','k');
l3 = scatter(GTx,GTy,100,GT_Ra228_bar,'d','filled','MarkerEdgeColor','k');

% colormap(cmocean('deep'));
colormap(parula);
tt = colorbar;
caxis([0 30]); % drag from 30 to 15
set(get(tt,'ylabel'),'String','^{228}Ra (dpm 100L^{-1})','FontSize',16); % ^{228}Ra (dpm 100L^{-1})
legend([l1 l2 l3], {'Sept 2021' 'Sept 2018' 'Sept 2015'}, 'location','southwest','fontsize',16);
good_titles(16);

%% Ra-228/Ra-226  w GT

map(70,90,115,219);

[x,y] = m_ll2xy(AR21(:,5),AR21(:,4));
l = find(AR21(:,6)==2 & AR21(:,10)>0);
[Nx,Ny] = m_ll2xy(N18_lon,N18_lat);
[GTx,GTy] = m_ll2xy(GT_lon_bar,GT_lat_bar);

hold on;
l1 = scatter(x(l),y(l),100,AR21(l,16),'o','filled','MarkerEdgeColor','k'); %RAR
l2 = scatter(Nx,Ny,100,N18_RAR,'^','filled','MarkerEdgeColor','k');
l3 = scatter(GTx,GTy,100,GT_RAR_bar,'d','filled','MarkerEdgeColor','k');

% colormap(cmocean('matter'));
colormap(parula);
tt = colorbar;
% caxis([0 2.5]); % drag from 1.5 to 1
caxis([0 2.5]); % there are some that are 2.1, but this is consistent w/ ODV palatte
set(get(tt,'ylabel'),'String','^{228}Ra/^{226}Ra','FontSize',16); 
legend([l1 l2 l3], {'Sept 2021' 'Sept 2018' 'Sept 2015'}, 'location','southwest','fontsize',16);
good_titles(16);

%% Ra-228/Ra-226

map(73,84,115,194);

[x,y] = m_ll2xy(AR21(:,5),AR21(:,4));
l = find(AR21(:,6)==2);
[Nx,Ny] = m_ll2xy(N18_lon,N18_lat);

hold on;
l1 = scatter(x(l),y(l),100,AR21(l,16),'o','filled','MarkerEdgeColor','k'); %RAR
l2 = scatter(Nx,Ny,100,N18_RAR,'^','filled','MarkerEdgeColor','k');

% colormap(cmocean('matter'));
colormap('parula');
tt = colorbar;
caxis([0 2.5]); 
set(get(tt,'ylabel'),'String','^{228}Ra/^{226}Ra','FontSize',16); 
legend([l1 l2], {'Sept 2021' 'Sept 2018'}, 'location','southwest','fontsize',16);
good_titles(16);

%% Ra-226

for ii=1:length(AR21(:,12))
   if AR21(ii,12)==0
       AR21(ii,12) = NaN;
   elseif AR21(ii,12) == AR21(ii,12)
   end
end

map(73,84,115,194);

[x,y] = m_ll2xy(AR21(:,5),AR21(:,4));
l = find(AR21(:,6)==2);
[Nx,Ny] = m_ll2xy(N18_lon,N18_lat);

hold on;
l1 = scatter(x(l),y(l),100,AR21(l,12),'o','filled','MarkerEdgeColor','k'); %Ra-226
l2 = scatter(Nx,Ny,100,N18_Ra226,'^','filled','MarkerEdgeColor','k');

% colormap(cmocean('matter'));
colormap('parula');
tt = colorbar;
caxis([5 15]); 
set(get(tt,'ylabel'),'String','^{226}Ra (dpm 100L^{-1})','FontSize',16); 
good_titles(16);

%% fMET

load('/Users/kipp/Documents/MATLAB/NABOS_2018/NABOS_fMET_062619.mat');
WMF_2018 = fMET.*100;
WMF_2021 = [NaN;NaN;NaN;xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_WMF.xlsx','water isotopes','U3:U132').*100]; %currently in the same order as the master spreadsheet, but keep an eye on this

for ii=1:length(AR21(:,12))
   if AR21(ii,12)==0
       AR21(ii,12) = NaN;
   elseif AR21(ii,12) == AR21(ii,12)
   end
end

map(73,84,115,194);

[x,y] = m_ll2xy(AR21(:,5),AR21(:,4));
l = find(AR21(:,6)==2);
[Nx,Ny] = m_ll2xy(N18_lon,N18_lat);

hold on;
l1 = scatter(x(l),y(l),100,WMF_2021(l),'o','filled','MarkerEdgeColor','k'); 
l2 = scatter(Nx,Ny,100,WMF_2018,'^','filled','MarkerEdgeColor','k');

% colormap(cmocean('matter'));
colormap('parula');
tt = colorbar;
caxis([0 30]); 
set(get(tt,'ylabel'),'String','% meteoric water','FontSize',16); 
good_titles(16);

%% water mass fractions - added Oct 22

load NABOS_WMF_recalc.mat;
% output = MW	MW_std	SIM	SIM_std	ATL	ATL_std	PAC	PAC_std

% meteoric water
map(73,84,115,194);

[x,y] = m_ll2xy(AR21(:,5),AR21(:,4));
l = find(AR21(:,6)==2);
[Nx,Ny] = m_ll2xy(N18_lon,N18_lat);

hold on;
l1 = scatter(x(l),y(l),100,AR21(l,21).*100,'o','filled','MarkerEdgeColor','k'); 
l2 = scatter(Nx,Ny,100,output(:,1),'^','filled','MarkerEdgeColor','k');

colormap('parula');
tt = colorbar;
caxis([0 30]); 
set(get(tt,'ylabel'),'String','% meteoric water','FontSize',16); 
good_titles(16);

% atlantic water
map(73,84,115,194);
hold on;
l1 = scatter(x(l),y(l),100,AR21(l,23).*100,'o','filled','MarkerEdgeColor','k'); 
l2 = scatter(Nx,Ny,100,output(:,5),'^','filled','MarkerEdgeColor','k');

colormap('parula');
tt = colorbar;
caxis([0 100]);
set(get(tt,'ylabel'),'String','% Atlantic water','FontSize',16); 
legend([l1 l2],{'Sept 2021' 'Sept 2018'},'location','southwest');
good_titles(16);

% pacific water
map(73,84,115,194);
hold on;
l1 = scatter(x(l),y(l),100,AR21(l,24).*100,'o','filled','MarkerEdgeColor','k'); 
l2 = scatter(Nx,Ny,100,output(:,7),'^','filled','MarkerEdgeColor','k');

colormap('parula');
tt = colorbar;
caxis([0 100]);
set(get(tt,'ylabel'),'String','% Pacific water','FontSize',16); 
good_titles(16);

% SIM
map(73,84,115,194);
hold on;
l1 = scatter(x(l),y(l),100,AR21(l,22).*100,'o','filled','MarkerEdgeColor','k'); 
l2 = scatter(Nx,Ny,100,output(:,3),'^','filled','MarkerEdgeColor','k');

colormap(cmocean('balance'));
tt = colorbar;
caxis([-12 6]);
set(get(tt,'ylabel'),'String','% sea ice melt','FontSize',16); 
good_titles(16);
