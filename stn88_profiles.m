%% stn 88 depth profile
% started 4/27/23

clear all; close all; clc
addpath(genpath('/Users/Lauren/Dropbox/MATLAB/rgb'));
addpath(genpath('/Users/Lauren/Dropbox/MATLAB/subtightplot'));
addpath(genpath('/Users/Lauren/Dropbox/MATLAB/HatchedContours'));

iRa228 = [17.98
19.87
20.36
28.22
32.65];

iRa228_err = [0.42
0.72
0.76
1.00
0.98];

iRa226 = [10.27
11.18
12.11
15.85
17.99];

iRa226_err = [0.20
0.33
0.36
0.47
0.47];

iRa228_226 = [1.69
1.72
1.62
1.72
1.75];

iRa228_226_err = [0.03
0.05
0.05
0.05
0.04];


iDepth = [2
10
20
30
41];

C1 = [0.2081,0.1663,0.5292];
C2 = [0.0244,0.4350,0.8755];
C3 = [0.1986,0.7214,0.6310];
C4 = [0.9856,0.7372,0.2537];
C5 = [0.9763,0.9831,0.0538];
%% figure
hFig = figure;
set(gcf,'Color',[1,1,1]);

subplot(1,3,1);
herrorbar(iRa228,iDepth,iRa228_err,'k-o');
hold on
% xc = [0:10:40]; yc = [41.5.*ones(1,length(xc))];
% ax=axis;
%   ar=(ax(4)-ax(3))/(ax(2)-ax(1))./2;
% hl = hatchedline(xc,yc,'k',225*pi/180,1.125,-0.08);
% plot(iRa228,iDepth,'-o','MarkerEdgeColor','k','MarkerFaceColor',rgb('Teal'),'Color','k','MarkerSize',10);
plot(iRa228,iDepth,'-o','MarkerEdgeColor','k','MarkerFaceColor',C1,'Color','k','MarkerSize',10);

set(gca,'Ydir','reverse');
ylabel('Depth (m)','FontSize',12);
xlim([0 40]);
ylim([0 45]);
set(gca,'Ytick',[0 10 20 30 40 50]);
set(gca,'Xtick',[0 20 40]);
set(gca,'XAxisLocation','top','Color','none');
xlabel('^{228}Ra (dpm 100L^{-1})','FontSize',12,'Color','k');
good_titles(14);

subplot(1,3,2);
herrorbar(iRa226,iDepth,iRa226_err,'k-o');
hold on
% hl = hatchedline(xc,yc,'k',225*pi/180,1.125,-0.08);
% plot(iRa226,iDepth,'-o','MarkerEdgeColor','k','MarkerFaceColor',rgb('MediumTurquoise'),'Color','k','MarkerSize',10);
plot(iRa226,iDepth,'-o','MarkerEdgeColor','k','MarkerFaceColor',C2,'Color','k','MarkerSize',10);
set(gca,'Ydir','reverse');
xlim([0 20]);
ylim([0 45]);
set(gca,'Ytick',[0 10 20 30 40 50]);
set(gca,'Xtick',[0 10 20]);
set(gca,'XAxisLocation','top','Color','none');
xlabel('^{226}Ra (dpm 100L^{-1})','FontSize',12,'Color','k');
good_titles(14);

subplot(1,3,3);
herrorbar(iRa228_226,iDepth,iRa228_226_err,'k-o');
hold on
% hl = hatchedline(xc,yc,'k',225*pi/180,2,-0.08);
% plot(iRa228_226,iDepth,'-o','MarkerEdgeColor','k','MarkerFaceColor',rgb('PaleTurquoise'),'Color','k','MarkerSize',10);
plot(iRa228_226,iDepth,'-o','MarkerEdgeColor','k','MarkerFaceColor',C3,'Color','k','MarkerSize',10);
set(gca,'Ydir','reverse');
xlim([0 2.5]);
ylim([0 45]);
set(gca,'Ytick',[0 10 20 30 40 50]);
set(gca,'Xtick',[0 1 2 3]);
set(gca,'XAxisLocation','top','Color','none');
xlabel('^{228}Ra/^{226}Ra','FontSize',12,'Color','k');
good_titles(14);