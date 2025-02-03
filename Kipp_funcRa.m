function out = Kipp_funcRa(x,Lstar)

load Ra_model_data.mat;
L=log(2)/(5.75); % lambda in years-1
Ra = ((Ra_model_data(:,4)-1)./2.2935e-07).*10;

global ZSTAR;

depth = Ra_model_data(:,2)%.*1000; % depth = distance in km
DEPTH = depth;
Zstar=ZSTAR;
L=log(2)/(5.75);
C0=Ra(end);
Cm=Ra(1);
Zm=max(DEPTH); % the depths of this depth vector correspond to those chosen in the Z vector that goes w/ T,S,O
% JL=0;
A=sqrt(1+(4*Lstar*Zstar));

% out=JL+[(Cm-JL).*exp(-(Zm-x)./(2.*Zstar)).*sinh(A.*x./(2.*Zstar))+(C0-JL).*exp(x./(2.*Zstar)).*sinh(A.*(Zm-x)./(2.*Zstar))]./sinh(A.*Zm./(2.*Zstar));
out=[(Cm).*exp(-(Zm-x)./(2.*Zstar)).*sinh(A.*x./(2.*Zstar))+(C0).*exp(x./(2.*Zstar)).*sinh(A.*(Zm-x)./(2.*Zstar))]./sinh(A.*Zm./(2.*Zstar));

end