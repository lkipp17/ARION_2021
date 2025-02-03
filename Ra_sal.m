%% xy comparison
% started 2/4/22

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

GT_bar = load('/Users/kipp/Documents/MATLAB/NABOS_2018/GN01_barrels.mat');
GT_sal = GT_bar.sal_bar;
GT_Ra228 = GT_bar.Ra228_bar;
GT_RAR = GT_bar.RAR_bar;
GT_lat = GT_bar.lat_bar;

RVDL = load('/Users/kipp/Documents/MATLAB/NABOS_2018/ARKXXII2_Ra_WMF.mat');
RVDL_sal = RVDL.ARKXXII2_Sal;
RVDL_lat = RVDL.ARKXXII2_Latitude;
RVDL_Ra228 = RVDL.ARKXXII2_Ra228./10;
RVDL_depth = RVDL.ARKXXII2_Depth;
RVDL_RAR = RVDL.ARKXXII2_Ra228_Ra226;

% PS-78 (2011)
PS78_Ra = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','PS78','K6:K44')./10;
PS78_Ra_err = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','PS78','L6:L44')./10;
% RAR_2011 = xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','PS78','K6:K44')./xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','PS78','I6:I44');
PS78_sal = [xlsread('/Users/kipp/Dropbox/Arctic_Ra_compilation.xlsx','PS78','M6:M44');NaN;];

%%
h = find(RVDL_lat>85 & RVDL_depth ==7);
% k = find(AR21_Feb22(:,6) == 2);
j = find(GT_lat>85); % GT_depth==2 & 
k = find(AR21_Feb22(:,6)<=2 & 34<AR21_Feb22(:,1) & AR21_Feb22(:,1)<63);
l = find(AR21_Feb22(:,6)<=2 & 78<=AR21_Feb22(:,1) & AR21_Feb22(:,1)<=89);

% figure;
% hold on;
% % l4 = scatter(RVDL_sal(h),RVDL_Ra228(h),70,RVDL_depth(h),'s','filled','MarkerEdgeColor','k');
% l4 = scatter(RVDL_sal(h),RVDL_Ra228(h),70,'s','filled','MarkerFaceColor',[0.8 0.8 0.8],'MarkerEdgeColor','k');
% l3 = scatter(GT_sal(j),GT_Ra228(j),70,'<','filled','MarkerFaceColor',[0.5 0.5 0.5],'MarkerEdgeColor','k');
% % l1 = scatter(AR21_Feb22(:,8),AR21_Feb22(:,16),70,'o','filled','MarkerEdgeColor','k');
% l1 = scatter(AR21_Feb22(:,8),AR21_Feb22(:,10),80,AR21_Feb22(:,6),'o','filled','MarkerEdgeColor','k');
% % l1 = scatter(AR21_Feb22(k,8),AR21_Feb22(k,16),70,'o','filled','MarkerEdgeColor','k');
% l2 = scatter(N18_sal,N18_Ra228,80,ones(length(N18_Ra228),1)*2,'d','filled','MarkerEdgeColor','k');
% xlabel('salinity'); ylabel('^{228}Ra (dpm/100L)'); %ylim([0 3]); %xlim([0 18]);
% legend([l1 l2 l3 l4], {'Sep 2021 (slopes)' 'Sep 2018 (slopes)' 'Sept 2015 (TPD, >85N)' 'Sept 2007 (TPD, >85N)'}, 'location','northeast','fontsize',12);
% colormap(cmocean('deep'));
% tt = colorbar; set(get(tt,'ylabel'),'String','Depth (m)','FontSize',16);
% good_titles(16);


