%% map of all ARION data + Chen ESAS + gateways
% started 8/11/22 for shelf flux calculation

% clear all; close all; clc;
% addpath(genpath('/Users/kipp/Documents/MATLAB/m_map'));
% addpath(genpath('/Users/kipp/Documents/MATLAB/NABOS_2018'));

addpath(genpath('/Users/Lauren/Documents/MATLAB/m_map'));
addpath(genpath('/Users/Lauren/Documents/MATLAB/NABOS'));

load Chen_data_040320.mat;

load AR21_Apr22.mat;

for ii=1:length(AR21_Feb22(:,5))
   if AR21_Feb22(ii,5)>0
       AR21_Feb22(ii,5) = AR21_Feb22(ii,5) - 360;
   elseif AR21_Feb22(ii,5) == AR21_Feb22(ii,5)
   end
end

for ii=1:length(Chen_data(:,1))
   if Chen_data(ii,1)>0
       Chen_data(ii,1) = Chen_data(ii,1) - 360;
   elseif Chen_data(ii,1) == Chen_data(ii,1)
   end
end

% N18 = load('NABOS_data_041719.mat');
% N18_Ra228 = N18.Ra228;
% N18_Ra228_err = N18.Ra228_err;
% N18_Ra226 = N18.Ra226;
% N18_Ra226_err = N18.Ra226_err;
% N18_RAR = N18.RAR;
% N18_RAR_err = N18.RAR_err;
% N18_lat = N18.NABOS_lat;
% N18_lon = N18.NABOS_lon;
% N18_sal = N18.salinity;

%% GEOTRACES 2015
 
% GT_depth = xlsread('/Users/kipp/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','I2:I310');
% GT_Ra228 = xlsread('/Users/kipp/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','N2:N310');
% GT_stn = xlsread('/Users/kipp/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','F2:F310');
% GT_lat = xlsread('/Users/kipp/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','G2:G310');
% GT_lon = xlsread('/Users/kipp/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','H2:H310');
% GT_RAR = xlsread('/Users/kipp/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','AX2:AX310');

GT_depth = xlsread('/Users/Lauren/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','I2:I310');
GT_Ra228 = xlsread('/Users/Lauren/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','N2:N310');
GT_stn = xlsread('/Users/Lauren/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','F2:F310');
GT_lat = xlsread('/Users/Lauren/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','G2:G310');
GT_lon = xlsread('/Users/Lauren/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','H2:H310');
GT_RAR = xlsread('/Users/Lauren/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','AX2:AX310');

i = find(GT_depth == 2);
GT_Ra228_bar = GT_Ra228(i);
GT_stn = [-2; -1; GT_stn]; % dutch harbor and rinse are not read in; sub -2 and -1
GT_stn_bar = GT_stn(i);
GT_lat_bar = GT_lat(i);
GT_RAR_bar = GT_RAR(i);

for ii=1:length(GT_lon)
   if GT_lon(ii)>0
       GT_lon(ii) = GT_lon(ii) - 360;
   elseif GT_lon(ii) == GT_lon(ii)
   end
end
GT_lon_bar = GT_lon(i);

%% gateways: south of Savernaya Zemlya, Bering St

% into Laptev, RVDL 2003
lap = [8.96; 10.64];
lap_lat = [77.50; 78];
lap_lon = [96.83; 102.58];
lap_lon = lap_lon - 360;

% bering st
ber = [7.06; 7.04];
ber_lat = [65.8035; 66.3304];
ber_lon = [-168.6058; -168.9004];

%% Ra-228 map
% map_polar(25);
map(65,84,90,194);

[x,y] = m_ll2xy(Chen_data(:,1),Chen_data(:,2));
c = find(Chen_data(:,13)==2); % Chen 2018 data
n = find(Chen_data(:,13)==1); % NABOS 2018
% l = find(Chen_data(:,13)==4);

[Ax,Ay] = m_ll2xy(AR21_Feb22(:,5),AR21_Feb22(:,4));
a = find(AR21_Feb22(:,6)==2); % ARION 2021

[Lx, Ly] = m_ll2xy(lap_lon, lap_lat);
[Bx, By] = m_ll2xy(ber_lon, ber_lat);
[GTx, GTy] = m_ll2xy(GT_lon_bar, GT_lat_bar);

