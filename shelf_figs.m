%% figures for shelf data
% started 10/28/22
% data stored in shelf_compilation.xlsx in "data from other cruises" folder

load shelf_data.mat;
% 9 = Ra228
% 11 = Ra226
% 7 = depth

%% all data
figure;
hold on;
scatter(shelf(:,11),shelf(:,9),50,shelf(:,1),'filled','markeredgecolor','k');
colormap(parula(28));
tt = colorbar; caxis([1993 2021]);
xlabel('^{226}Ra'); ylabel('^{228}Ra');

%% all data, by shelf

L = find(shelf(:,16)==1 & shelf(:,7)<=60);
E = find(shelf(:,16)==5 & shelf(:,7)<=60);
C = find(shelf(:,16)==4 & shelf(:,7)<=60);
B = find(shelf(:,16)==3 & shelf(:,7)<=60);
K = find(shelf(:,16)==2 & shelf(:,7)<=60);

figure;
hold on;
l1 = scatter(shelf(L,11),shelf(L,9),50,shelf(L,1),'filled','o','markeredgecolor','k');
l2 = scatter(shelf(E,11),shelf(E,9),50,shelf(E,1),'filled','d','markeredgecolor','k');
l3 = scatter(shelf(C,11),shelf(C,9),50,shelf(C,1),'filled','>','markeredgecolor','k');
l4 = scatter(shelf(B,11),shelf(B,9),50,shelf(B,1),'filled','s','markeredgecolor','k');
l5 = scatter(shelf(K,11),shelf(K,9),50,shelf(K,1),'filled','v','markeredgecolor','k');


colormap(parula(28));
tt = colorbar; caxis([1993 2021]);
set(get(tt,'ylabel'),'String','Year','FontSize',16); 
xlabel('^{226}Ra'); ylabel('^{228}Ra');
ylim([0 45]);

legend([l1 l2 l3 l4 l5],{'Laptev' 'ESS' ' Chukchi' 'Barents' 'Kara'},'location','northwest');
good_titles(16);

%% all data, by shelf, depth shading

L = find(shelf(:,16)==1 & shelf(:,7)<=60);
E = find(shelf(:,16)==5 & shelf(:,7)<=60);
C = find(shelf(:,16)==4 & shelf(:,7)<=60);
B = find(shelf(:,16)==3 & shelf(:,7)<=60);
K = find(shelf(:,16)==2 & shelf(:,7)<=60);

figure;
hold on;
l1 = scatter(shelf(L,11),shelf(L,9),50,shelf(L,7),'filled','o','markeredgecolor','k');
l2 = scatter(shelf(E,11),shelf(E,9),50,shelf(E,7),'filled','d','markeredgecolor','k');
l3 = scatter(shelf(C,11),shelf(C,9),50,shelf(C,7),'filled','>','markeredgecolor','k');
l4 = scatter(shelf(B,11),shelf(B,9),50,shelf(B,7),'filled','s','markeredgecolor','k');
l5 = scatter(shelf(K,11),shelf(K,9),50,shelf(K,7),'filled','v','markeredgecolor','k');


tt = colorbar; caxis([0 60]);
set(get(tt,'ylabel'),'String','Depth (m)','FontSize',16); 
xlabel('^{226}Ra'); ylabel('^{228}Ra');
ylim([0 45]);

legend([l1 l2 l3 l4 l5],{'Laptev' 'ESS' ' Chukchi' 'Barents' 'Kara'},'location','northwest');
good_titles(16);

%% Laptev + ESS only

L = find(shelf(:,16)==1 & shelf(:,7)<=50);
E = find(shelf(:,16)==5& shelf(:,7)<=50);

figure;
hold on;
l1 = scatter(shelf(L,11),shelf(L,9),50,shelf(L,1),'filled','o','markeredgecolor','k');
l2 = scatter(shelf(E,11),shelf(E,9),50,shelf(E,1),'filled','d','markeredgecolor','k');

colormap(parula(28));
tt = colorbar; caxis([1993 2021]);
set(get(tt,'ylabel'),'String','Year','FontSize',16); 
xlabel('^{226}Ra (dpm/100L)'); ylabel('^{228}Ra (dpm/100L)');
ylim([0 45]);

legend([l1 l2],{'Laptev' 'ESS'},'location','northwest');
good_titles(16);

%% 2018 vs. 2021

N = find(shelf(:,1)==2018);
A = find(shelf(:,1)==2021 & shelf(:,7)<=60);
% A = find(shelf(:,1)==2021);

figure;
hold on;
l1 = scatter(shelf(N,11),shelf(N,9),50,shelf(N,7),'filled','o','markeredgecolor','k');
% l1 = scatter(shelf(N,11),shelf(N,9),50,'filled','o','markeredgecolor','k','markerfacecolor',rgb('Gainsboro'));
l2 = scatter(shelf(A,11),shelf(A,9),50,shelf(A,7),'filled','d','markeredgecolor','k');

% colormap(parula(28));
tt = colorbar; %caxis([1993 2021]);
set(get(tt,'ylabel'),'String','Depth (m)','FontSize',16); 
xlabel('^{226}Ra (dpm/100L)'); ylabel('^{228}Ra (dpm/100L)');
ylim([0 45]); xlim([6 18]);

legend([l1 l2],{'2018' '2021'},'location','northwest');
good_titles(16);