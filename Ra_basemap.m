%% basemap for ARION 2021

addpath(genpath('/Users/Lauren/Documents/MATLAB/m_map'));

C1 = [0.2081,0.1663,0.5292];
C2 = [0.0244,0.4350,0.8755];
C3 = [0.1986,0.7214,0.6310];
C4 = [0.9856,0.7372,0.2537];
C5 = [0.9763,0.9831,0.0538];

load ARION2021_metadata.mat;

%% whole arctic map
% ortho_map(25);
% moor_lon = [171.7433, 142.2536];
% moor_lat = [79.0517, 79.9367];
% [x,y] = m_ll2xy(moor_lon,moor_lat); % convert lat/lon to xx/yy
% scatter(x,y,170,'o','filled','MarkerEdgeColor','k');

ortho_map(25);


% NABOS overlay
% addpath(genpath('/Volumes/Seagate/MATLAB/NABOS'));
addpath(genpath('/Users/Lauren/Documents/MATLAB/NABOS'));
load station_locs.mat; % station/lat/lon(E)

NABOS_stn = NABOS_stns(:,1);
NABOS_lat = NABOS_stns(:,2);
NABOS_lon = NABOS_stns(:,3);
for ii=1:length(NABOS_lon)
   if NABOS_lon(ii)>0
       NABOS_lon(ii) = NABOS_lon(ii) - 360;
   elseif NABOS_lon(ii) == NABOS_lon(ii)
   end
end

[x,y] = m_ll2xy(NABOS_lon,NABOS_lat);
scatter(x,y,50,'^','filled','MarkerEdgeColor','k','MarkerFaceColor',C3);


[x,y] = m_ll2xy(Longitude,Latitude); % convert lat/lon to xx/yy
% scatter(x,y,100,'o','filled','MarkerEdgeColor','k');

CTD_i = find(Type=="CTD"); %CTD_i = CTD_i(3:57);
surf_i = find(Type=="surface");
ice_i = find(Type=="ice");

surf_x = x(surf_i); surf_y = y(surf_i);
CTD_x = x(CTD_i); CTD_y = y(CTD_i);

hold on;
% l1 = scatter(surf_x,surf_y,50,'o','filled','MarkerEdgeColor','k','MarkerFaceColor',C3);
l1 = scatter(x(surf_i),y(surf_i),50,'o','filled','MarkerEdgeColor','k','MarkerFaceColor',C3);
% l2 = scatter(x(CTD_i),y(CTD_i),50,'o','filled','MarkerEdgeColor','k','MarkerFaceColor',C5);
% l3 = scatter(x(ice_i),y(ice_i),50,'o','filled','MarkerEdgeColor','k','MarkerFaceColor',C5);

% m_scatter(Longitude(surf_i),Latitude(surf_i));
% m_scatter(Longitude(CTD_i),Latitude(CTD_i));


%%
figure;

% [x,y] = m_ll2xy(Longitude,Latitude);
l1 = scatter(x(surf_i),y(surf_i),50,'o','filled','MarkerEdgeColor','k','MarkerFaceColor',C3);
hold on;
l2 = scatter(x(CTD_i),y(CTD_i),50,'o','filled','MarkerEdgeColor','k','MarkerFaceColor',C5);
set(gcf,'units','pixels','position',[222 206 982 754]) % figure size and screen position
set(gcf,'renderer','painters') % idk what this does
m_proj('stereographic','lat',90,'long',0,'radius',25); % stereographic projection
% m_grid('ytick',[70 80],'fontsize',12,'yticklabels',[]);
m_grid;


%% zoomed in map

sqmap(-160,-265,65,90,140) %minlon,maxlon,minlat,maxlat,center

for ii=1:length(Longitude)
   if Longitude(ii)>0
       Longitude(ii) = Longitude(ii) - 360;
   elseif Longitude(ii) == Longitude(ii)
   end
end

[x,y] = m_ll2xy(Longitude,Latitude); % convert lat/lon to xx/yy
% scatter(x,y,100,'o','filled','MarkerEdgeColor','k');

CTD_i = find(Type=="CTD");
surf_i = find(Type=="surface");
ice_i = find(Type=="ice");

l1 = scatter(x(surf_i),y(surf_i),80,'o','filled','MarkerEdgeColor','k');
l2 = scatter(x(CTD_i),y(CTD_i),80,'o','filled','MarkerEdgeColor','k');
l3 = scatter(x(ice_i),y(ice_i),80,'o','filled','MarkerEdgeColor','k');

% stn 44 and 90 are moorings
% [173.7768833,142.2544]
[mx,my] = m_ll2xy([ -186.2231,-217.7456],[78.99313333,79.9373]); % convert lat/lon to xx/yy
l4 = scatter(mx,my,80,'o','filled','MarkerEdgeColor','k');

legend([l1 l2 l3 l4],{'Surface' 'CTD' 'Ice' 'Mooring'},'FontSize',12)
