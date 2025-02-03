%% re-do of Kz model (ESS only)
% started 6/14/23
% copied code from Alyssa's codes

data = [80	75.55196667	174.1041833	5.491455088	0.549649165
79	75.67676667	175.1353167	4.392621712	0.75754272
72	76.90951667	-177.9094667	2.33754483	0.675550456
64	78.4923833	-170.096683	1.532327299	0.394240656];
% station lat lon Ra-228 err

wgs84 = wgs84Ellipsoid("m");
lat1 = 75.55196667; % station 80 (~211 m deep)
lon1 = 174.1041833;
d = distance(lat1,lon1,data(:,2),data(:,3),wgs84);

Ra = ((data(:,4)-1)./2.2935e-07).*10; % corrected for background (1 dpm/100L), in units of atoms/m3
Ra_err = (data(:,5)./data(:,4)).*Ra;

%%
figure; hold on;
set(gcf,'Color',[1,1,1]);

errorbar(d,Ra,Ra_err,'ko','markerfacecolor','k','markersize',9);

[FO, G] = fit(d, Ra, 'exp1');
line = plot(FO, d, Ra);
legend('hide');
set(line,'color','k','linestyle','--');

xhat = [0:500:550000];
yhat = 1.856e8*exp(-xhat*4.528e-6);
l1 = plot(xhat, yhat, 'k--');

yhat2 = 1.439e8*exp(-xhat*7.635e-6);
% l2 = plot(xhat, yhat2, 'k--');

yhat3 = 2.274e8*exp(-xhat*1.422e-6);
% l3 = plot(xhat, yhat3, 'k--');

ylabel('^{228}Ra (x 10^{8} atoms m^{-3})','FontSize',12,'Color','k');
xlabel('Distance (x 10^{5} m)','FontSize',12,'Color','k');
good_titles(20);

%% flux calc

lambda_sec = 3.8217e-09;
b = [-7.635e-06 -4.528e-06 -1.422e-06];
Kh = (lambda_sec./b.^2)

theta = 0.001975; % sin(0.113) in degrees
c = [1.439e+08 1.856e+08 2.274e+08];
i = c./-b;
% lambda_y = 0.1205;
lambda_d = 3.30267e-4;
flux = (i*lambda_d*theta)




