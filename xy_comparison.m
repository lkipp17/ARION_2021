%% xy comparison
% started 2/4/22

load AR21_exportFeb22.mat; 

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

%% Ra-228 vs Ra-226

j = find(GT_depth<301);

figure;
hold on;
l1 = scatter(AR21_Feb22(:,12),AR21_Feb22(:,10),70,'o','filled','MarkerEdgeColor','k');
l2 = scatter(GT_Ra226(j),GT_Ra228(j),70,'^','filled','MarkerEdgeColor','k');
l3 = scatter(N18_Ra226,N18_Ra228,70,'d','filled','MarkerEdgeColor','k');
xlabel('^{226}Ra (dpm/100L)'); ylabel('^{228}Ra (dpm/100L)'); ylim([0 40]); xlim([0 18]);
legend([l1 l3 l2], {'NABOS Sep 2021' 'NABOS Sep 2018' 'GT Sep 2015'}, 'location','northwest','fontsize',12);
good_titles(16);

k = find(AR21_Feb22(:,6) == 2);

figure;
hold on;
l1 = scatter(AR21_Feb22(k,12),AR21_Feb22(k,10),70,'o','filled','MarkerEdgeColor','k');
l2 = scatter(GT_Ra226_bar,GT_Ra228_bar,70,'^','filled','MarkerEdgeColor','k');
l3 = scatter(N18_Ra226,N18_Ra228,70,'d','filled','MarkerEdgeColor','k');
xlabel('^{226}Ra (dpm/100L)'); ylabel('^{228}Ra (dpm/100L)'); ylim([0 40]); xlim([0 18]);
legend([l1 l3 l2], {'NABOS Sep 2021' 'NABOS Sep 2018' 'GT Sep 2015'}, 'location','northwest','fontsize',12);
good_titles(16);

%% Ra-228 vs. sal

k = find(AR21_Feb22(:,6) == 2);

figure;
hold on;
% l1 = scatter(AR21_Feb22(:,8),AR21_Feb22(:,10),70,'o','filled','MarkerEdgeColor','k');
% l1 = scatter(AR21_Feb22(k,8),AR21_Feb22(k,10),70,'o','filled','MarkerEdgeColor','k');
l1 = scatter(AR21_Feb22(:,8),AR21_Feb22(:,10),80,AR21_Feb22(:,6),'o','filled','MarkerEdgeColor','k');
% l2 = scatter(N18_sal,N18_Ra228,70,'d','filled','MarkerEdgeColor','k');
l2 = scatter(N18_sal,N18_Ra228,80,ones(length(N18_Ra228),1)*2,'d','filled','MarkerEdgeColor','k');
xlabel('salinity'); ylabel('^{228}Ra (dpm/100L)'); ylim([0 40]); %xlim([0 18]);
legend([l1 l2], {'NABOS Sep 2021' 'NABOS Sep 2018'}, 'location','northeast','fontsize',12);
colormap(cmocean('deep'));
tt = colorbar; set(get(tt,'ylabel'),'String','Depth (m)','FontSize',16);
good_titles(16);

%% Ra-228 vs. sal w GT

GT_bar = load('/Users/kipp/Documents/MATLAB/NABOS_2017/GN01_barrels.mat');
GT_sal = GT_bar.sal_bar;
GT_Ra228 = GT_bar.Ra228_bar;
GT_RAR = GT_bar.RAR_bar;
GT_lat = GT_bar.lat_bar;

k = find(AR21_Feb22(:,6) == 2);
j = find(GT_lat>84); % GT_depth==2 & 

figure;
hold on;
l3 = scatter(GT_sal(j),GT_Ra228(j),70,'<','filled','MarkerFaceColor',[0.5 0.5 0.5],'MarkerEdgeColor','k');
% l1 = scatter(AR21_Feb22(:,8),AR21_Feb22(:,16),70,'o','filled','MarkerEdgeColor','k');
l1 = scatter(AR21_Feb22(:,8),AR21_Feb22(:,10),80,AR21_Feb22(:,6),'o','filled','MarkerEdgeColor','k');
% l1 = scatter(AR21_Feb22(k,8),AR21_Feb22(k,16),70,'o','filled','MarkerEdgeColor','k');
l2 = scatter(N18_sal,N18_Ra228,80,ones(length(N18_Ra228),1)*2,'d','filled','MarkerEdgeColor','k');
xlabel('salinity'); ylabel('^{228}Ra (dpm/100L)'); %ylim([0 3]); %xlim([0 18]);
legend([l1 l2 l3], {'Sep 2021 (East Siberian slope)' 'Sep 2018 (East Siberian slope)' 'Sept 2015 (TPD, >84N)'}, 'location','northeast','fontsize',12);
colormap(cmocean('deep'));
tt = colorbar; set(get(tt,'ylabel'),'String','Depth (m)','FontSize',16);
good_titles(16);

