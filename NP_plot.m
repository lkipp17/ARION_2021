%% N:P plot to compare lines to previous lit
% started 5/12/23

load matched_nuts.mat;
N = nutrients(:,1);
P = nutrients(:,2);
load salt.mat;
load ADC_radium.mat;
station = ADC_radium(:,2);
depth = ADC_radium(:,6);

%%
figure;
colormap('parula');
tt = colorbar;
xlabel('P (umol/kg)'); ylabel('N (umol/kg)');
good_titles(20);
ylim([0 20]); xlim([0 2.5]);

hold on;
x = ones*[0:0.01:2.5];
line1 = 14*x+-11; % Whitmore pac
plot(x,line1,'k-','linewidth',2);
line2 = 17*x+-2; % Whitmore atl
plot(x,line2,'k-','linewidth',2);

line1 = 15.314*x+-14.395; % Jones pac
plot(x,line1,'--','color',[0.5 0.5 0.5],'linewidth',2);
line2 = 18.349*x+-3.514; % Jones atl
plot(x,line2,'--','color',[0.5 0.5 0.5],'linewidth',2);


% scatter(P,N,60,salt,'filled');
scatter(P,N,60,depth,'filled');
set(get(tt,'ylabel'),'String','Depth','FontSize',20);


%% shelf only (78-89)
i = find(78<=station & station<=89);
figure;
colormap('parula');
tt = colorbar;
% caxis([0 25]); 
set(get(tt,'ylabel'),'String','Salinity','FontSize',20);
xlabel('P (umol/kg)'); ylabel('N (umol/kg)');
good_titles(20);
ylim([0 20]); xlim([0 2.5]);

hold on;
x = ones*[0:0.01:2.5];
line1 = 14*x+-11; % Whitmore pac
plot(x,line1,'k-','linewidth',2);
line2 = 17*x+-2; % Whitmore atl
plot(x,line2,'k-','linewidth',2);

line1 = 15.314*x+-14.395; % Jones pac
plot(x,line1,'--','color',[0.5 0.5 0.5],'linewidth',2);
line2 = 18.349*x+-3.514; % Jones atl
plot(x,line2,'--','color',[0.5 0.5 0.5],'linewidth',2);

scatter(P(i),N(i),60,salt(i),'filled');