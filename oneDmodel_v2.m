%% temp & sal from ESS transect
% started 6/1/23

% Ra_data = [1	81.9127833333333	125.9500833	173	1.29	0.53	7.20	0.35
% 7	80.23375	125.9215	209	1.40245708	0.353138693	8.60	0.20
% 13	78.5002	125.9689	244	1.784782162	0.455307836	8.49	0.26
% 64	78.4923833	-170.096683	370	1.532327299	0.394240656	9.55	0.27
% 72	76.90951667	-177.9094667	225	2.33754483	0.675550456	7.73	0.34
% 79	75.67676667	175.1353167	54	4.392621712	0.75754272	9.59	0.48
% 80	75.55196667	174.1041833	26	5.491455088	0.549649165	8.13	0.31
% 90	79.9344	142.2475	29	2.672436854	0.612522527	9.19	0.32
% 98	81.73071667	136.6018833	114	1.662508285	0.287932921	8.43	0.19];

Ra_data = [64	78.4923833	-170.096683	370	1.532327299	0.394240656	9.55	0.27
13	78.5002	125.9689	244	1.784782162	0.455307836	8.49	0.26
72	76.90951667	-177.9094667	225	2.33754483	0.675550456	7.73	0.34
7	80.23375	125.9215	209	1.40245708	0.353138693	8.60	0.20
1	81.91278333	125.9500833	173	1.29	0.53	7.20	0.35
98	81.73071667	136.6018833	114	1.662508285	0.287932921	8.43	0.19
79	75.67676667	175.1353167	54	4.392621712	0.75754272	9.59	0.48
90	79.9344	142.2475	29	2.672436854	0.612522527	9.19	0.32
80	75.55196667	174.1041833	26	5.491455088	0.549649165	8.13	0.31];
% sorted by distance from shelf
% station lat lon distance Ra-228 stdev Ra-226 stdev
% copied from 250m228Racurve.xlsx

dist = Ra_data(:,4).*1000; % convert to m

%% find z*

Ra226 = Ra_data(:,7);
Z = dist;

% make function for T plot
C0= Ra226(end);
Cm= Ra226(1);
Zm= max(Z);
func1= @(x,a) C0+(Cm-C0).*(exp(x./a)-1)./(exp(Zm./a)-1);
Tguess=[10000]; 
[f,a,kyg,inter,corp,covp,conr,stdresid,ci,r2]=nlleasqr(Z,Ra226,Tguess,func1);
Zstar=a

% errors
Tstdev=sqrt(diag(covp)); % standard deviation is the square root of the variance. the variance is along the diagonal of the covp matrix
% confidence interval of 95% means within 2 stdev

figure(1);
plot(Z,Ra226,'o')
hold on
plot(Z,f,'-')
ylabel('Temperature (deg C)'); xlabel('z (m)'); 
hold on


%%
a = 50000;
x = Z;
S_hat = C0+(Cm-C0)*((exp(x/a)-1)/(exp(Zm/a)-1));
plot(Z,S_hat,'--');

%% add in radioactive conservative tracer: Ra-228

Ra = Ra_data(:,5);

% solve for Lstar=lambda/w
% set up function based on eqn. 13.18
global ZSTAR;
ZSTAR=Zstar;
L=log(2)/(5.75); % lambda in years-1
l = log(2)/(5.75*365*24*60);
DEPTH = dist;
% Ra = ((Ra_model_data(:,4)-1)./l).*10;
Raguess=1e5; 

% C0=Ra(end);
% Cm=Ra(1);
% Zm=max(DEPTH); % the depths of this depth vector correspond to those chosen in the Z vector that goes w/ T,S,O
% JL=0;
% A=sqrt(1+(4*Lstar*Zstar));

[f,a,kyg,inter,corp,covp,conr,stdresid,ci,r2]=nlleasqr(DEPTH,Ra,Raguess,'Kipp_funcRa2');
Lstar=a
Lstdev=sqrt(diag(covp));

figure(5);
plot(dist,Ra,'o')
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
