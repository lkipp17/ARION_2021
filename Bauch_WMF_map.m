%% map of Bauch et al 2011 WMF (ARK XXII2)
% started 6/13/22

load('/Users/kipp/Dropbox/MATLAB/Bauch_WMF_3end.mat');
% output = [latitude longitude station depth MW_avg' MW_std' SIM_avg' SIM_std' ATL_avg' ATL_std']; % in percent

Lon = output(:,2);
Lat = output(:,1);
Depth = output(:,4);
MW = output(:,5);

for ii=1:length(Lon(:))
   if Lon(ii)>0
       Lon(ii) = Lon(ii) - 360;
   elseif Lon(ii) == Lon(ii)
   end
end

for ii=1:length(MW)
   if MW(ii)==0
       MW(ii) = NaN;
   elseif MW(ii) == MW(ii)
   end
end

map(68,84,108,194);

[x,y] = m_ll2xy(Lon,Lat);
l = find(Depth<10);

hold on;
scatter(x(l),y(l),100,MW(l),'o','filled','MarkerEdgeColor','k'); 

colormap('parula');
tt = colorbar;
caxis([0 25]); % drag from 30 to 15
set(get(tt,'ylabel'),'String','fMET (%)','FontSize',16); % ^{228}Ra (dpm 100L^{-1})
good_titles(16);