%% xy example script
% use the percent sign to write notes, MATLAB will ignore anything in green
% two percentage signs next to each other will start a new section

% This loads the data file. Make sure you put the data file in the same
% folder as your MATLAB scripts, otherwise you need to specify the longer
% path name (which I think we did in class with R , so you can also do it 
%that way if you prefer).
load AR21_Apr22.mat; 
% The data is formatted so that my Excel spreadsheet is saved as a matrix, 
% where each column corresponds to a different variable and each row 
% corresponds to a sample.
% The variable names are saved separately, because you can't put text into
% a matrix, so I use "AR21_Feb22_labels" to reference which column
% corresponds to which variables. 

% This converts the longitude to all negative numbers. this is necessary
% because the bathymetry file that I use for the Arctic has all negative
% values (idk why) so we just have to make sure it's consistent.
for ii=1:length(AR21_Feb22(:,5)) 
   if AR21_Feb22(ii,5)>0
       AR21_Feb22(ii,5) = AR21_Feb22(ii,5) - 360;
   elseif AR21_Feb22(ii,5) == AR21_Feb22(ii,5)
   end
end

% This converts any 0 values to NaN, which means "not a number". This stops
% MATLAB from plotting them/including them in averages. 
for ii=1:length(AR21_Feb22(:,10))
   if AR21_Feb22(ii,10)==0
       AR21_Feb22(ii,10) = NaN;
   elseif AR21_Feb22(ii,10) == AR21_Feb22(ii,10)
   end
end

for ii=1:length(AR21_Feb22(:,16))
   if AR21_Feb22(ii,16)==0
       AR21_Feb22(ii,16) = NaN;
   elseif AR21_Feb22(ii,16) == AR21_Feb22(ii,16)
   end
end

% the values in parentheses correspond to (row, column). If there is a : it
% means all rows (or all columns)
%% plot figure

% this tells MATLAB to find the data that correspond to the parameters I am
% setting below. Specifically, find the data that is shallower than 50 m
% (depth is in column 6), and between stations 34 and 63 (station is in
% column 1). You will probably need to change this or delete this for your
% plots, but I am keeping it here for reference. 
% You can add a percentage sign before this line of code to tell MATLAB to 
% ignore it (but then you can keep the text to reference later).
k = find(AR21_Feb22(:,6)<=50 & 34<AR21_Feb22(:,1) & AR21_Feb22(:,1)<63);

figure; % this says open a new figure
hold on;
scatter(AR21_Feb22(k,8),AR21_Feb22(k,10),80,'o','filled','MarkerFaceColor',[0.9856,0.7372,0.2537],'MarkerEdgeColor','k'); % this is telling it to plot radium-228 vs salinity. 
% Refer to the scatter help page to learn about the other terms. The 3 number code tells it what color to make the dots, but you can also use 'r' for red, 'b' for blue, etc.
xlabel('salinity'); ylabel('^{228}Ra (dpm/100L)'); ylim([0 30]); xlim([26 36]); % specifies y and y labels and axis ranges
good_titles(16); % this is a code my friend wrote to make the plots look prettier. 
% You can add the good_titles code into your matlab directory and then just
% use this line to make the font better. The number in parentheses tells it
% what size to make the font.

