%% ARION 2021 water mass fractions
% started 4/22/22
% using 3-endmember Newton 2013 values (calculated 4/22)


load('/Users/kipp/Documents/MATLAB/ARION_2021/NABOS_2021_WMF_3end.mat');
MET_2021 = fractions(:,2).*100;
SIM_2021 = fractions(:,3).*100;
% stn = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','A5:A134');
% ID = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','B5:B134');
depth_2021 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','F5:F134');
Ra_2021 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','M5:M134');
Ra_err_2021 = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','N5:N134');
i = find(depth_2021<=50);

C13 = [215,25,28]./255; % red
C14 = [253,174,97]./255; % orangish
C15 = [171,217,233]./255; % light blue
C16 = [44,123,182]./255; % dark blue

%% MET
figure;
hold on
errorbar(WMF_2021,Ra_2021,Ra_err_2021,'ok');
l3 = scatter(WMF_2021,Ra_2021,150,depth_2021,'filled','MarkerEdgeColor','k');
xlabel('% meteoric water'); ylabel('^{228}Ra (dpm 100L^{-1})'); 
% xlim([0 25]); ylim([0 25]);
tt = colorbar; set(get(tt,'ylabel'),'String','Depth (m)','FontSize',20); % drag from 150 to 50
good_titles(20);   

%% SIM
figure;
hold on
errorbar(SIM_2021,Ra_2021,Ra_err_2021,'ok');
l3 = scatter(SIM_2021,Ra_2021,150,depth_2021,'filled','MarkerEdgeColor','k');
xlabel('% sea ice melt'); ylabel('^{228}Ra (dpm 100L^{-1})'); 
% xlim([0 25]); ylim([0 25]);
tt = colorbar; set(get(tt,'ylabel'),'String','Depth (m)','FontSize',20); % drag from 150 to 50
good_titles(20);   

%% 6/13/22

load WMF_output_060922.mat;
% output = [station sample MW_avg' MW_std' SIM_avg' SIM_std' ATL_avg' ATL_std']; % in percent

depth = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','F2:F134');
salinity = [NaN; NaN; NaN; xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','H2:H134')];

figure;
% scatter(output(:,3), output(:,5), 80, depth,'filled','MarkerEdgeColor','k');
scatter(output(:,3), output(:,5), 80, output(:,1),'filled','MarkerEdgeColor','k');
ylabel('% sea ice melt'); xlabel('% meteoric water'); 
% ylim([-11 10]);
% tt = colorbar; set(get(tt,'ylabel'),'String','Depth','FontSize',20); 
tt = colorbar; colormap('jet'); set(get(tt,'ylabel'),'String','Station','FontSize',20); % drag from 150 to 50
good_titles(20);   
%%
i = ~isnan(output(:,3));
[F0, G] = cfit(output(i,3), output(i,5),'exp1');

plot(F0,output(i,3), output(i,5));