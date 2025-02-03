%% Monte Carlo method for calculating WMF
% aquired 6/27/19 from Matt Alkire
% modified 6/9/22 to use with 2021 NABOS (copied from NO_WMFmethod script
% in NABOS 2018 folder)

clear all; close all; clc;


% salt = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','H5:H134');
% d18O = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','K5:K134');
% N = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','U5:U134');
% P = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','V5:V134');
% station = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','A5:A134');
% depth = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','F5:F134');
% sample = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','B5:B134');

% ARION 2021
load d18O_060922.mat;
load AR21_Apr22.mat;
salt = AR21_Feb22(:,8);
N = AR21_Feb22(:,18);
P = AR21_Feb22(:,19);
station = AR21_Feb22(:,1);
depth = AR21_Feb22(:,6);
sample = AR21_Feb22(:,2);

% % Bauch et al. 2011 ARKXXII2
% load('/Users/kipp/Dropbox/MATLAB/Bauch_WMF_ARKXXII2.mat');
% salt = salinity;
% d18O = del18O;

% % NABOS 2018, data from Channing (via Laura)
% load('/Users/kipp/Dropbox/MATLAB/NABOS_2018/NABOS_2018_bot.mat');
% N = NO2+NO3;
% P = PO4;

%% 3 endmembers
% Choose number of repetitions:
n = 1000;

% The salinity of meteoric water is set equal to zero:
Smw = 0;

% Vary endmember assignments:
Mw_d18O = [-22:1:-18]; r1 = randi(length(Mw_d18O),n,1);

Sim_salt = [2:1:8]; r2 = randi(length(Sim_salt),n,1);

Sim_d18O = [-2:0.2:0.3]; r3 = randi(length(Sim_d18O),n,1);

Aw_salt = [34.85:0.05:35]; r6 = randi(length(Aw_salt),n,1);

Aw_d18O = [0.25:0.05:0.35]; r7 = randi(length(Aw_d18O),n,1);

for i = 1:n
    
    % Randomly assign the endmember values:
    dmw = Mw_d18O(r1(i));
    Ssim = Sim_salt(r2(i)); dsim = Sim_d18O(r3(i)); 
    Saw = Aw_salt(r6(i)); daw = Aw_d18O(r7(i));
    
    % Calculate water type fractions:
    endmembers = [1 1 1; Ssim, Smw, Saw; dsim, dmw, daw];
    
    for j = 1:length(salt)
        
        b = [1; salt(j); d18O(j)];
        x = endmembers\b;
    
        fSIM(j) = x(1);
        fMW(j) = x(2);
        fAW(j) = x(3);
        
        clear x b
    end
    
    SIM(i,:) = fSIM*100; MW(i,:) = fMW*100; AW(i,:) = fAW*100;
    
    % Clear out variables for next iteration:
    clear dmw Ssim dsim Saw daw fSIM fMW fAW
    
end

% Calculate means & stdevs for each run:
MW_avg = nanmean(MW); MW_std = nanstd(MW); figure(1); bins = [0.1:0.1:1.2]; hist(MW_std,bins); clear bins
    xlabel('MW stdev'); title(['Median = ',num2str(nanmedian(MW_std))]); ylabel('Number of Observations')
SIM_avg = nanmean(SIM); SIM_std = nanstd(SIM); figure(2); bins = [0.1:0.1:1.2]; hist(SIM_std,bins); clear bins
    xlabel('SIM stdev'); title(['Median = ',num2str(nanmedian(SIM_std))]); ylabel('Number of Observations')
ATL_avg = nanmean(AW); ATL_std = nanstd(AW); figure(3); bins = [0.2:0.05:0.5]; hist(ATL_std,bins); clear bins
    xlabel('ATL stdev'); title(['Median = ',num2str(nanmedian(ATL_std))]); ylabel('Number of Observations')

