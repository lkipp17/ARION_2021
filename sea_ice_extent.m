%% sea ice extent

% map(73,90,115,194);
figure;
set(gcf,'units','pixels','position',[222 206 982 754]) % figure size and screen position
set(gcf,'renderer','painters') % idk what this does
m_proj('stereographic','lat',90,'long',-45,'radius',25);
m_gshhs_l('patch',[.5,.5,.5],'edgecolor','k') % low resolution land patch (increase resolution if zooming in to small area by switching to m_gshhs_i, m_gshhs_h, or m_gshhs_f)
m_grid('ytick',[90 85 80 75],'fontsize',12);

addpath('/Users/kipp/Dropbox/MATLAB/ARION_2021/extent_N_202109_polyline_v3.0');
% M=m_shaperead('extent_N_202109_polyline_v3.0'); 
% for k=1:length(M.ncst), 
%      line(M.ncst{k}(:,1),M.ncst{k}(:,2)); 
% end; 
% mapshow(M);
% figure;
 S = shaperead('extent_N_202109_polyline_v3.0');
 [x,y] = m_xy2ll(S.Y,S.X);

 mapshow(S);
%  line(S.X,S.Y);
line(long,lat);

%%
addpath('/Users/Lauren/Dropbox/MATLAB/ARION_2021/extent_N_202109_polyline_v3.0');
addpath('/Users/Lauren/Dropbox/MATLAB/ARION_2021/polarstereo_inv');

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

%%
addpath('/Users/Lauren/Dropbox/MATLAB/ARION_2021/extent_N_202109_polygon_v3.0');
addpath('/Users/Lauren/Dropbox/MATLAB/ARION_2021/polarstereo_inv');

S = shaperead('extent_N_202109_polygon_v3.0');
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

map_polar(25);
% m_line(LON,LAT);
m_patch(S.Y,S.X,[0.5 0.5 0.5]);

m_line(S.Y,S.X);
