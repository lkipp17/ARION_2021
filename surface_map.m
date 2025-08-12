%% ARION/NABOS 2021 map for OSM2022
% started 2/2/22
% updated 4/21/23 with finalized ADC radium, separated WMF out into a separate script (WMF_map)

clear all; close all; clc;
addpath(genpath('/Users/Lauren/Documents/MATLAB/m_map'));
% load AR21_Aug22.mat;
load ADC_radium.mat;

for ii=1:length(ADC_radium(:,5))
   if ADC_radium(ii,5)>0
       ADC_radium(ii,5) = ADC_radium(ii,5) - 360;
   elseif ADC_radium(ii,5) == ADC_radium(ii,5)
   end
end

N18 = load('NABOS_data_041719.mat');
N18_Ra228 = N18.Ra228;
N18_Ra226 = N18.Ra226;
N18_RAR = N18.RAR;
N18_lat = N18.NABOS_lat;
N18_lon = N18.NABOS_lon;

for ii=1:length(N18_lon)
   if N18_lon(ii)>0
       N18_lon(ii) = N18_lon(ii) - 360;
   elseif N18_lon(ii) == N18_lon(ii)
   end
end
%% Ra-228

for ii=1:length(ADC_radium(:,10))
   if ADC_radium(ii,10)==0
       ADC_radium(ii,10) = NaN;
   elseif ADC_radium(ii,10) == ADC_radium(ii,10)
   end
end

map(73,84,115,194);

[x,y] = m_ll2xy(ADC_radium(:,5),ADC_radium(:,4));
l = find(ADC_radium(:,6)==2);
[Nx,Ny] = m_ll2xy(N18_lon,N18_lat);

hold on;
% l2 = scatter(Nx,Ny,200,N18_Ra228,'^','filled','MarkerEdgeColor','k');
l1 = scatter(x(l),y(l),200,ADC_radium(l,11),'o','filled','MarkerEdgeColor','k'); %Ra228
% l4 = scatter(GTx,GTy,100,Ra228_bar,'v','filled','markeredgecolor','k');
% l5 = scatter(PSx,PSy,120,PS94_surf(:,15)./10,'s','filled','markeredgecolor','k');
% l1 = scatter(x(c),y(c),100,Chen_data(c,7),'o','filled','MarkerEdgeColor','k');
% l2 = scatter(x(n),y(n),100,Chen_data(n,7),'^','filled','MarkerEdgeColor','k');

% colormap(cmocean('matter'));
colormap('parula');
tt = colorbar;
% caxis([0 10]);
caxis([0 30]); % drag from 20 to 15, 0 to 2, 10 to 8
set(get(tt,'ylabel'),'String','^{228}Ra (dpm 100L^{-1})','FontSize',20); % ^{228}Ra (dpm 100L^{-1})
% legend([l1 l2], {'Sept 2021' 'Sept 2018'}, 'location','southwest','fontsize',16);

% legend([l1 l2 l3], {'Arc 2018' 'NABOS 2018' 'LV77 2016'}, 'location','northeast','fontsize',16);
% legend([l1 l2 l3 l4 l5], {'Arc Sep 2018' 'NABOS Sep 2018' 'LV77 Oct 2016' 'GN01 Aug-Oct 2015' 'GN04 Aug-Oct 2015'}, 'location','southwest','fontsize',16);
good_titles(16);

%% Ra-228/Ra-226

for ii=1:length(ADC_radium(:,15))
   if ADC_radium(ii,15)==0
       ADC_radium(ii,15) = NaN;
   elseif ADC_radium(ii,15) == ADC_radium(ii,15)
   end
end

map(73,84,115,194);

[x,y] = m_ll2xy(ADC_radium(:,5),ADC_radium(:,4));
l = find(ADC_radium(:,6)==2);

hold on;
l2 = scatter(Nx,Ny,200,N18_RAR,'^','filled','MarkerEdgeColor','k');
l1 = scatter(x(l),y(l),200,ADC_radium(l,15),'o','filled','MarkerEdgeColor','k'); %RAR

% colormap(cmocean('matter'));
colormap('parula');
tt = colorbar;
caxis([0 2.5]); % 2.5 to 2.3, 1 to 0.7, 0 to 0.2
set(get(tt,'ylabel'),'String','^{228}Ra/^{226}Ra','FontSize',16); 
% tt.Ticks = [0 0.5 1 1.5 2];
good_titles(16);

%% Ra-226

for ii=1:length(ADC_radium(:,13))
   if ADC_radium(ii,12)==0
       ADC_radium(ii,12) = NaN;
   elseif ADC_radium(ii,12) == ADC_radium(ii,13)
   end
end

map(73,84,115,194);

