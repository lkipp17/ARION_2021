% stations for Ra-WMF comparison

% addpath(genpath('/Users/Lauren/Documents/MATLAB/m_map'));
addpath(genpath('/Users/kipp/Documents/MATLAB/m_map'));

C1 = [0.2081,0.1663,0.5292];
C2 = [0.0244,0.4350,0.8755];
C3 = [0.1986,0.7214,0.6310];
C4 = [0.9856,0.7372,0.2537];
C5 = [0.9763,0.9831,0.0538];

% data stored in Ra_WMF_matched.xlsx in ARION google drive folder
load Ra_WMF_allyrs.mat;

%% map

ortho_map(25);
[x_2007,y_2007] = m_ll2xy(Lon_2007,Lat_2007); % convert lat/lon to xx/yy
[x_2011,y_2011] = m_ll2xy(Lon_2011,Lat_2011); % convert lat/lon to xx/yy
[x_2015,y_2015] = m_ll2xy(Lon_2015,Lat_2015); % convert lat/lon to xx/yy
[x_2018,y_2018] = m_ll2xy(Lon_2018,Lat_2018); % convert lat/lon to xx/yy
[x_2021,y_2021] = m_ll2xy(Lon_2021,Lat_2021); % convert lat/lon to xx/yy

h = find(Depth_2007 ==7 & Lat_2007>84);
j = find(Depth_2015<20 & Lat_2015>84); % GT_depth==2 & 
k = find(Depth_2021<20 & 12<Stn_2021(:,1) & Stn_2021<63); % entire along-slope section + part of triangle
% k = find(Depth_2021<=2 0& 13<Stn_2021(:,1) & Stn_2021<54); % entire along-slope section
l = find(Depth_2021<20 & 74<=Stn_2021 & Stn_2021<=89);

hold on
l1 = scatter(x_2007(h),y_2007(h),50,'s','Filled','MarkerEdgeColor','k','MarkerFaceColor',C1);
l2 = scatter(x_2011,y_2011,50,'>','Filled','MarkerEdgeColor','k','MarkerFaceColor',C2);
l3 = scatter(x_2015(j),y_2015(j),50,'<','Filled','MarkerEdgeColor','k','MarkerFaceColor',C3);
l4 = scatter(x_2018,y_2018,50,'d','Filled','MarkerEdgeColor','k','MarkerFaceColor',[C5]);
l5 = scatter(x_2021(k),y_2021(k),50,'o','Filled','MarkerEdgeColor','k','MarkerFaceColor',C4);
scatter(x_2021(l),y_2021(l),50,'o','Filled','MarkerEdgeColor','k','MarkerFaceColor',C4);

good_titles(20);   
legend([l1 l2 l3 l4 l5],{'2007' '2011' '2015' '2018' '2021'},'location','northeast');