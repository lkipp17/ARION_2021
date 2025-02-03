%% plot of Ra shelf activity vs. water res time 
% based on plot in Ra_sed_flux excel sheet
% started 4/19/23

month = [1:1:36];
Ra = [10.39
12.32
14.20
16.06
17.87
19.65
21.40
23.12
24.80
26.45
28.08
29.67
31.24
32.77
34.28
35.77
37.23
38.66
40.07
41.46
42.82
44.16
45.48
46.78
48.06
49.31
50.55
51.76
52.96
54.14
55.30
56.45
57.57
58.68
59.78
60.85]; % in dpm/100L

C1 = [0.2081,0.1663,0.5292];
C2 = [0.0244,0.4350,0.8755];
C3 = [0.1986,0.7214,0.6310];
C4 = [0.9856,0.7372,0.2537];
C5 = [0.9763,0.9831,0.0538];

%%
figure; hold on;
rectangle('Position',[0,15.39,37,(40.83-15.39)],'edgecolor','none','facecolor',[0.8 0.8 0.8]);
plot([0 37],[22.98 22.98],':k','linewidth',1.5);

bar(month,Ra,'facecolor',C2);
xlabel('Residence time (months)'); ylabel('Average ^{228}Ra (dpm 100L^{-1})'); 
xlim([0 36.5]);
good_titles(20); 

%% as line instead of bar plot
figure; hold on;
% rectangle('Position',[0,15.39,37,(40.83-15.39)],'edgecolor','none','facecolor',[0.8 0.8 0.8]);
rectangle('Position',[0,12.81,37,(40.83-12.81)],'edgecolor','none','facecolor',[0.8 0.8 0.8]);
% plot([0 37],[22.98 22.98],':k','linewidth',1.5);
plot([0 37],[21.29 21.29],':k','linewidth',1.5);

plot(month,Ra,'color',C2,'linewidth',2);
xlabel('Residence time (months)'); ylabel('Average ^{228}Ra (dpm 100L^{-1})'); 
xlim([0 36.5]); ylim([0 70]);
good_titles(20); 