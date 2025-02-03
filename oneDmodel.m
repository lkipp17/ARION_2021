%% temp & sal from ESS transect
% started 6/1/23

load ADC_nuts.mat;
Stations = unique(ADC_nuts(:,3));
Stations = [1:102];
for i = 1:length(Stations);
    tmpind = find(ADC_nuts(:,3)==Stations(i));
        StationInd(i,1) = Stations(i);
        StationInd(i,2) = tmpind(1);
        StationInd(i,3) = tmpind(end);
end
clear tmpind i;


dist = [511.7056
  485.6447
  453.6076
  420.2915
  391.1719
  358.0428
  326.1362
  294.1407
  260.4559
  228.4107
  193.5252
  165.4932
  134.5216
   99.6493
   68.2384
   34.5651
         0];
% from ll_dist_calc code, stations 64-80, distance from station 80 in km
dist = dist.*1000; % convert to m

for i = 64:80;
    idepth_CTD = ADC_nuts(StationInd(i,2):StationInd(i,3),9);
    iT = ADC_nuts(StationInd(i,2):StationInd(i,3),11);
    iS = ADC_nuts(StationInd(i,2):StationInd(i,3),13);
    idist = dist(i-63);
 
    Temperature(StationInd(i,2):StationInd(i,3)) = iT; 
    Salinity(StationInd(i,2):StationInd(i,3)) = iS;
    Depth(StationInd(i,2):StationInd(i,3)) = idepth_CTD;
    Station(StationInd(i,2):StationInd(i,3)) = StationInd(i,1);
    Distance(StationInd(i,2):StationInd(i,3)) = idist;
    clear idepth_CTD iT iS idist
end

sum = [Station(1556:2035)' Distance(1556:2035)' Depth(1556:2035)' Temperature(1556:2035)' Salinity(1556:2035)'];

%% find data between 200-250

% k = find(sum(:,3) <= 255 & 210 <= sum(:,3));
% figure; hold on;
% scatter(sum(k,2),sum(k,4),100,sum(k,3));
% colorbar;
% xlabel('Temperature'); ylabel('Dist. from stn 80');
% 
% figure; hold on;
% scatter(sum(k,2),sum(k,5),100,sum(k,3));
% colorbar;
% xlabel('Salinity'); ylabel('Dist. from stn 80');

%% find data at 250 m

k = find(sum(:,3) <= 255 & 245 <= sum(:,3));
figure; hold on;
scatter(sum(k,2),sum(k,4),100,sum(k,3));
colorbar;
ylabel('Temperature'); xlabel('Dist. from stn 80 (m)');

figure; hold on;
scatter(sum(k,2),sum(k,5),100,sum(k,3));
colorbar;
ylabel('Salinity'); xlabel('Dist. from stn 80 (m)');

%% find z*

S = sum(k,5);
S(15) = mean(S(15:21)); S(16:21) = [];
S(1) = mean(S(1:7)); S(2:7) = [];
T = sum(k,4);
T(15) = mean(T(15:21)); T(16:21) = [];
T(1) = mean(T(1:7)); T(2:7) = [];
Z = sum(k,2);
Z(16:21) = []; Z(2:7) = []; 
% Z = Z - [68238.4000000000]; % subtract distance to stn 78 to make this the new starting station

% S = S(2:15); T = T(2:15); Z = Z(2:15);

% make function for T plot
C0= T(end);
Cm= T(1);
Zm= max(Z);
func1= @(x,a) C0+(Cm-C0).*(exp(x./a)-1)./(exp(Zm./a)-1);
Tguess=[5000]; 
[f,a,kyg,inter,corp,covp,conr,stdresid,ci,r2]=nlleasqr(Z,T,Tguess,func1);
ZstarT=a;

% errors
Tstdev=sqrt(diag(covp)); % standard deviation is the square root of the variance. the variance is along the diagonal of the covp matrix
% confidence interval of 95% means within 2 stdev

figure(1);
subplot(2,1,1); % temperature
plot(Z,T,'o')
hold on
plot(Z,f,'-')
ylabel('Temperature (deg C)'); xlabel('z (m)'); 
hold on

% make function for S plot
C0= S(end);
Cm= S(1);
Zm= max(Z);
func2= @(x,a) C0+(Cm-C0)*((exp(x/a)-1)/(exp(Zm/a)-1));
Sguess=[5000]; 
[f,a,kyg,inter,corp,covp,conr,stdresid,ci,r2]=nlleasqr(Z,S,Sguess,func2);
ZstarS=a;

% errors
Sstdev=sqrt(diag(covp)); % standard deviation is the square root of the variance. the variance is along the diagonal of the covp matrix
% confidence interval of 95% means within 2 stdev

figure(1);
subplot(2,1,2); % salinity
plot(Z,S,'o')
hold on
plot(Z,f,'-')
ylabel('Salinity'); xlabel('z (m)'); 

% average results of S and T calculations
Zstar=(ZstarS+ZstarT)/2
fprintf('The displayed Zstar is the average of the temperature Zstar and the\n')
fprintf('salinity Zstar.\n\n')
Zstdev=sqrt(Sstdev.^2+Tstdev.^2)/2;
% find extremes of Zstar
Zstar1= Zstar+Zstdev; 
Zstar2= Zstar-Zstdev; 

%%
a = 50000;
x = Z;
S_hat = C0+(Cm-C0)*((exp(x/a)-1)/(exp(Zm/a)-1));
plot(Z,S_hat,'--');

%% add in radioactive conservative tracer: Ra-228

% station  distance  depth  Ra-228
Ra_model_data = [64   511.7056    250 1.532327299
                 72   260.4559    250 2.33754483
                 79   34.5651     240 4.392621712
                 80   0           211 5.491455088];
    
depth = Ra_model_data(:,2);%.*1000; % depth = distance

% solve for Lstar=lambda/w
% set up function based on eqn. 13.18
global ZSTAR;
ZSTAR=Zstar;
L=log(2)/(5.75); % lambda in years-1
l = log(2)/(5.75*365*24*60);
% DEPTH = -1*depth+max(depth);
DEPTH = depth;
Ra = ((Ra_model_data(:,4)-1)./l).*10;
Raguess=1e5; 

% C0=Ra(end);
% Cm=Ra(1);
% Zm=max(DEPTH); % the depths of this depth vector correspond to those chosen in the Z vector that goes w/ T,S,O
% JL=0;
% A=sqrt(1+(4*Lstar*Zstar));

[f,a,kyg,inter,corp,covp,conr,stdresid,ci,r2]=nlleasqr(DEPTH,Ra,Raguess,'Kipp_funcRa');
Lstar=a
Lstdev=sqrt(diag(covp));

% figure(5);
% plot(Ra,DEPTH,'o')
% hold on
% plot(f,DEPTH,'-')
% xlabel('14C/R (umol/kg)'); ylabel('z (m)');
DEPTH2 = 0:1:max(depth);
figure(5);
plot(depth,Ra,'o')
hold on
plot(DEPTH,f,'-')
xlabel('Distance'); ylabel('Ra-228');

%% compute numbers

w_mean=L/Lstar; % w is in units of m/y
% w_up=L/a11;
% w_low=L/a22;
w_mean_cms = w_mean.*100/365/24/60/60

K_mean=w_mean*Zstar; % K is in units of m2/y
% K_up=w_up*Zstar;
% K_low=w_low*Zstar;
K_mean_m2s = K_mean/365/24/60/60 % in units of m2/s