output = [MW_avg' MW_std' SIM_avg' SIM_std' ATL_avg' ATL_std']; % in percent
% output = [latitude longitude station depth MW_avg' MW_std' SIM_avg' SIM_std' ATL_avg' ATL_std']; % in percent
% output = [station sample MW_avg' MW_std' SIM_avg' SIM_std' ATL_avg' ATL_std']; % in percent
% output_frac = [station sample MW_avg'./100 MW_std'./100 SIM_avg'./100 SIM_std'./100 ATL_avg'./100 ATL_std'./100]; % in fraction


%% 4 endmembers

% Choose number of repetitions:
n = 1000;

% The salinity of meteoric water is set equal to zero:
Smw = 0;

% Vary endmember assignments:
Mw_d18O = [-22:1:-18]; r1 = randi(length(Mw_d18O),n,1);

Sim_salt = [2:1:8]; r2 = randi(length(Sim_salt),n,1);

% Sim_d18O = [-2:0.2:0.3]; r3 = randi(length(Sim_d18O),n,1);
Sim_d18O = [0:0.2:1]; r3 = randi(length(Sim_d18O),n,1); % Alkire 2015

% Pw_salt = [32.3:0.2:32.9]; r4 = randi(length(Pw_salt),n,1);
Pw_salt = [32.0:0.1:32.7]; r4 = randi(length(Pw_salt),n,1); % Alkire 2015

% Pw_d18O = [-1.3:0.1:-0.9]; r5 = randi(length(Pw_d18O),n,1);
Pw_d18O = [-1.3:0.05:-0.8]; r5 = randi(length(Pw_d18O),n,1); % Alkire 2015

Aw_salt = [34.85:0.05:35]; r6 = randi(length(Aw_salt),n,1);

Aw_d18O = [0.25:0.01:0.35]; r7 = randi(length(Aw_d18O),n,1);

%% ANP calc
% copied from Newton_NP_WMFmethod script:
% P_atl = (N + 3)./17.5;
% P_pac = (N + 10.75)./13.93;

% FOR NEWTON NUMBERS: USE THESE EQUATIONS + MW d18O = -19
% P_atl = (N + 2)./17;
% P_pac = (N + 11)./14;
% Whitmore 2020 matches these

% Jones 1998:
% P_atl = (N + 3.072)./17.499;
% P_pac = (N + 10.549)./12.368;

% ANP = abs(P - P_atl)./(P_pac-P_atl);

% Monte carlo with all equations 
P_atl_d = [17:0.2:18.4]; r8 = randi(length(P_atl_d),n,1); % slope
P_atl_n = [2:0.2:3.6]; r9 = randi(length(P_atl_n),n,1); % int
P_pac_d = [12.3:0.5:15.3]; r10 = randi(length(P_pac_d),n,1); % slope
P_pac_n = [10.5:0.5:14.5]; r11 = randi(length(P_pac_n),n,1); % int

for i = 1:n
   for j = 1:length(N) 
       P_atl = (N(j) + P_atl_n(r9(i)))./P_atl_d(r8(i));
       P_pac = (N(j) + P_pac_n(r11(i)))./P_pac_d(r10(i));
       ANP(i,j) = abs(P(j) - P_atl)./(P_pac - P_atl);
   end 
end

% Single equation 
% for i = 1:n
%    for j = 1:length(N) 
%        P_atl = (N(j) + 2)./17;
%        P_pac = (N(j) + 11)./14;
%        anp(i,j) = abs(P(j) - P_atl)./(P_pac - P_atl);
%    end
% end

ANP_avg = nanmean(ANP);

% Mw_ANP = [0:0.05:0.2]; r12 = randi(length(Mw_ANP),n,1); % from Bauch 2011 (they give range of 0.1 +- 0.1)
% Sim_ANP = [0.25:0.05:0.45]; r13 = randi(length(Sim_ANP),n,1); % from Bauch 2011 (they give range of 0.4 +- 0.1)

