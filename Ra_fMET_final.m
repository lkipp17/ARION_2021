%% Ra v. fMET for manuscript, fMET all calculated same way (monte carlo)
% copied from Ra v fMET script 
% started 10/26/22

clear all; close all; clc;

% data stored in Ra_WMF_matched.xlsx in ARION google drive folder
load Ra_WMF_allyrs.mat;

C1 = [0.2081,0.1663,0.5292];
C2 = [0.0244,0.4350,0.8755];
C3 = [0.1986,0.7214,0.6310];
C4 = [0.9856,0.7372,0.2537];
C5 = [0.9763,0.9831,0.0538];


%% figure- 2021 surface only

h = find(Depth_2007 ==7 & Lat_2007>84);
j = find(Depth_2015<50 & Lat_2015>84); % GT_depth==2 & 
k = find(Depth_2021<=2 & 13<Stn_2021(:,1) & Stn_2021<63); % entire along-slope section
% k = find(Depth_2021<=2 & 13<Stn_2021(:,1) & Stn_2021<53); % entire along-slope section
% l = find(Depth_2021<=2 & 78<=Stn_2021 & Stn_2021<=89);
l = find(Depth_2021<=2 & 74<=Stn_2021 & Stn_2021<=89);


figure;
hold on
errorbar(WMF_2007(h),Ra_2007(h),Ra_err_2007(h),'ok');
l1 = scatter(WMF_2007(h),Ra_2007(h),70,'s','Filled','MarkerEdgeColor','k','MarkerFaceColor',C1);
errorbar(WMF_2011,Ra_2011,Ra_err_2011,'ok');
l2 = scatter(WMF_2011,Ra_2011,70,'>','Filled','MarkerEdgeColor','k','MarkerFaceColor',C2);
errorbar(WMF_2015(j),Ra_2015(j),Ra_err_2015(j),'ok');
l3 = scatter(WMF_2015(j),Ra_2015(j),70,'<','Filled','MarkerEdgeColor','k','MarkerFaceColor',C3);
errorbar(WMF_2018,Ra_2018,Ra_err_2018,'ok');
l4 = scatter(WMF_2018,Ra_2018,70,'d','Filled','MarkerEdgeColor','k','MarkerFaceColor',[C5]);
errorbar(WMF_2021(k),Ra_2021(k),Ra_err_2021(k),'ok');
l5 = scatter(WMF_2021(k),Ra_2021(k),70,'o','Filled','MarkerEdgeColor','k','MarkerFaceColor',C4);
errorbar(WMF_2021(l),Ra_2021(l),Ra_err_2021(l),'ok');
scatter(WMF_2021(l),Ra_2021(l),70,'o','Filled','MarkerEdgeColor','k','MarkerFaceColor',C4);
xlabel('% meteoric water'); ylabel('^{228}Ra (dpm 100L^{-1})'); 

xlim([0 30]); ylim([0 40]);
good_titles(20);   
legend([l1 l2 l3 l4 l5],{'2007' '2011' '2015' '2018' '2021'},'location','northeast');

%% figure- 2021 down to 20 m

h = find(Depth_2007 ==7 & Lat_2007>84);
j = find(Depth_2015<20 & Lat_2015>84); % GT_depth==2 & 
k = find(Depth_2021<20 & 12<Stn_2021(:,1) & Stn_2021<63); % entire along-slope section + part of triangle
% k = find(Depth_2021<=2 0& 13<Stn_2021(:,1) & Stn_2021<54); % entire along-slope section
l = find(Depth_2021<20 & 74<=Stn_2021 & Stn_2021<=89);

figure;
hold on
errorbar(WMF_2007(h),Ra_2007(h),Ra_err_2007(h),'ok');
l1 = scatter(WMF_2007(h),Ra_2007(h),70,'s','Filled','MarkerEdgeColor','k','MarkerFaceColor',C1);
errorbar(WMF_2011,Ra_2011,Ra_err_2011,'ok');
l2 = scatter(WMF_2011,Ra_2011,70,'>','Filled','MarkerEdgeColor','k','MarkerFaceColor',C2);
errorbar(WMF_2015(j),Ra_2015(j),Ra_err_2015(j),'ok');
l3 = scatter(WMF_2015(j),Ra_2015(j),70,'<','Filled','MarkerEdgeColor','k','MarkerFaceColor',C3);
errorbar(WMF_2018,Ra_2018,Ra_err_2018,'ok');
l4 = scatter(WMF_2018,Ra_2018,70,'d','Filled','MarkerEdgeColor','k','MarkerFaceColor',[C5]);
errorbar(WMF_2021(k),Ra_2021(k),Ra_err_2021(k),'ok');
l5 = scatter(WMF_2021(k),Ra_2021(k),70,'o','Filled','MarkerEdgeColor','k','MarkerFaceColor',C4);
errorbar(WMF_2021(l),Ra_2021(l),Ra_err_2021(l),'ok');
scatter(WMF_2021(l),Ra_2021(l),70,'o','Filled','MarkerEdgeColor','k','MarkerFaceColor',C4);
xlabel('% meteoric water'); ylabel('^{228}Ra (dpm 100L^{-1})'); 

