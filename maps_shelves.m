%% shelf map with historical data
% copied from surface_map.m
% started 6/7/22

% clear all; close all; clc;
% load AR21_Apr22.mat;
% % updated May 5 w/ salt bottle data

% for ii=1:length(AR21_Feb22(:,5))
%    if AR21_Feb22(ii,5)>0
%        AR21_Feb22(ii,5) = AR21_Feb22(ii,5) - 360;
%    elseif AR21_Feb22(ii,5) == AR21_Feb22(ii,5)
%    end
% end

Stn_2021 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','A5:A134');
Depth_2021 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','F5:F134');
Ra_2021 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','M5:M134');
Ra_err_2021 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','N5:N134');
RAR_2021 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','S5:S134');
Lat_2021 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','D5:D134');
Lon_2021 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','E5:E134');

for ii=1:length(Lon_2021(:))
   if Lon_2021(ii)>0
       Lon_2021(ii) = Lon_2021(ii) - 360;
   elseif Lon_2021(ii) == Lon_2021(ii)
   end
end

% ARK XI/1, Laptev 1995, RVDL 2012
Ra_1995 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','RVDL_2012','R54:R194')./10;
RAR_1995 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','RVDL_2012','T54:T194');
Lat_1995 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','RVDL_2012','E54:E194');
Lon_1995 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','RVDL_2012','F54:F194');
Depth_1995 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','RVDL_2012','H54:H194');

for ii=1:length(Lon_1995)
   if Lon_1995(ii)>0
       Lon_1995(ii) = Lon_1995(ii) - 360;
   elseif Lon_1995(ii) == Lon_1995(ii)
   end
end

% RVDL 2003, all surf
Ra_2003 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','RVDL_2003','J4:J44')./10;
RAR_2003 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','RVDL_2003','L4:L44');
Lat_2003 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','RVDL_2003','C4:C44');
Lon_2003 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','RVDL_2003','D4:D44');

for ii=1:length(Lon_2003)
   if Lon_2003(ii)>0
       Lon_2003(ii) = Lon_2003(ii) - 360;
   elseif Lon_2003(ii) == Lon_2003(ii)
   end
end

N18 = load('NABOS_data_041719.mat');
N18_Ra228 = N18.Ra228;
N18_Ra226 = N18.Ra226;
N18_RAR = N18.RAR;
N18_lat = N18.NABOS_lat;
N18_lon = N18.NABOS_lon;


for ii=1:length(N18_lon)
   if N18_lon(ii)>0
       N18_lon(ii) = N18_lon(ii) - 360;
   elseif N18_lon(ii) == N18_lon(ii)
   end
end

%% Ra-228

% for ii=1:length(AR21_Feb22(:,10))
%    if AR21_Feb22(ii,10)==0
%        AR21_Feb22(ii,10) = NaN;
%    elseif AR21_Feb22(ii,10) == AR21_Feb22(ii,10)
%    end
% end

for ii=1:length(Ra_2021)
   if Ra_2021(ii)==0
       Ra_2021(ii) = NaN;
   elseif Ra_2021(ii) == Ra_2021(ii)
   end
end

map(68,84,108,194);

[x,y] = m_ll2xy(Lon_2021,Lat_2021);
l = find(Depth_2021==2);

j = find(Depth_1995<=11 & Lon_1995>(110-360));
k = find(Lon_2003 > (110-360));

% [GTx,GTy] = m_ll2xy(lon_bar,lat_bar);
[PS95x,PS95y] = m_ll2xy(Lon_1995,Lat_1995);
[PS03x,PS03y] = m_ll2xy(Lon_2003,Lat_2003);
[Nx,Ny] = m_ll2xy(N18_lon,N18_lat);

hold on;
l4 = scatter(x(l),y(l),100,Ra_2021(l),'o','filled','MarkerEdgeColor','k'); %Ra228
l2 = scatter(PS95x(j),PS95y(j),120,Ra_1995(j),'s','filled','markeredgecolor','k');
l1 = scatter(PS03x(k),PS03y(k),120,Ra_2003(k),'v','filled','markeredgecolor','k'); %1993
l3 = scatter(Nx,Ny,100,N18_Ra228,'^','filled','MarkerEdgeColor','k');
% l2 = scatter(x(n),y(n),100,Chen_data(n,7),'^','filled','MarkerEdgeColor','k');

% colormap(cmocean('matter'));
colormap('parula');
tt = colorbar;
caxis([0 30]); % drag from 30 to 15
set(get(tt,'ylabel'),'String','^{228}Ra (dpm 100L^{-1})','FontSize',16); % ^{228}Ra (dpm 100L^{-1})
legend([l1 l2 l3 l4], {'1993' '1995' '2018' '2021'}, 'location','southwest','fontsize',16);
good_titles(16);

return
%% Ra-228/Ra-226

% for ii=1:length(AR21_Feb22(:,16))
%    if AR21_Feb22(ii,16)==0
%        AR21_Feb22(ii,16) = NaN;
%    elseif AR21_Feb22(ii,16) == AR21_Feb22(ii,16)
%    end
% end

for ii=1:length(RAR_2021)
   if RAR_2021(ii)==0
       RAR_2021(ii) = NaN;
   elseif RAR_2021(ii) == RAR_2021(ii)
   end
end

map(68,84,108,194);