%% do endmember calc- DO NOT USE, ALL FPAC = ANP
for i = 1:n
    
    % Randomly assign the endmember values:
    dmw = Mw_d18O(r1(i)); %ANPmw = Mw_ANP(r12(i));
    Ssim = Sim_salt(r2(i)); dsim = Sim_d18O(r3(i)); %ANPsim = Sim_ANP(r13(i));
    Saw = Aw_salt(r6(i)); daw = Aw_d18O(r7(i)); ANPaw = 0;
    Spw = Pw_salt(r4(i)); dpw = Pw_d18O(r5(i)); ANPpw = 1;
    
    
    % Calculate water type fractions:
    endmembers = [1 1 1 1; 
        Ssim, Smw, Saw, Spw; 
        dsim, dmw, daw, dpw; 
        ANPaw, ANPaw, ANPaw, ANPpw];
    
    for j = 1:length(salt)
        
        b = [1; salt(j); d18O(j); ANP_avg(j)];
        x = endmembers\b;
    
        fSIM(j) = x(1);
        fMW(j) = x(2);
        fAW(j) = x(3);
        fPW(j) = x(4);
        
        clear x b
    end
    
    SIM(i,:) = fSIM*100; MW(i,:) = fMW*100; AW(i,:) = fAW*100; PW(i,:) = fPW*100;
    
%     Clear out variables for next iteration:
    clear dmw ANPmw Ssim dsim ANPsim Saw daw ANPaw Spw dpw ANPpw fSIM fMW fAW fPW
    
end

% Calculate means & stdevs for each run:
MW_avg = nanmean(MW); MW_std = nanstd(MW); figure(1); bins = [0.1:0.1:2]; hist(MW_std,bins); clear bins
    xlabel('MW stdev'); title(['Median = ',num2str(nanmedian(MW_std))]); ylabel('Number of Observations')
SIM_avg = nanmean(SIM); SIM_std = nanstd(SIM); figure(2); bins = [0.1:0.1:2]; hist(SIM_std,bins); clear bins
    xlabel('SIM stdev'); title(['Median = ',num2str(nanmedian(SIM_std))]); ylabel('Number of Observations')
ATL_avg = nanmean(AW); ATL_std = nanstd(AW); figure(3); bins = [0.2:0.1:1.5]; hist(ATL_std,bins); clear bins
    xlabel('ATL stdev'); title(['Median = ',num2str(nanmedian(ATL_std))]); ylabel('Number of Observations')
PW_avg = nanmean(PW); PW_std = nanstd(PW); figure(4); bins = [0.2:0.1:1.5]; hist(PW_std,bins); clear bins
    xlabel('PW stdev'); title(['Median = ',num2str(nanmedian(PW_std))]); ylabel('Number of Observations')

% ANP_std = nanstd(ANP); figure(6); bins = [0.1:0.1:1.5]; hist(ANP_std,bins); clear bins
%     xlabel('ANP stdev'); title(['Median = ',num2str(nanmedian(ANP_std))]); ylabel('Number of Observations')

output = [MW_avg' MW_std' SIM_avg' SIM_std' ATL_avg' ATL_std' PW_avg' PW_std']; % in percent
% output = [station sample MW_avg' MW_std' SIM_avg' SIM_std' ATL_avg' ATL_std' PW_avg' PW_std']; % in percent
% output_frac = [station sample MW_avg'./100 MW_std'./100 SIM_avg'./100 SIM_std'./100 ATL_avg'./100 ATL_std'./100 PW_avg'./100 PW_std'./100]; % in fraction

%% Equations 5 - 13 in Alkire et al 2015 (calculate SW % first, then separate Pac and Atl)
% method from Yamamoto-Kawai et al (2008)
% Monte carlo with N:P relationship 

P_atl_d = [17:0.2:18.4]; r8 = randi(length(P_atl_d),n,1); % slope
P_atl_n = [2:0.2:3.6]; r9 = randi(length(P_atl_n),n,1); % int
P_pac_d = [12.3:0.5:15.3]; r10 = randi(length(P_pac_d),n,1); % slope
P_pac_n = [10.5:0.5:14.5]; r11 = randi(length(P_pac_n),n,1); % int

