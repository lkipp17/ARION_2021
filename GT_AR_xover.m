%% GT-ARION crossover
% ARION stns 72,64
% GT stn 14, 19

addpath(genpath('/Users/Lauren/Documents/MATLAB/m_map'));

load AR21_Apr22.mat; 
GT_stn = xlsread('/Users/Lauren/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','F2:F310');
GT_lat = xlsread('/Users/Lauren/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','G2:G310');
GT_lon = xlsread('/Users/Lauren/Dropbox/Arctic GEOTRACES master -downloaded from Google Drive Sept 2020.xlsx','summary','H2:H310');

GT_stn = [-2; -1; GT_stn]; % dutch harbor and rinse are not read in; sub -2 and -1
for ii=1:length(GT_lon)
   if GT_lon(ii)>0
       GT_lon(ii) = GT_lon(ii) - 360;
   elseif GT_lon(ii) == GT_lon(ii)
   end
end

for ii=1:length(AR21_Feb22(:,5))
   if AR21_Feb22(ii,5)>0
       AR21_Feb22(ii,5) = AR21_Feb22(ii,5) - 360;
   elseif AR21_Feb22(ii,5) == AR21_Feb22(ii,5)
   end
end

ai_1  = find(AR21_Feb22(:,1)==72);
ai_2  = find(AR21_Feb22(:,1)==64);
ai = [ai_1; ai_2];
gi_1  = find(GT_stn==14);
gi_2  = find(GT_stn==19);
gi = [gi_1; gi_2];

%% map
map(65,84,160,210);

[Ax,Ay] = m_ll2xy(AR21_Feb22(ai,5),AR21_Feb22(ai,4));
[GTx, GTy] = m_ll2xy(GT_lon(gi), GT_lat(gi));
hold on;
l1 = scatter(Ax,Ay,100,'v','filled','MarkerEdgeColor','k');
l2 = scatter(GTx,GTy,100,'^','filled','MarkerEdgeColor','k');

% stations = num2str(AR21_Feb22(:,1));
text(Ax(1)+0.0015,Ay(1),{'72'},'fontsize',20);
text(Ax(7)+0.0015,Ay(7),{'64'},'fontsize',20);
text(GTx(1)+0.0015,GTy(1),{'14'},'fontsize',20);
text(GTx(19)+0.0015,GTy(19),{'19'},'fontsize',20);

legend([l1 l2], {'ARION 2021' 'GEOTRACES 2015'}, 'location','southwest','fontsize',16);