%% RAR vs. sal

k = find(AR21_Feb22(:,6) == 2);

figure;
hold on;
% l1 = scatter(AR21_Feb22(:,8),AR21_Feb22(:,16),70,'o','filled','MarkerEdgeColor','k');
l1 = scatter(AR21_Feb22(:,8),AR21_Feb22(:,16),80,AR21_Feb22(:,6),'o','filled','MarkerEdgeColor','k');
% l1 = scatter(AR21_Feb22(k,8),AR21_Feb22(k,16),70,'o','filled','MarkerEdgeColor','k');
l2 = scatter(N18_sal,N18_RAR,80,ones(length(N18_RAR),1)*2,'d','filled','MarkerEdgeColor','k');
xlabel('salinity'); ylabel('^{228}Ra/^{226}Ra'); ylim([0 3]); %xlim([0 18]);
legend([l1 l2], {'Sep 2021' 'Sep 2018'}, 'location','northeast','fontsize',12);
colormap(cmocean('deep'));
tt = colorbar; set(get(tt,'ylabel'),'String','Depth (m)','FontSize',16);
good_titles(16);

%% RAR vs. sal w GT

GT_bar = load('/Users/kipp/Documents/MATLAB/NABOS_2017/GN01_barrels.mat');
GT_sal = GT_bar.sal_bar;
GT_Ra228 = GT_bar.Ra228_bar;
GT_RAR = GT_bar.RAR_bar;
GT_lat = GT_bar.lat_bar;

k = find(AR21_Feb22(:,6) == 2);
j = find(GT_lat>84); % GT_depth==2 & 

figure;
hold on;
l3 = scatter(GT_sal(j),GT_RAR(j),70,'<','filled','MarkerFaceColor',[0.5 0.5 0.5],'MarkerEdgeColor','k');
% l1 = scatter(AR21_Feb22(:,8),AR21_Feb22(:,16),70,'o','filled','MarkerEdgeColor','k');
l1 = scatter(AR21_Feb22(:,8),AR21_Feb22(:,16),80,AR21_Feb22(:,6),'o','filled','MarkerEdgeColor','k');
% l1 = scatter(AR21_Feb22(k,8),AR21_Feb22(k,16),70,'o','filled','MarkerEdgeColor','k');
l2 = scatter(N18_sal,N18_RAR,80,ones(length(N18_RAR),1)*2,'d','filled','MarkerEdgeColor','k');
xlabel('salinity'); ylabel('^{228}Ra/^{226}Ra'); ylim([0 3]); %xlim([0 18]);
legend([l1 l2 l3], {'Sep 2021 (East Siberian slope)' 'Sep 2018 (East Siberian slope)' 'Sept 2015 (TPD, >84N)'}, 'location','northeast','fontsize',12);
colormap(cmocean('deep'));
tt = colorbar; set(get(tt,'ylabel'),'String','Depth (m)','FontSize',16);
good_titles(16);

%% Ra-226 vs. sal

k = find(AR21_Feb22(:,6) == 2);

figure;
hold on;
% l1 = scatter(AR21_Feb22(:,8),AR21_Feb22(:,10),70,'o','filled','MarkerEdgeColor','k');
% l1 = scatter(AR21_Feb22(k,8),AR21_Feb22(k,10),70,'o','filled','MarkerEdgeColor','k');
l1 = scatter(AR21_Feb22(:,8),AR21_Feb22(:,12),80,AR21_Feb22(:,6),'o','filled','MarkerEdgeColor','k');
% l2 = scatter(N18_sal,N18_Ra228,70,'d','filled','MarkerEdgeColor','k');
l2 = scatter(N18_sal,N18_Ra226,80,ones(length(N18_Ra226),1)*2,'d','filled','MarkerEdgeColor','k');
xlabel('salinity'); ylabel('^{226}Ra (dpm/100L)'); ylim([5 15]); 
legend([l1 l2], {'NABOS Sep 2021' 'NABOS Sep 2018'}, 'location','southwest','fontsize',12);
colormap(cmocean('deep'));
tt = colorbar; set(get(tt,'ylabel'),'String','Depth (m)','FontSize',16);
good_titles(16);