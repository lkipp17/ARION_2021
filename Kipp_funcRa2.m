function out = Kipp_funcRa(x,Lstar)


Ra_data = [64	78.4923833	-170.096683	370	1.532327299	0.394240656	9.55	0.27
13	78.5002	125.9689	244	1.784782162	0.455307836	8.49	0.26
72	76.90951667	-177.9094667	225	2.33754483	0.675550456	7.73	0.34
7	80.23375	125.9215	209	1.40245708	0.353138693	8.60	0.20
1	81.91278333	125.9500833	173	1.29	0.53	7.20	0.35
98	81.73071667	136.6018833	114	1.662508285	0.287932921	8.43	0.19
79	75.67676667	175.1353167	54	4.392621712	0.75754272	9.59	0.48
90	79.9344	142.2475	29	2.672436854	0.612522527	9.19	0.32
80	75.55196667	174.1041833	26	5.491455088	0.549649165	8.13	0.31];

L=log(2)/(5.75); % lambda in years-1
Ra = Ra_data(:,5);

global ZSTAR;

dist = Ra_data(:,4).*1000; % convert to m
DEPTH = dist;
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