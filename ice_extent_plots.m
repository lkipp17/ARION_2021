%% sea ice extent in ESS & Laptev
% started 10/28/22

addpath(genpath('/Users/Lauren/Documents/MATLAB/rgb'));
addpath(genpath('/Users/kipp/Dropbox/MATLAB/rgb'));

% data downloaded from https://nsidc.org/arcticseaicenews/sea-ice-tools/ (Daily Sea Ice Extent by Region)
load ice_extent.mat; % first row is year

t1 = datetime(1980,1,1);
t2 = datetime(1980,12,31);
t = t1:caldays(1):t2;

both = ESS + Laptev;
both(1,:) = ESS(1,:);

%% 5-year average
a_07 = mean(both(2:367,25:29),2);
a_11 = mean(both(2:367,29:33),2);
a_15 = mean(both(2:367,33:37),2);
a_18 = mean(both(2:367,36:40),2);
a_21 = mean(both(2:367,39:43),2);

%% plot - both shelves
figure;
hold on;
l1 = plot(t,a_07,'Color',rgb('Plum'),'LineWidth',2);
l2 = plot(t,a_11,'Color',rgb('MediumOrchid'),'LineWidth',2);
l3 = plot(t,a_15,'Color',rgb('DarkOrchid'),'LineWidth',2);
l4 = plot(t,a_18,'Color',rgb('Indigo'),'LineWidth',2);
l5 = plot(t,a_21,'Color',rgb('Black'),'LineWidth',2);

xlabel('Month'); ylabel('Sea ice extent (km^{2})');
legend([l1 l2 l3 l4 l5],{'2003-2007' '2007-2011' '2011-2015' '2014-2018' '2017-2021'},'location','southwest')'
good_titles(16);

%% plot
figure;
hold on;
% l1 = plot(t,a_07,'Color',rgb('PowderBlue'),'LineWidth',2);
% l2 = plot(t,a_11,'Color',rgb('LightSkyBlue'),'LineWidth',2);
% l3 = plot(t,a_15,'Color',rgb('DeepSkyBlue'),'LineWidth',2);
% l4 = plot(t,a_18,'Color',rgb('MediumBlue'),'LineWidth',2);
% l5 = plot(t,a_21,'Color',rgb('MidnightBlue'),'LineWidth',2);

% l1 = plot(t,a_07,'Color',rgb('LightBlue'),'LineWidth',2);
% l2 = plot(t,a_11,'Color',rgb('DeepSkyBlue'),'LineWidth',2);
% l3 = plot(t,a_15,'Color',rgb('Blue'),'LineWidth',2);
% l4 = plot(t,a_18,'Color',rgb('BlueViolet'),'LineWidth',2);
% l5 = plot(t,a_21,'Color',rgb('Indigo'),'LineWidth',2);

l1 = plot(t,a_07,'Color',rgb('Thistle'),'LineWidth',2);
l2 = plot(t,a_11,'Color',rgb('Plum'),'LineWidth',2);
l3 = plot(t,a_15,'Color',rgb('MediumOrchid'),'LineWidth',2);
l4 = plot(t,a_18,'Color',rgb('DarkOrchid'),'LineWidth',2);
l5 = plot(t,a_21,'Color',rgb('Indigo'),'LineWidth',2);

xlabel('Month'); ylabel('Sea ice extent (km^{2})');
legend([l1 l2 l3 l4 l5],{'2003-2007' '2007-2011' '2011-2015' '2014-2018' '2017-2021'},'location','southwest')'
good_titles(16);

%% 5-year average for ESS only
E_07 = mean(ESS(2:367,25:29),2);
E_11 = mean(ESS(2:367,29:33),2);
E_15 = mean(ESS(2:367,33:37),2);
E_18 = mean(ESS(2:367,36:40),2);
E_21 = mean(ESS(2:367,39:43),2);

%% plot - ESS
figure;
hold on;
l1 = plot(t,E_07,'Color',rgb('Thistle'),'LineWidth',2);
l2 = plot(t,E_11,'Color',rgb('Plum'),'LineWidth',2);
l3 = plot(t,E_15,'Color',rgb('MediumOrchid'),'LineWidth',2);
l4 = plot(t,E_18,'Color',rgb('DarkOrchid'),'LineWidth',2);
l5 = plot(t,E_21,'Color',rgb('Indigo'),'LineWidth',2);

xlabel('Month'); ylabel('Sea ice extent (km^{2})');
legend([l1 l2 l3 l4 l5],{'2003-2007' '2007-2011' '2011-2015' '2014-2018' '2017-2021'},'location','southwest')'
good_titles(16);

%% 5-year average for Laptev only
L_07 = mean(Laptev(2:367,25:29),2);
L_11 = mean(Laptev(2:367,29:33),2);
L_15 = mean(Laptev(2:367,33:37),2);
L_18 = mean(Laptev(2:367,36:40),2);
L_21 = mean(Laptev(2:367,39:43),2);

%% plot - Laptev
figure;
hold on;
l1 = plot(t,L_07,'Color',rgb('Thistle'),'LineWidth',2);
l2 = plot(t,L_11,'Color',rgb('Plum'),'LineWidth',2);
l3 = plot(t,L_15,'Color',rgb('MediumOrchid'),'LineWidth',2);
l4 = plot(t,L_18,'Color',rgb('DarkOrchid'),'LineWidth',2);
l5 = plot(t,L_21,'Color',rgb('Indigo'),'LineWidth',2);

xlabel('Month'); ylabel('Sea ice extent (km^{2})');
legend([l1 l2 l3 l4 l5],{'2003-2007' '2007-2011' '2011-2015' '2014-2018' '2017-2021'},'location','southwest')'
good_titles(16);