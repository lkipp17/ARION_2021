%% 3 component mixing model
% started 7/18/19
% copied from Newton_NP_WMFmethod

clear all; close all; clc;

% C is the design matrix, endmember values
    % salinity
    % d18O (permil)
    % mass conservation
% f is the fraction of each water mass for each sample
    % Atlantic
    % Meteoric
    % Sea ice melt
% y is the vector of salinity/d18O/1 for each sample

%% load data

% % GN01
% load('/Users/Lauren/Documents/MATLAB/Arctic GT/data organization for tpd paper/TPD_summary.mat'); % data for both cruises
% i = find(TPD_sum(:,1)==1 & TPD_sum(:,6)<=50 & TPD_sum(:,3)>84); % GN01, shallower than 500 m, north of 84
% cruise = [TPD_sum(i,1)];
% station = [TPD_sum(i,2)];
% pressure = [TPD_sum(i,5)];
% salt = [TPD_sum(i,8)]; 
% d18O = [TPD_sum(i,9)];


% % GN01 + GN04
% load('/Users/Lauren/Documents/MATLAB/Arctic GT/data organization for tpd paper/TPD_summary.mat'); % data for both cruises
% TPD_sum(1:970,1) = 1; TPD_sum(971:1399) = 4;
% i = find(TPD_sum(:,1)==1 & TPD_sum(:,6)<=50 & TPD_sum(:,3)>84); % GN01, shallower than 500 m, north of 84
% j = find(TPD_sum(:,1)==4 & TPD_sum(:,6)<=50 & TPD_sum(:,3)>84); % GN04, shallower than 500 m, north of 84
% cruise = [TPD_sum(i,1); TPD_sum(j,1)];
% station = [TPD_sum(i,2); TPD_sum(j,2)];
% pressure = [TPD_sum(i,5); TPD_sum(j,5)];
% salt = [TPD_sum(i,8); TPD_sum(j,8)]; 
% d18O = [TPD_sum(i,9); TPD_sum(j,9)];
% lat = [TPD_sum(i,3); TPD_sum(j,3)];
% lon = [TPD_sum(i,4); TPD_sum(j,4)];
% clear i j

% % ARKXXII2 (2007) from Bauch et al 2011
% load('/Users/Lauren/Documents/MATLAB/Arctic GT/Bauch_WMF_ARKXXII2.mat');
% i = find(latitude>84 & depth<=50); 
% salt = salinity(i);
% d18O = del18O(i);
% N = N(i);
% P = P(i);
% station = station(i);
% pressure = pressure(i);
% depth = depth(i);

% % NABOS 2018
% salt = [28.6152
% 27.626
% 27.5392
% 28.1097
% 27.7638
% 28.9433
% 28.8708
% 28.1907
% 28.6039
% 29.2945
% 29.5216
% 30.0903
% 30.487
% 30.1762
% 28.183
% 27.8254
% 28.0964
% 28.0844];
% 
% d18O = [-4.83
% -5.15
% -3.76
% -3.31
% -3.10
% -2.19
% -2.53
% -2.68
% -2.89
% -2.94
% -3.04
% -2.64
% -2.35
% -2.52
% -3.16
% -4.05
% -4.62
% -4.67];

% ARION 2021
% stn = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','A5:A134');
salt = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','H5:H134');
d18O = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','K5:K134');
ID = xlsread('/Users/kipp/Google Drive/Shared drives/ARION/ARION2021_master.xlsx','summary','B5:B134');


%% Newton et al 2013 equations
 for j = 1:length(salt)
    y = [salt(j); d18O(j); 1];    

    C = [34.92 0 4; 
        0.3 -19 d18O(j)+2.6; 
        1 1 1];

    f = (C^-1)*y
    fractions(j,:) = f';
 end
% Atl MW SIM
return
%% Bauch et al 2011 equations
 for j = 1:length(salt)
    y = [salt(j); d18O(j); 1];    

    C = [34.92 0 4; 
        0.3 -20 d18O(j)+2.6; 
        1 1 1];

    f = (C^-1)*y
    fractions(j,:) = f';
 end
% Atl MW SIM