xlim([0 30]); %ylim([0 40]);
good_titles(20);   
legend([l1 l2 l3 l4 l5],{'2007' '2011' '2015' '2018' '2021'},'location','northwest');

%% salinity

h = find(Depth_2007 ==7 & Lat_2007>84);
j = find(Depth_2015<50 & Lat_2015>84); 
k = find(Depth_2021<50 & 34<Stn_2021(:,1) & Stn_2021<63);
l = find(Depth_2021<50 & 78<=Stn_2021 & Stn_2021<=89);
% k = find(Depth_2021<=2 & 34<Stn_2021(:,1) & Stn_2021<63);
% l = find(Depth_2021<=2 & 78<=Stn_2021 & Stn_2021<=89);

figure;
hold on
errorbar(Sal_2007(h),Ra_2007(h),Ra_err_2007(h),'ok');
l1 = scatter(Sal_2007(h),Ra_2007(h),70,'s','Filled','MarkerEdgeColor','k','MarkerFaceColor',C1);
errorbar(Sal_2011,Ra_2011,Ra_err_2011,'ok');
l2 = scatter(Sal_2011,Ra_2011,70,'>','Filled','MarkerEdgeColor','k','MarkerFaceColor',C2);
errorbar(Sal_2015(j),Ra_2015(j),Ra_err_2015(j),'ok');
l3 = scatter(Sal_2015(j),Ra_2015(j),70,'<','Filled','MarkerEdgeColor','k','MarkerFaceColor',C3);
errorbar(Sal_2018,Ra_2018,Ra_err_2018,'ok');
l4 = scatter(Sal_2018,Ra_2018,70,'d','Filled','MarkerEdgeColor','k','MarkerFaceColor',[C5]);
errorbar(Sal_2021(k),Ra_2021(k),Ra_err_2021(k),'ok');
l5 = scatter(Sal_2021(k),Ra_2021(k),70,'o','Filled','MarkerEdgeColor','k','MarkerFaceColor',C4);
errorbar(Sal_2021(l),Ra_2021(l),Ra_err_2021(l),'ok');
scatter(Sal_2021(l),Ra_2021(l),70,'o','Filled','MarkerEdgeColor','k','MarkerFaceColor',C4);
xlabel('Salinity'); ylabel('^{228}Ra (dpm 100L^{-1})'); 

% ylim([0 40]);
% xlim([0 30]); 
good_titles(20);   
legend([l1 l2 l3 l4 l5],{'2007' '2011' '2015' '2018' '2021'},'location','northeast');

%% figure- along-slope for 2021

h = find(Depth_2007 ==7 & Lat_2007>84);
j = find(Depth_2015<50 & Lat_2015>84); % GT_depth==2 & 
% k = find(Depth_2021<=50 & 13<Stn_2021 & Stn_2021<63); % entire along-slope section
k = find(Depth_2021<=50 & 13<Stn_2021 & Stn_2021<53); % entire along-slope section
% l = find(Depth_2021<=2 & 78<=Stn_2021 & Stn_2021<=89);

figure;
hold on
errorbar(WMF_2007(h),Ra_2007(h),Ra_err_2007(h),'ok');
l1 = scatter(WMF_2007(h),Ra_2007(h),70,'s','Filled','MarkerEdgeColor','k','MarkerFaceColor',C5);
errorbar(WMF_2011,Ra_2011,Ra_err_2011,'ok');
l2 = scatter(WMF_2011,Ra_2011,70,'>','Filled','MarkerEdgeColor','k','MarkerFaceColor',C2);
errorbar(WMF_2015(j),Ra_2015(j),Ra_err_2015(j),'ok');
l3 = scatter(WMF_2015(j),Ra_2015(j),70,'<','Filled','MarkerEdgeColor','k','MarkerFaceColor',C3);
errorbar(WMF_2021(k),Ra_2021(k),Ra_err_2021(k),'ok');
l5 = scatter(WMF_2021(k),Ra_2021(k),70,'o','Filled','MarkerEdgeColor','k','MarkerFaceColor',C4);
xlabel('% meteoric water'); ylabel('^{228}Ra (dpm 100L^{-1})'); 

xlim([0 30]); %ylim([0 40]);
good_titles(20);   
legend([l1 l2 l3 l5],{'2007' '2011' '2015' '2021'},'location','northeast');

