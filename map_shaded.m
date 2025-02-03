function [ map_fig ] = map_shaded(latmin,latmax,lonmin,lonmax)
% ONR basemap: map_shaded(70,90,120,220);

addpath(genpath('/Users/kipp/Documents/MATLAB/m_map')); % load m_map directory
addpath(genpath('/Users/Lauren/Documents/MATLAB/m_map'));

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

hold on;
contours=[0:100:500 500:500:5000]; % define main contours 
m_contourf(LON,LAT,data,contours,'color','none'); 
colormap(cmocean('deep'));
% colormap(flipud(cmocean('ice')));
hold on;

% % colorbar
% caxis([0 4500]); 
% % colorbar('southoutside');
% colorbar('eastoutside','Direction','Reverse');
% c = colorbar;
% c.Label.String = 'Depth (m)';

% land patch and grid
m_gshhs_l('patch',[.5,.5,.5],'edgecolor','k') % low resolution land patch (increase resolution if zooming in to small area by switching to m_gshhs_i, m_gshhs_h, or m_gshhs_f)
m_grid('ytick',[90 85 80 75],'fontsize',12);

% figure handle
map_fig = gcf;


good_titles(14);

% add Russian EEZ 
load Russian_EEZ.mat;
m_plot(EEZ_lon,EEZ_lat,'r--','linewidth',1.5);

end