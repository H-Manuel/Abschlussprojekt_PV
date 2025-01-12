function deklination = Deklination(datum)
% Berechnet die Sonnen-Deklination in Grad für ein gegebenes Datum.
%
% Eingabe:
%   datum - Datum im Format datetime.
% Ausgabe:
%   deklination - Sonnen-Deklination in Grad.
%
doy = day(datum,'dayofyear');
deklination=23.45*sin((2*pi/365)*(doy+284)); % Deklination
end