hold on;
l5 = scatter(GTx,GTy,100,GT_Ra228_bar,'d','filled','markeredgecolor','k');
% l1 = scatter(x(c),y(c),100,Chen_data(c,7),'v','filled','MarkerEdgeColor','k');
l2 = scatter(x(n),y(n),100,Chen_data(n,7),'^','filled','MarkerEdgeColor','k');
l3 = scatter(Ax(a),Ay(a),100,AR21_Feb22(a,10),'o','filled','markeredgecolor','k');
l4 = scatter(Lx,Ly,100,lap,'<','filled','markeredgecolor','k');
% l5 = scatter(Bx,By,100,ber,'d','filled','markeredgecolor','k');



colormap('parula');
tt = colorbar;
caxis([0 30]); % drag from 30 to 15
set(get(tt,'ylabel'),'String','^{228}Ra (dpm 100L^{-1})','FontSize',16); % ^{228}Ra (dpm 100L^{-1})
good_titles(16);

% legend([l1 l2 l3 l4 l5], {'Arc Sep 2018' 'NABOS Sep 2018' 'NABOS Sep 2021' '1993 (RVDL 2003)' '2015 (GEOTRACES)'}, 'location','southwest','fontsize',16);
legend([l2 l3 l4 l5], {'2018 (this study)' '2021 (this study)' '1993 (Rutgers van der Loeff et al., 2003)' '2015 (Kipp et al., 2019)'}, 'location','southwest','fontsize',16);

return
%% salinity
% map_polar(25);
map(65,84,90,194);

[x,y] = m_ll2xy(Chen_data(:,1),Chen_data(:,2));
c = find(Chen_data(:,13)==2); % Chen 2018 data
n = find(Chen_data(:,13)==1); % NABOS 2018
% l = find(Chen_data(:,13)==4);

[Ax,Ay] = m_ll2xy(AR21_Feb22(:,5),AR21_Feb22(:,4));
a = find(AR21_Feb22(:,6)==2); % ARION 2021

[Lx, Ly] = m_ll2xy(lap_lon, lap_lat);
[Bx, By] = m_ll2xy(ber_lon, ber_lat);

hold on;
l1 = scatter(x(c),y(c),100,Chen_data(c,4),'v','filled','MarkerEdgeColor','k');
l2 = scatter(x(n),y(n),100,Chen_data(n,4),'^','filled','MarkerEdgeColor','k');
l3 = scatter(Ax(a),Ay(a),100,AR21_Feb22(a,8),'o','filled','markeredgecolor','k');
l4 = scatter(Lx,Ly,100,[26;27.99],'<','filled','markeredgecolor','k');
l5 = scatter(Bx,By,100,[32.33;32.23],'d','filled','markeredgecolor','k'); % surf salinity from TPD master sheet


colormap('parula');
% colormap(cmocean('haline'));
tt = colorbar;
caxis([10 35]); 
set(get(tt,'ylabel'),'String','Salinity','FontSize',16); % ^{228}Ra (dpm 100L^{-1})
good_titles(16);

legend([l1 l2 l3 l4 l5], {'Arc Sep 2018' 'NABOS Sep 2018' 'NABOS Sep 2021' '1993 (RVDL 2003)' '2015 (GEOTRACES)'}, 'location','southwest','fontsize',16);


%% RAR map
% map_polar(25);
map(65,84,90,194);

[x,y] = m_ll2xy(Chen_data(:,1),Chen_data(:,2));
c = find(Chen_data(:,13)==2); % Chen 2018 data
n = find(Chen_data(:,13)==1); % NABOS 2018

[Ax,Ay] = m_ll2xy(AR21_Feb22(:,5),AR21_Feb22(:,4));
a = find(AR21_Feb22(:,6)==2); % ARION 2021
[GTx, GTy] = m_ll2xy(GT_lon_bar, GT_lat_bar);

hold on;
l1 = scatter(x(c),y(c),100,Chen_data(c,9),'v','filled','MarkerEdgeColor','k');
l2 = scatter(x(n),y(n),100,Chen_data(n,9),'^','filled','MarkerEdgeColor','k');
l3 = scatter(Ax(a),Ay(a),100,AR21_Feb22(a,16),'o','filled','markeredgecolor','k');
l5 = scatter(GTx,GTy,100,GT_RAR_bar,'d','filled','markeredgecolor','k');


colormap('parula');
tt = colorbar;
caxis([0 3.5]); 
set(get(tt,'ylabel'),'String','^{228}Ra/^{226}Ra','FontSize',16); % ^{228}Ra (dpm 100L^{-1})
good_titles(16);

legend([l1 l2 l3 l5], {'Arc Sep 2018' 'NABOS Sep 2018' 'NABOS Sep 2021' '2015 (GEOTRACES)'}, 'location','southwest','fontsize',16);
