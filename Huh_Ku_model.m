%% outer x2
Kz = 5e7; %cm2/s
Kz_ = 2.5e7; %cm2/s
% lnc = -0.8e-11; %cm-1
% lnc = -0.8e-5; %km-1
lnc = -8.5e-9; %cm-1

w = -((Kz/Kz_)-1)*lnc*Kz_
% 0.2125 cm/s
%% inner x2
Kz = 1e6; %cm2/s
Kz_ = 0.5e6; %cm2/s
% lnc = -0.8e-11; %cm-1
% lnc = -0.8e-5; %km-1
lnc = -0.8e-10; %cm-1

w = -((Kz/Kz_)-1)*lnc*Kz_
% 0.00004 cm/s
%% outer x0.5
Kz = 5e7; %cm2/s
Kz_ = 1e8; %cm2/s
% lnc = -0.8e-11; %cm-1
% lnc = -0.8e-5; %km-1
lnc = -8.5e-9; %cm-1

w = -((Kz/Kz_)-1)*lnc*Kz_
% 0.4250 cm/s
%% inner x0.5
Kz = 1e6; %cm2/s
Kz_ = 2e6; %cm2/s
% lnc = -0.8e-11; %cm-1
% lnc = -0.8e-5; %km-1
lnc = -0.8e-10; %cm-1

w = -((Kz/Kz_)-1)*lnc*Kz_
% 0.00008 cm/s
%%
w = 0.22;
w/(Kz_*(1-Kz/Kz_))

%%
Kz_ = 2.5e7; %cm2/s
lnc = -8.5e-4; %km-1
w = 0.22;


Kz = Kz_*(1-(w/Kz_)*((lnc)^-1))