[x,y] = m_ll2xy(Lon_2021,Lat_2021);
l = find(Depth_2021==2);

j = find(Depth_1995<=11 & Lon_1995>(110-360));
k = find(Lon_2003 > (110-360));

% [GTx,GTy] = m_ll2xy(lon_bar,lat_bar);
[PS95x,PS95y] = m_ll2xy(Lon_1995,Lat_1995);
[PS03x,PS03y] = m_ll2xy(Lon_2003,Lat_2003);
[Nx,Ny] = m_ll2xy(N18_lon,N18_lat);

hold on;
l4 = scatter(x(l),y(l),100,RAR_2021(l),'o','filled','MarkerEdgeColor','k'); %Ra228
l2 = scatter(PS95x(j),PS95y(j),120,RAR_1995(j),'s','filled','markeredgecolor','k');
l1 = scatter(PS03x(k),PS03y(k),120,RAR_2003(k),'v','filled','markeredgecolor','k'); %1993
l3 = scatter(Nx,Ny,100,N18_RAR,'^','filled','MarkerEdgeColor','k');
% l2 = scatter(x(n),y(n),100,Chen_data(n,7),'^','filled','MarkerEdgeColor','k');

% colormap(cmocean('matter'));
colormap('parula');
tt = colorbar;
caxis([0 4]); 
set(get(tt,'ylabel'),'String','^{228}Ra/^{226}Ra','FontSize',16); 
legend([l1 l2 l3 l4], {'1993' '1995' '2018' '2021'}, 'location','southwest','fontsize',16);
good_titles(16);

%% Ra-228 on all shelves (incl Kara)

for ii=1:length(Ra_2021)
   if Ra_2021(ii)==0
       Ra_2021(ii) = NaN;
   elseif Ra_2021(ii) == Ra_2021(ii)
   end
end

map(68,84,60,194);

[x,y] = m_ll2xy(Lon_2021,Lat_2021);
l = find(Depth_2021==2);

j = find(Depth_1995<=11 & Lon_1995>(60-360));
k = find(Lon_2003 > (60-360));

% [GTx,GTy] = m_ll2xy(lon_bar,lat_bar);
[PS95x,PS95y] = m_ll2xy(Lon_1995,Lat_1995);
[PS03x,PS03y] = m_ll2xy(Lon_2003,Lat_2003);
[Nx,Ny] = m_ll2xy(N18_lon,N18_lat);

hold on;
l4 = scatter(x(l),y(l),100,Ra_2021(l),'o','filled','MarkerEdgeColor','k'); %Ra228
l2 = scatter(PS95x(j),PS95y(j),120,Ra_1995(j),'s','filled','markeredgecolor','k');
l1 = scatter(PS03x(k),PS03y(k),120,Ra_2003(k),'v','filled','markeredgecolor','k'); %1993
l3 = scatter(Nx,Ny,100,N18_Ra228,'^','filled','MarkerEdgeColor','k');
% l2 = scatter(x(n),y(n),100,Chen_data(n,7),'^','filled','MarkerEdgeColor','k');

% colormap(cmocean('matter'));
colormap('parula');
tt = colorbar;
caxis([0 30]); % drag from 30 to 15
set(get(tt,'ylabel'),'String','^{228}Ra (dpm 100L^{-1})','FontSize',16); % ^{228}Ra (dpm 100L^{-1})
legend([l1 l2 l3 l4], {'1993' '1995' '2018' '2021'}, 'location','southwest','fontsize',16);
good_titles(16);


%% RAR on all shelves (incl Kara)
for ii=1:length(RAR_2021)
   if RAR_2021(ii)==0
       RAR_2021(ii) = NaN;
   elseif RAR_2021(ii) == RAR_2021(ii)
   end
end

map(68,84,60,194);

[x,y] = m_ll2xy(Lon_2021,Lat_2021);
l = find(Depth_2021==2);

j = find(Depth_1995<=11 & Lon_1995>(60-360));
k = find(Lon_2003 > (60-360));

% [GTx,GTy] = m_ll2xy(lon_bar,lat_bar);
[PS95x,PS95y] = m_ll2xy(Lon_1995,Lat_1995);
[PS03x,PS03y] = m_ll2xy(Lon_2003,Lat_2003);
[Nx,Ny] = m_ll2xy(N18_lon,N18_lat);

hold on;
l4 = scatter(x(l),y(l),100,RAR_2021(l),'o','filled','MarkerEdgeColor','k'); %Ra228
l2 = scatter(PS95x(j),PS95y(j),120,RAR_1995(j),'s','filled','markeredgecolor','k');
l1 = scatter(PS03x(k),PS03y(k),120,RAR_2003(k),'v','filled','markeredgecolor','k'); %1993
l3 = scatter(Nx,Ny,100,N18_RAR,'^','filled','MarkerEdgeColor','k');
% l2 = scatter(x(n),y(n),100,Chen_data(n,7),'^','filled','MarkerEdgeColor','k');

% colormap(cmocean('matter'));
colormap('parula');
tt = colorbar;
caxis([0 4]); 
set(get(tt,'ylabel'),'String','^{228}Ra/^{226}Ra','FontSize',16); 
legend([l1 l2 l3 l4], {'1993' '1995' '2018' '2021'}, 'location','southwest','fontsize',16);
good_titles(16);