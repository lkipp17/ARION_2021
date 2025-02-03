%% Use GT 2015 data to determine ocean endmember for Ra-228 shelf flux calc
% (# to be subtracted to determine excess Ra-228)

load('/Users/kipp/Documents/MATLAB/TPD_summary.mat'); % data for both cruises
% load('/Users/Lauren/Documents/MATLAB/Arctic GT/data organization for tpd paper/TPD_summary.mat'); % data for both cruises
TPD_sum(1:970,1) = 1; TPD_sum(971:1399) = 4;
% i = find(TPD_sum(:,1)==1 & TPD_sum(:,6)<=60 & TPD_sum(:,6)>=40 & TPD_sum(:,3)<84 & TPD_sum(:,2)>9 & TPD_sum(:,2)<58); % GN01, north of 84, depth bounds
% i = find(TPD_sum(:,1)==1 & TPD_sum(:,148)<=1026.5 & TPD_sum(:,148)>=1024.5 & TPD_sum(:,3)<84 & TPD_sum(:,2)>9 & TPD_sum(:,2)<58); % GN01, north of 84, density bounds

% i = find(TPD_sum(:,1)==1 & TPD_sum(:,148)<=1026.3 & TPD_sum(:,148)>=1024.3 & TPD_sum(:,3)<84 & TPD_sum(:,2)>9 & TPD_sum(:,2)<58); % GN01, north of 84, density bounds
i = find(TPD_sum(:,1)==1 & TPD_sum(:,6)<=305 & TPD_sum(:,6)>=195 & TPD_sum(:,2)>25 & TPD_sum(:,2)<48); % GN01, btwn stations 26-46

k1 = 82;
Ra_2015 = [TPD_sum(i,k1)];
k2 = 83;
Ra_err_2015 = [TPD_sum(i,k2)];

avg_228 = nanmean(Ra_2015)
std_228 = nanstd(Ra_2015)
n = sum(~isnan(Ra_2015))

% N_2015 = [TPD_sum(i,10)];
% avg_N = nanmean(N_2015)
% std_N = nanstd(N_2015)
% n_N = sum(~isnan(N_2015))