for i = 1:n
    
   for j = 1:length(N) 
       P_atl = (N(j) + P_atl_n(r9(i)))./P_atl_d(r8(i));
       P_pac = (N(j) + P_pac_n(r11(i)))./P_pac_d(r10(i));
       r_Pac(i,j) = abs(P(j) - P_atl)./(P_pac - P_atl);
%        f_Pac(j,:) = (P_atl - P(j))./(P_atl - P_pac);
%        r_Atl(i,j) = 1-r_Pac(j);
   end
end
R_Pac = nanmean(r_Pac);

% r_std = nanstd(r_Pac); figure(6); bins = [0.01:0.01:1]; hist(r_std,bins); clear bins
%     xlabel('r Pac stdev'); title(['Median = ',num2str(nanmedian(r_std))]); ylabel('Number of Observations')
% note figure is not in %, value stdev is smaller because it's deviation between small numbers(?)
%%
for i = 1:n
    
    % Randomly assign the endmember values:
    Smw = 0; dmw = Mw_d18O(r1(i)); 
    Ssim = Sim_salt(r2(i)); dsim = Sim_d18O(r3(i)); 
    Saw = Aw_salt(r6(i)); daw = Aw_d18O(r7(i)); 
    Spw = Pw_salt(r4(i)); dpw = Pw_d18O(r5(i)); 

    for j = 1:length(salt)
        
%         Sse = Spw.*r_Pac(j) + Saw.*r_Atl(j); dse = dpw.*r_Pac(j) + daw.*r_Atl(j);
        Sse = Spw.*R_Pac(j) + Saw.*(1-R_Pac(j)); dse = dpw.*R_Pac(j) + daw.*(1-R_Pac(j));
        
    % Calculate water type fractions:
    endmembers = [1 1 1; 
        Ssim, Smw, Sse; 
        dsim, dmw, dse];


        b = [1; salt(j); d18O(j);];
        x = endmembers\b;
    
        fSIM(j) = x(1);
        fMW(j) = x(2);
        fSE(j) = x(3);
        
        clear x b
    end

    SIM(i,:) = fSIM*100; MW(i,:) = fMW*100; SE(i,:) = fSE*100; 
    fPAC = fSE.*R_Pac; fATL = fSE.*(1-R_Pac);
    PW(i,:) = fPAC*100; AW(i,:) = fATL*100;
    
%     Clear out variables for next iteration:
    clear dmw  Ssim dsim  Saw daw  Spw dpw  fSIM fMW fAW fPW dse Sse
    
end

% Calculate means & stdevs for each run:
MW_avg = nanmean(MW); MW_std = nanstd(MW); figure(1); bins = [0.1:0.1:2]; hist(MW_std,bins); clear bins
    xlabel('MW stdev'); title(['Median = ',num2str(nanmedian(MW_std))]); ylabel('Number of Observations')
SIM_avg = nanmean(SIM); SIM_std = nanstd(SIM); figure(2); bins = [0.1:0.1:2]; hist(SIM_std,bins); clear bins
    xlabel('SIM stdev'); title(['Median = ',num2str(nanmedian(SIM_std))]); ylabel('Number of Observations')
SE_avg = nanmean(SE); SE_std = nanstd(SE); figure(5); bins = [0.2:0.1:1.5]; hist(SE_std,bins); clear bins
    xlabel('SE stdev'); title(['Median = ',num2str(nanmedian(SE_std))]); ylabel('Number of Observations')
ATL_avg = nanmean(AW); ATL_std = nanstd(AW); figure(3); bins = [0.2:0.1:1.5]; hist(ATL_std,bins); clear bins
    xlabel('ATL stdev'); title(['Median = ',num2str(nanmedian(ATL_std))]); ylabel('Number of Observations')
PW_avg = nanmean(PW); PW_std = nanstd(PW); figure(4); bins = [0.2:0.1:1.5]; hist(PW_std,bins); clear bins
    xlabel('PW stdev'); title(['Median = ',num2str(nanmedian(PW_std))]); ylabel('Number of Observations')    
    
output = [MW_avg' MW_std' SIM_avg' SIM_std' ATL_avg' ATL_std' PW_avg' PW_std']; % in percent
