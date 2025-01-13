function [az] = Azimut(delta, a, phi,t)
% Berechnet und visualisiert den Azimutwinkel der Sonne in Grad.
%
% Eingabe:
%   delta - Sonnen-Deklination in Grad.
%   a     - Höhenwinkel der Sonne in Grad.
%   phi   - Geographische Breite in Grad (z. B. 48.1 für München).
%   t     - Uhrzeit in Dezimalstunden (z. B. 14.5 für 14:30 Uhr).
% Ausgabe:
%   az - Azimutwinkel der Sonne in Grad, gemessen vom Norden im Uhrzeigersinn.
%
cosaz=(sind(delta)-sind(a)*sind(phi))./(cosd(a)*cosd(phi));
az=real(acosd(cosaz)); % Azimut az (Winkel zur Nordrichtung)

end