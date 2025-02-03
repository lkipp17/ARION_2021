
load AR21_Apr22.mat; 

N18 = load('NABOS_data_041719.mat');
N18_Ra228 = N18.Ra228;
N18_Ra228_err = N18.Ra228_err;
N18_Ra226 = N18.Ra226;
N18_Ra226_err = N18.Ra226_err;
N18_RAR = N18.RAR;
N18_RAR_err = N18.RAR_err;
N18_lat = N18.NABOS_lat;
N18_lon = N18.NABOS_lon;
N18_sal = N18.salinity;

for ii=1:length(AR21_Feb22(:,5))
   if AR21_Feb22(ii,5)>0
       AR21_Feb22(ii,5) = AR21_Feb22(ii,5) - 360;
   elseif AR21_Feb22(ii,5) == AR21_Feb22(ii,5)
   end
end

for ii=1:length(N18_lon)
   if N18_lon(ii)>0
       N18_lon(ii) = N18_lon(ii) - 360;
   elseif N18_lon(ii) == N18_lon(ii)
   end
end

for ii=1:length(AR21_Feb22(:,10))
   if AR21_Feb22(ii,10)==0
       AR21_Feb22(ii,10) = NaN;
   elseif AR21_Feb22(ii,10) == AR21_Feb22(ii,10)
   end
end

for ii=1:length(AR21_Feb22(:,16))
   if AR21_Feb22(ii,16)==0
       AR21_Feb22(ii,16) = NaN;
   elseif AR21_Feb22(ii,16) == AR21_Feb22(ii,16)
   end
end
% 
% AR21_RAR = AR21_Feb22(:,16);
% AR21_RAR_
%% load GEOTRACES data
 
GT_depth = xlsread('/Users/kipp/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','I2:I310');
i = find(GT_depth == 2);
GT_Ra226 = xlsread('/Users/kipp/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','K2:K310');
GT_Ra226_bar = GT_Ra226(i);
GT_Ra226_err = xlsread('/Users/kipp/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','J2:J310');
GT_Ra226_err_bar = GT_Ra226_err(i);
GT_Ra228 = xlsread('/Users/kipp/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','N2:N310');
GT_Ra228_bar = GT_Ra228(i);
GT_Ra228_err = xlsread('/Users/kipp/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','O2:O310');
GT_Ra228_err_bar = GT_Ra228_err(i);
GT_RAR = xlsread('/Users/kipp/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','AX2:AX310');
GT_RAR_bar = GT_RAR(i);
GT_stn = xlsread('/Users/kipp/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','F2:F310');
GT_stn = [-2; -1; GT_stn]; % dutch harbor and rinse are not read in; sub -2 and -1
GT_stn_bar = GT_stn(i);
GT_lat = xlsread('/Users/kipp/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','G2:G310');
GT_lat_bar = GT_lat(i);
GT_lon = xlsread('/Users/kipp/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','H2:H310');
for ii=1:length(GT_lon)
   if GT_lon(ii)>0
       GT_lon(ii) = GT_lon(ii) - 360;
   elseif GT_lon(ii) == GT_lon(ii)
   end
end
GT_lon_bar = GT_lon(i);

%% Ra-228 vs Ra-226 with river endmembers

j = find(GT_depth<301);
k = find(AR21_Feb22(:,6) == 2);

figure;
hold on;
% l1 = scatter(AR21_Feb22(k,12),AR21_Feb22(k,10),70,'o','filled','MarkerEdgeColor','k');
l1 = scatter(AR21_Feb22(:,12),AR21_Feb22(:,10),70,'o','filled','MarkerEdgeColor','k');
l2 = scatter(GT_Ra226_bar,GT_Ra228_bar,70,'^','filled','MarkerEdgeColor','k');
l3 = scatter(N18_Ra226,N18_Ra228,70,'d','filled','MarkerEdgeColor','k');
xlabel('^{226}Ra (dpm/100L)'); ylabel('^{228}Ra (dpm/100L)'); ylim([0 50]); xlim([0 30]);
good_titles(16);

% herrorbar_riv(5.84,20.04,0.20,'^k');
% E_shelf = plot(5.84,20.04,'^k','MarkerSize',13,'LineWidth',1.5,'MarkerFaceColor','w'); % RVDL03
% Ob River
% errorbar(27.31,40.94,3.70,'sk','LineWidth',1);
herrorbar_riv(27.31,40.94,0.61,'sk');
Ob = plot(27.31,40.94,'sk','MarkerSize',13,'LineWidth',1.5,'MarkerFaceColor','w'); % RVDL03
% Lena River max
% errorbar(13.11,24.89,0.9,'dk','LineWidth',1);
herrorbar_riv(13.11,24.89,0.41,'dk');
Lena = plot(13.11,24.89,'dk','MarkerSize',13,'LineWidth',1.5,'MarkerFaceColor','w'); % RVDL03
% Mackenzie river
% errorbar(17.2,16.8,3.7,'ok','LineWidth',1);
herrorbar_riv(17.2,16.8,4.0,'ok');
Mackenzie = plot(17.2,16.8,'ok','MarkerSize',12,'LineWidth',1.5,'MarkerFaceColor','w'); % our data
% % Beaufort shelf
% % errorbar(12.95,10.96,1.63,'>k','LineWidth',1);
% herrorbar_riv(12.95,10.96,1.13,'>k');
% Beaufort = plot(12.95,10.96,'>k','MarkerSize',13,'LineWidth',1.5,'MarkerFaceColor','w'); % Smith03

legend([l1 l3 l2 Ob Lena Mackenzie], {'NABOS Sep 2021' 'NABOS Sep 2018' 'GT Sep 2015' 'Ob' 'Lena' 'Mackenzie'}, 'location','northwest','fontsize',12);

%% Ra 228 vs Ra 226, NABOS only

k = find(AR21_Feb22(:,6) == 2);

figure;
hold on;
% l1 = scatter(AR21_Feb22(k,12),AR21_Feb22(k,10),70,'o','filled','MarkerEdgeColor','k');
l1 = scatter(AR21_Feb22(:,12),AR21_Feb22(:,10),70,'o','filled','MarkerEdgeColor','k');
l2 = scatter(N18_Ra226,N18_Ra228,70,'d','filled','MarkerEdgeColor','k');
xlabel('^{226}Ra (dpm/100L)'); ylabel('^{228}Ra (dpm/100L)'); ylim([0 50]); xlim([0 30]);
good_titles(16);
legend([l1 l2], {'NABOS Sep 2021' 'NABOS Sep 2018'}, 'location','northwest','fontsize',12);
