function a = Hoehenwinkel(phi, delta, t)
% Berechnet und visualisiert den Höhenwinkel der Sonne in Grad.
%
% Eingabe:
%   phi   - Geographische Breite in Grad (z. B. 48.1 für München).
%   delta - Sonnen-Deklination in Grad.
%   t     - Uhrzeit in Dezimalstunden (z. B. 14.5 für 14:30 Uhr).
% Ausgabe:
%   a - Höhenwinkel der Sonne in Grad, gemessen über dem Horizont.
%
sin_a=@(t) (sind(phi)*sind(delta)+cosd(phi)*cosd(delta)*cosd(15*(t-12)));
a = asind(sin_a(t)); % Höhenwinkel alpha
plot(t,a)
ylim([-50 50]);
xlim([0 24]);
end