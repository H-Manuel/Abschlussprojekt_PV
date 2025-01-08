function deklination = Deklination(datum)
% Deklination der Sonne
%
doy = day(datum,'dayofyear');
deklination=23.45*sin((2*pi/365)*(doy+284)); % Deklination
end