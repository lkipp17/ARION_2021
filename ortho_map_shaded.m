function [ map_fig ] = ortho_map_shaded(r)
% r = radius of stereographic projection (line 11)
% for entire arctic: [map_fig] = map(25);

addpath(genpath('/Users/kipp/Documents/MATLAB/m_map')); % load m_map directory
addpath(genpath('/Users/Lauren/Documents/MATLAB/Arctic GT/m_map')); % load m_map directory
addpath(genpath('/Users/Lauren/Documents/MATLAB/cmocean_v1.4')); % load colormaps

% initialize figure
figure;
set(gcf,'units','pixels','position',[222 206 982 754]) % figure size and screen position
set(gcf,'renderer','painters') % idk what this does
m_proj('stereographic','lat',90,'long',0,'radius',r); % stereographic projection

% bathymetry
load etopo2_arctic.mat % load bathymetry
hold on;
% contours=[50 100 200 500 1000:1000:5000]; % define main contours (light grey thin line)
% shelf_contour = [200,200]; % define bold shelf contour
% [c,h]=m_contour(LON,LAT,data,contours,'color',[0.7 0.7 0.7]); % plot main contours
% clabel(c,h,'labelspacing',500,'fontsize',12,'color',[.7 .7 .7]); % label main contours
% [c2,h2]=m_contour(LON,LAT,data,shelf_contour,'LineWidth',2,'color',[0.4 0.4 0.4]); % plot shelf contour
% clabel(c2,h2,'labelspacing',500,'fontsize',12,'color',[0.4 0.4 0.4]); % label shelf contour

hold on;
contours=[0:100:500 500:500:5000]; % define main contours 
m_contourf(LON,LAT,data,contours,'color','none'); 
% colormap(cmocean('deep'));
colormap(flipud(cmocean('ice')));
hold on;
% land patch and grid
m_gshhs_l('patch',[.5,.5,.5],'edgecolor','k') % low resolution land patch (increase resolution if zooming in to small area by switching to m_gshhs_i, m_gshhs_h, or m_gshhs_f)
m_grid('ytick',[90 85 80 75]);
ylabel('Latitude')
xlabel('Longitude')

% figure handle
map_fig = gcf;

end
