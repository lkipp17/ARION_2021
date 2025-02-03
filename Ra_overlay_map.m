%% Ra map for current overlay
% copied from surface_map script

% clear all; close all; clc;
addpath(genpath('/Users/Lauren/Documents/MATLAB/m_map'));
addpath(genpath('/Users/kipp/Dropbox/MATLAB/ARION_2021'));
load AR21_Aug22.mat;

for ii=1:length(AR21(:,5))
   if AR21(ii,5)>0
       AR21(ii,5) = AR21(ii,5) - 360;
   elseif AR21(ii,5) == AR21(ii,5)
   end
end

%% map
addpath(genpath('/Users/kipp/Documents/MATLAB/m_map')); % load m_map directory
% map(73,84,115,194);
latmin = 69; latmax = 90; lonmin = 115; lonmax = 194;
% convert lon to negative
lonmin = lonmin-360;
lonmax = lonmax-360;

% initialize figure
figure;
set(gcf,'units','pixels','position',[222 206 982 754]) % figure size and screen position
set(gcf,'renderer','painters') % idk what this does
m_proj('lambert','lat',[latmin latmax],'long',[lonmin lonmax]); 

% bathymetry
% load etopo2_arctic.mat % load bathymetry
% contours=[50 100 200 500 1000:1000:5000]; % define main contours (light grey thin line)
% shelf_contour = [200,200]; % define bold shelf contour
% hold on;
% [c,h]=m_contour(LON,LAT,data,contours,'color',[0.7 0.7 0.7]); % plot main contours
% clabel(c,h,'labelspacing',500,'fontsize',12,'color',[.7 .7 .7]); % label main contours
% [c2,h2]=m_contour(LON,LAT,data,shelf_contour,'LineWidth',2,'color',[0.4 0.4 0.4]); % plot shelf contour
% clabel(c2,h2,'labelspacing',500,'fontsize',12,'color',[0.4 0.4 0.4]); % label shelf contour

% land patch and grid
m_gshhs_l('patch',[.5,.5,.5],'edgecolor','k') % low resolution land patch (increase resolution if zooming in to small area by switching to m_gshhs_i, m_gshhs_h, or m_gshhs_f)
m_grid('ytick',[90 85 80 75],'fontsize',12);

% figure handle
map_fig = gcf;

%% Ra-228

for ii=1:length(AR21(:,10))
   if AR21(ii,10)==0
       AR21(ii,10) = NaN;
   elseif AR21(ii,10) == AR21(ii,10)
   end
end

% map(73,84,115,194);

[x,y] = m_ll2xy(AR21(:,5),AR21(:,4));
l = find(AR21(:,6)==2);

hold on;
% l1 = scatter(x(l),y(l),100,AR21(l,10),'o','filled','MarkerEdgeColor','k'); %Ra228
l1 = scatter(x(l),y(l),200,AR21(l,10),'o','filled','MarkerEdgeColor','none'); %Ra228

% colormap(cmocean('matter'));
colormap('parula');
tt = colorbar;
caxis([0 30]); % drag from 30 to 15
set(get(tt,'ylabel'),'String','^{228}Ra (dpm 100L^{-1})','FontSize',16); % ^{228}Ra (dpm 100L^{-1})
good_titles(16);
