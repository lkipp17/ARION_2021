%% WMF surface maps
% started 4/21/23
% copied from surface_map.m
% updated with finalized nutrient data

load WMF_2021_final.mat;
% [station sample MW_avg' MW_std' SIM_avg' SIM_std' ATL_avg' ATL_std' PW_avg' PW_std']; % in percent
WMF = WMF(4:132,:); % delete station 0

load ADC_radium.mat;
ADC_radium = ADC_radium(4:132,:);
addpath(genpath('/Users/Lauren/Documents/MATLAB/m_map'));

for ii=1:length(ADC_radium(:,5))
   if ADC_radium(ii,5)>0
       ADC_radium(ii,5) = ADC_radium(ii,5) - 360;
   elseif ADC_radium(ii,5) == ADC_radium(ii,5)
   end
end

%%
map(73,84,115,194);

[x,y] = m_ll2xy(ADC_radium(:,5),ADC_radium(:,4));
l = find(ADC_radium(:,6)==2);

hold on;

% l1 = scatter(x(l),y(l),200,WMF(l,3),'o','filled','MarkerEdgeColor','k'); %MW
% colormap('parula');
% tt = colorbar;
% caxis([0 25]); 
% set(get(tt,'ylabel'),'String','% Meteoric water','FontSize',20); 

% l1 = scatter(x(l),y(l),200,WMF(l,5),'o','filled','MarkerEdgeColor','k'); %SIM - use one in section below with sea ice
% colormap(cmocean('balance'));
% tt = colorbar;
% caxis([-12 6]); 
% set(get(tt,'ylabel'),'String','% SIM','FontSize',20); 

%  
% l1 = scatter(x(l),y(l),200,WMF(l,7),'o','filled','MarkerEdgeColor','k'); %ATL
% colormap('parula');
% tt = colorbar;
% caxis([0 100]); 
% set(get(tt,'ylabel'),'String','% Atlantic','FontSize',24); 

l1 = scatter(x(l),y(l),200,WMF(l,9),'o','filled','MarkerEdgeColor','k'); %PAC
colormap('parula');
tt = colorbar;
caxis([0 100]); 
set(get(tt,'ylabel'),'String','% Pacific','FontSize',24); 

good_titles(20);


%% SIM with sea ice extent

addpath('/Users/Lauren/Dropbox/MATLAB/ARION_2021/extent_N_202109_polyline_v3.0');
addpath('/Users/Lauren/Dropbox/MATLAB/ARION_2021/polarstereo_inv');
addpath('/Users/kipp/Dropbox/MATLAB/ARION_2021/extent_N_202109_polyline_v3.0');
addpath('/Users/kipp/Dropbox/MATLAB/ARION_2021/polarstereo_inv');

S = shaperead('extent_N_202109_polyline_v3.0');
x = S.X;
y = S.Y;
a = 6378137.0;
e = 0.08181919;
phi_c = 70;
lambda_0 = -45;

[LAT,LON]=polarstereo_inv(x,y,a,e,phi_c,lambda_0);
%POLARSTEREO_INV transforms map coordinates to lat/lon data for a polar stereographic system
%   [LAT,LON]=POLARSTEREO_INV(X,Y,EARTHRADIUS,ECCENTRICITY,LAT_TRUE,LON_POSY) 
%   LAT and LON are in decimal degrees with negative numbers (-) for S and W. 
%   X and Y are the map coordinates (scalars, vectors, or matrices of equal size).
%   EARTHRADIUS is the radius of the earth defined in the projection
%       (default is 6378137.0 m, WGS84)
%   ECCENTRICITY is the earth's misshapenness 
%       (default is 0.08181919)
%   LAT_TRUE is the latitude of true scale in degrees, aka standard parallel 
%       (default is -70). Note that some NSIDC data use 70 and some use 71.
%   LON_POSY is the meridian in degrees along the positive Y axis of the map 
%       (default is 0)

for ii=1:length(LON)
   if LON(ii)>0
       LON(ii) = LON(ii) - 360;
   elseif LON(ii) == LON(ii)
   end
end


lat = LAT(~isnan(LAT))'; lon = LON(~isnan(LON))';
lonf = flipud(lon);
latf = flipud(lat);

% map_polar(25);
map(73,84,115,194);
[x,y] = m_ll2xy(ADC_radium(:,5),ADC_radium(:,4));
l = find(ADC_radium(:,6)==2);
m_patch(lonf,latf,[188/255 189/255 220/255],'FaceAlpha',0.7,'EdgeColor',[188/255 189/255 220/255]);

l1 = scatter(x(l),y(l),200,WMF(l,5),'o','filled','MarkerEdgeColor','k'); %SIM
colormap(cmocean('balance'));
tt = colorbar;
caxis([-12 6]); 
set(get(tt,'ylabel'),'String','% SIM','FontSize',20); 

good_titles(20);

%% SIM with ice extent tests/scrap
map(73,84,115,194);
% map(70,90,115,194);

% [x,y] = m_ll2xy(ADC_radium(:,5),ADC_radium(:,4));
% l = find(ADC_radium(:,6)==2);

hold on;
% m_patch(fliplr(LON),fliplr(LAT),[0.5 0.5 0.5],'FaceAlpha',0.5);

lat = LAT(~isnan(LAT))'; lon = LON(~isnan(LON))';
LONf = fliplr(LON)';
LATf = fliplr(LAT)';

lonf = flipud(lon);
latf = flipud(lat);
m_patch(lonf,latf,[0.5 0.5 0.5],'FaceAlpha',0.5);

% m_patch(LONf(120:308),LATf(120:308),[0.5 0.5 0.5],'FaceAlpha',0.5);
% m_patch(LONf(81:308),LATf(81:308),[0.5 0.5 0.5],'FaceAlpha',0.5);
up_lon = [-245:1:-166];
up_lat = [84*ones(1,length(up_lon))];
% lo = [-245,LON(129:231),-166,fliplr(up_lon)]';
% la = [84,LAT(129:231),84,up_lat]';
lo = [-245,LON(129:199),-166,fliplr(up_lon)]';
la = [84,LAT(129:199),84,up_lat]';
m_patch(lo,la,[0.5 0.5 0.5],'FaceAlpha',0.5);
% m_patch(fliplr(lo),fliplr(la),[0.5 0.5 0.5],'FaceAlpha',0.5);

% m_patch(LON(129:231),LAT(129:231),[0.5 0.5 0.5],'FaceAlpha',0.5);
% m_patch(LONf(78:179),LATf(78:179),[0.5 0.5 0.5],'FaceAlpha',0.5);
% m_patch(LONf,LATf,[0.5 0.5 0.5],'FaceAlpha',0.5);
