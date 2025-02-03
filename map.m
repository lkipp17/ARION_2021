function [ map_fig ] = map(latmin,latmax,lonmin,lonmax)

addpath(genpath('/Users/kipp/Documents/MATLAB/m_map')); % load m_map directory

% convert lon to negative
lonmin = lonmin-360;
lonmax = lonmax-360;

% initialize figure
figure;
set(gcf,'units','pixels','position',[222 206 982 754]) % figure size and screen position
set(gcf,'renderer','painters') % idk what this does
m_proj('lambert','lat',[latmin latmax],'long',[lonmin lonmax]); 

% bathymetry
load etopo2_arctic.mat % load bathymetry
contours=[50 100 200 500 1000:1000:5000]; % define main contours (light grey thin line)
shelf_contour = [500,500]; % define bold shelf contour
hold on;
[c,h]=m_contour(LON,LAT,data,contours,'LineWidth',1,'color',[0.5 0.5 0.5]); % plot main contours
clabel(c,h,'labelspacing',500,'fontsize',12,'color',[.5 .5 .5]); % label main contours
[c2,h2]=m_contour(LON,LAT,data,shelf_contour,'LineWidth',2,'color',[0.4 0.4 0.4]); % plot shelf contour
clabel(c2,h2,'labelspacing',500,'fontsize',12,'color',[0.4 0.4 0.4]); % label shelf contour

% land patch and grid
m_gshhs_l('patch',[.5,.5,.5],'edgecolor','k') % low resolution land patch (increase resolution if zooming in to small area by switching to m_gshhs_i, m_gshhs_h, or m_gshhs_f)
m_grid('ytick',[90 85 80 75],'fontsize',12);

% figure handle
map_fig = gcf;

end
