function stundenwinkel = Stundenwinkel(t)
% Berechnet den Stundenwinkel der Sonne in Grad.
%
% Eingabe:
%   t - Uhrzeit in Dezimalstunden (z. B. 14.5 für 14:30 Uhr).
% Ausgabe:
%   stundenwinkel - Stundenwinkel der Sonne in Grad, gemessen relativ 
%                    zum lokalen Meridian (0° bei 12:00 Uhr).
%
stundenwinkel=15*(t-12); %Stundenwinkel
end