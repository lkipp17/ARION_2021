%% map for NABOS 2024 proposal renewal
% started 4/1/24

% addpath(genpath('/Users/Lauren/Documents/MATLAB/m_map'));
addpath(genpath('/Users/kipp/Documents/MATLAB/m_map'));

% data stored in Ra_WMF_matched.xlsx in ARION google drive folder
load Ra_WMF_allyrs.mat;

%%
fig = ortho_map_ESS(20); set(fig,'Position',[920,552,579,462]);
[x_2007,y_2007] = m_ll2xy(Lon_2007,Lat_2007); % convert lat/lon to xx/yy
[x_2011,y_2011] = m_ll2xy(Lon_2011,Lat_2011); % convert lat/lon to xx/yy
[x_2015,y_2015] = m_ll2xy(Lon_2015,Lat_2015); % convert lat/lon to xx/yy
[x_2018,y_2018] = m_ll2xy(Lon_2018,Lat_2018); % convert lat/lon to xx/yy
[x_2021,y_2021] = m_ll2xy(Lon_2021,Lat_2021); % convert lat/lon to xx/yy

h = find(Depth_2007 ==7 & Lat_2007>84);
j = find(Depth_2015<20 & Lat_2015>84); % GT_depth==2 & 
k = find(Depth_2021<20 & 12<Stn_2021(:,1) & Stn_2021<90); % entire along-slope section + part of triangle
% k = find(Depth_2021<20 & 12<Stn_2021(:,1) & Stn_2021<63); % entire along-slope section + part of triangle
% k = find(Depth_2021<=2 0& 13<Stn_2021(:,1) & Stn_2021<54); % entire along-slope section
l = find(Depth_2021<20 & 43<=Stn_2021 & Stn_2021<=48);

hold on
% l1 = scatter(x_2007(h),y_2007(h),50,Ra_2007(h),'s','Filled','MarkerEdgeColor','none');
% l2 = scatter(x_2011,y_2011,50,Ra_2011,'>','Filled','MarkerEdgeColor','none');
l3 = scatter(x_2015(j),y_2015(j),100,Ra_2015(j),'<','Filled','MarkerEdgeColor','none');
l4 = scatter(x_2018,y_2018,80,Ra_2018,'d','Filled','MarkerEdgeColor','none');
% l5 = scatter(x_2021,y_2021,100,Ra_2021,'o','Filled','MarkerEdgeColor','none');
l5 = scatter(x_2021(k),y_2021(k),75,Ra_2021(k),'o','Filled','MarkerEdgeColor','none');
% scatter(x_2021(l),y_2021(l),75,Ra_2021(l),'o','Filled','MarkerEdgeColor','none');

colormap('parula');
tt = colorbar;
caxis([0 30]); 
set(get(tt,'ylabel'),'String','Ra-228','FontSize',20);
tt.Location = 'southoutside';

legend([l3 l4 l5],{'2015' '2018' '2021'},'location','northeast');
good_titles(20);   