figure;
hold on;
l5 = scatter(RVDL_sal(h),RVDL_Ra228(h),70,'s','filled','MarkerFaceColor',[0.2081,0.1663,0.5292],'MarkerEdgeColor','k');
l4 =scatter(PS78_sal,PS78_Ra,70,'>','filled','MarkerFaceColor',[0.0244,0.4350,0.8755],'MarkerEdgeColor','k');
l3 = scatter(GT_sal(j),GT_Ra228(j),70,'<','filled','MarkerFaceColor',[0.1986,0.7214,0.6310],'MarkerEdgeColor','k');
l1 = scatter(AR21_Feb22(k,8),AR21_Feb22(k,10),80,'o','filled','MarkerFaceColor',[0.9856,0.7372,0.2537],'MarkerEdgeColor','k'); %[0.9856,0.7372,0.2537] %[0.6473,0.7456,0.4188]
l1 = scatter(AR21_Feb22(l,8),AR21_Feb22(l,10),80,'o','filled','MarkerFaceColor',[0.9856,0.7372,0.2537],'MarkerEdgeColor','k'); %[0.9856,0.7372,0.2537] %[0.6473,0.7456,0.4188]
l2 = scatter(N18_sal,N18_Ra228,80,ones(length(N18_Ra228),1),'d','filled','MarkerFaceColor',[0.9763,0.9831,0.0538],'MarkerEdgeColor','k');
xlabel('salinity'); ylabel('^{228}Ra (dpm/100L)'); ylim([0 30]); xlim([26 36]);
legend([l1 l2 l3 l4 l5], {'2021' '2018' '2015' '2011' '2007'}, 'location','northeast','fontsize',12);
good_titles(16);

%% RAR vs. sal

figure;
hold on;
l4 = scatter(RVDL_sal(h),RVDL_RAR(h),70,'s','filled','MarkerFaceColor',[0.5 0.5 0.5],'MarkerEdgeColor','k');
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

%% station color
h = find(RVDL_lat>85 & RVDL_depth ==7);
% k = find(AR21_Feb22(:,6) == 2);
k = find(AR21_Feb22(:,6)<=50 & 34<AR21_Feb22(:,1) & AR21_Feb22(:,1)<63);
j = find(GT_lat>85); % GT_depth==2 & 

figure;
hold on;
% l4 = scatter(RVDL_sal(h),RVDL_Ra228(h),70,RVDL_depth(h),'s','filled','MarkerEdgeColor','k');
l4 = scatter(RVDL_sal(h),RVDL_Ra228(h),70,'s','filled','MarkerFaceColor',[0.8 0.8 0.8],'MarkerEdgeColor','k');
l3 = scatter(GT_sal(j),GT_Ra228(j),70,'<','filled','MarkerFaceColor',[0.5 0.5 0.5],'MarkerEdgeColor','k');
% l2 = scatter(N18_sal,N18_Ra228,80,ones(length(N18_Ra228),1)*2,'d','filled','MarkerEdgeColor','k');
l2 = scatter(N18_sal,N18_Ra228,80,'d','filled','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor','k');
% l1 = scatter(AR21_Feb22(:,8),AR21_Feb22(:,16),70,'o','filled','MarkerEdgeColor','k');
% l1 = scatter(AR21_Feb22(:,8),AR21_Feb22(:,10),80,AR21_Feb22(:,1),'o','filled','MarkerEdgeColor','k');
l1 = scatter(AR21_Feb22(k,8),AR21_Feb22(k,10),80,AR21_Feb22(k,1),'o','filled','MarkerEdgeColor','k');
xlabel('salinity'); ylabel('^{228}Ra (dpm/100L)'); %ylim([0 3]); %xlim([0 18]);
legend([l1 l2 l3 l4], {'Sep 2021 (slopes)' 'Sep 2018 (slopes)' 'Sept 2015 (TPD, >85N)' 'Sept 2007 (TPD, >85N)'}, 'location','northeast','fontsize',12);
colormap('jet');
tt = colorbar; set(get(tt,'ylabel'),'String','Station','FontSize',16);
ylim([0 30]); xlim([26 36]); caxis([0 102]);
good_titles(16);