[x,y] = m_ll2xy(ADC_radium(:,5),ADC_radium(:,4));
l = find(ADC_radium(:,6)==2);

hold on;
l2 = scatter(Nx,Ny,200,N18_Ra226,'^','filled','MarkerEdgeColor','k');
l1 = scatter(x(l),y(l),200,ADC_radium(l,13),'o','filled','MarkerEdgeColor','k'); %Ra-226

% colormap(cmocean('matter'));
colormap('parula');
tt = colorbar;
% caxis([5 8]); 
caxis([0 16]); 
set(get(tt,'ylabel'),'String','^{226}Ra (dpm 100L^{-1})','FontSize',16);
tt.Ticks = [0 4 8 12 16];
good_titles(16);
return

%% Th-228/Ra-228

for ii=1:length(ADC_radium(:,17))
   if ADC_radium(ii,17)==0
       ADC_radium(ii,17) = NaN;
   elseif ADC_radium(ii,16) == ADC_radium(ii,17)
   end
end

map(73,84,115,194);

[x,y] = m_ll2xy(ADC_radium(:,5),ADC_radium(:,4));
l = find(ADC_radium(:,6)==2);

hold on;
l1 = scatter(x(l),y(l),100,ADC_radium(l,17),'o','filled','MarkerEdgeColor','k'); %RAR

% colormap(cmocean('matter'));
colormap('parula');
tt = colorbar;
caxis([0 0.5]); 
set(get(tt,'ylabel'),'String','^{228}Th/^{228}Ra','FontSize',16); 
good_titles(16);


%% station ID

map(73,84,115,194);

[x,y] = m_ll2xy(ADC_radium(:,5),ADC_radium(:,4));
l = find(ADC_radium(:,6)==2);

hold on;
scatter(x(l),y(l),100,'o','filled','MarkerEdgeColor','k');
% scatter(x(l),y(l),100,ADC_radium(l,1),'o','filled','MarkerEdgeColor','k'); 
% colormap('jet'); caxis([0 102]);
% tt = colorbar; set(get(tt,'ylabel'),'String','Station','FontSize',16);
% stations = num2str(ADC_radium(:,1));
% text(x+0.0015,y,stations,'fontsize',10);

%% Temperature 
% 
% load AR21_Aug22.mat;
% for ii=1:length(AR21(:,5))
%    if AR21(ii,5)>0
%        AR21(ii,5) = AR21(ii,5) - 360;
%    elseif AR21(ii,5) == AR21(ii,5)
%    end
% end
% 
% map(73,84,115,194);
% 
% [x,y] = m_ll2xy(AR21(:,5),AR21(:,4));
% l = find(AR21(:,6)==2);
% 
% hold on;
% l1 = scatter(x(l),y(l),100,AR21(l,9),'o','filled','MarkerEdgeColor','k'); %RAR
% 
% colormap('parula');
% tt = colorbar;
% caxis([-2 2]); 
% set(get(tt,'ylabel'),'String','Temperature','FontSize',16); 
% good_titles(16);
% 
% %% Salinity 
% 
% map(73,84,115,194);
% [x,y] = m_ll2xy(AR21(:,5),AR21(:,4));
% l = find(AR21(:,6)==2);
% 
% hold on;
% l1 = scatter(x(l),y(l),100,AR21(l,8),'o','filled','MarkerEdgeColor','k'); %RAR
% 
% colormap('parula');
% tt = colorbar;
% caxis([26 34]); 
% set(get(tt,'ylabel'),'String','Salinity','FontSize',16); 
% good_titles(16);
% 
% 
% %% Nitrate - not finalized ADC data
% 
% map(73,84,115,194);
% 
% [x,y] = m_ll2xy(AR21(:,5),AR21(:,4));
% l = find(AR21(:,6)==2);
% 
% hold on;
% l1 = scatter(x(l),y(l),100,AR21(l,18),'o','filled','MarkerEdgeColor','k'); %RAR
% 
% colormap('parula');
% tt = colorbar;
% caxis([0 1.5]); 
% set(get(tt,'ylabel'),'String','Nitrate + Nitrite','FontSize',16); 
% good_titles(16);
% 
% %% Phosphate - not finalized ADC data
% 
% map(73,84,115,194);
% 
% [x,y] = m_ll2xy(AR21(:,5),AR21(:,4));
% l = find(AR21(:,6)==2);
% 
% hold on;
% l1 = scatter(x(l),y(l),100,AR21(l,19),'o','filled','MarkerEdgeColor','k'); %RAR
% 
% colormap('parula');
% tt = colorbar;
% caxis([0 1]); 
% set(get(tt,'ylabel'),'String','Phosphate','FontSize',16); 
% good_titles(16);
