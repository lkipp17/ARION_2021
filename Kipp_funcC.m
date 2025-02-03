function out = Kipp_funcC(x,Lstar)
    
load hydro.mat % contains o,s,t,tco2,z
load c14.mat % contains c14 and corresponding depths

global ZSTAR JSTAR;

DEPTH = -1*depth+max(depth);
Zstar=ZSTAR;
JstarC14=JSTAR;
% Zstar=526.8835;
% JstarC14= 0.0099;
L=log(2)/(5730);
C14=(1+del14./1000).*tco2; % eqn 13.21
C0=C14(end);
Cm=C14(1);
Zm=max(DEPTH); % the depths of this depth vector correspond to those chosen in the Z vector that goes w/ T,S,O
JL=JstarC14./Lstar;
A=sqrt(1+(4*Lstar*Zstar));

out=JL+[(Cm-JL).*exp(-(Zm-x)./(2.*Zstar)).*sinh(A.*x./(2.*Zstar))+(C0-JL).*exp(x./(2.*Zstar)).*sinh(A.*(Zm-x)./(2.*Zstar))]./sinh(A.*Zm./(2.*Zstar));

end

