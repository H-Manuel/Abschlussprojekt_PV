function [optimal_orientations, energy_year] = Fixiert_optimal_ausgerichtet(phi, tag1, tag2,tag3, tag4)
% Berechnet die optimale Ausrichtung für die übergebenen Tage
%
% Eingabe:
%   phi   - Geographische Breite in Grad (z. B. 48.1 für München).
%   tag1...4 - Tage als datetime Objekt.
% Ausgabe:
%   optimal_orientations - 5x1 Vektor der optimalen ausrichtung für die
%   übergebenen Tage, wobei der 5te Wert die im durchschnitt beste
%   Ausrichtung über ein Jahr gesehen ist.
%   improvement_factor - Verbesserungsfaktor gegenüber einer horizontalen
%   Anlage 
t=1:1:24;
optimal_orientations(1, :) = Ausrichtung(phi, tag1, t);
optimal_orientations(2, :) = Ausrichtung(phi, tag2, t);
optimal_orientations(3, :) = Ausrichtung(phi, tag3, t);
optimal_orientations(4, :) = Ausrichtung(phi, tag4, t);

%optimale ausrichtung fürs gesamte jahr 
%Verbersserungsfaktor von horizontale Anlage

%Durchschnittlich beste Ausrichtung über ein Jahr gesehen
sum=[0 0];
for doy=1:1:365
    orientation=Ausrichtung(phi, datetime(2025, 1, 1) + days(doy - 1), t);
    sum(1)=sum(1)+orientation(1);
    sum(2)=sum(2)+orientation(2);
end
optimal_orientations(5,:)=[sum(1)/365 sum(2)/365];

%Beste Ausrichtung über ein jahr
[optimal_orientation_year,energy]=Ausrichtung_Jahr(phi,t);
optimal_orientations(6,:)=optimal_orientation_year;
energy_year=energy;


end

function optimal_orientation = Ausrichtung(phi, tag,t )
%AUSRICHTUNG Berechnet die optimale Ausrichtung für einen spezifischen Tag
% sun_vector = Vektor_zur_Sonne(phi, tag, t); % Einheitsvektor der Sonne
% panel_beta = 0:5:90;
% panel_az = -180:5:180;
% max_energy = 0;
% 
% for beta = panel_beta
%     for azimut = panel_az
%         panel_vector = [sind(beta)*cosd(azimut), sind(beta)*sind(azimut), cosd(beta)];
%         leistung = arrayfun(@(i) ...
%             Leistung_Solarzelle(panel_vector, sun_vector(:, i)), ...
%             1:size(sun_vector, 2));
%         energy = sum(leistung);
%         if energy > max_energy
%             max_energy = energy;
%             optimal_orientation = [beta, azimut];
%         end
%     end
% end

% Berechnet die optimale Ausrichtung für einen spezifischen Tag
sun_vector = Vektor_zur_Sonne(phi, day(tag,'dayofyear'), t); % Einheitsvektor der Sonne

% Definiere die Zielfunktion
% x(1)=Höhenwinkel Panel
% x(2)=Azimut Panel
energy_fun = @(x) -sum(arrayfun(@(i) ...
    Leistung_Solarzelle([sind(x(2))*cosd(x(1)); sind(x(2))*sind(x(1)); cosd(x(2))], ...
    sun_vector(:, i)), 1:size(sun_vector, 2)));

% Startwerte für die Optimierung
x0 = [45, 45];

% Optimierung durchführen
optimal_orientation = fminsearch(energy_fun, x0);
end

function [optimal_orientation, energy] = Ausrichtung_Jahr(phi, t)
% Berechnet die optimale Ausrichtung über ein Jahr hinweg
% Eingaben:
% - phi: Breitengrad des Standorts
% - dates_of_year: Vektor von datetime-Objekten (z. B. alle Tage eines Jahres)
% - t: Zeit des Tages (z. B. mittags, falls du für eine bestimmte Zeit berechnen willst)


% Matrix, die alle Sonnenvektoren über das Jahr speichert (3xN für jeden Tag)
sun_vector = zeros(3, 24, 365);  % 3x24x365 Matrix 





%%Warum hier 25
%%Vektor sonne semicolons
%%in der main besser darstellen und eventuell visualisierung






for i = 1:365
    % Hier gehen wir davon aus, dass Vektor_zur_Sonne für jeden Tag eine 3x24 Matrix zurückgibt
    % Diese Matrix enthält für jede Stunde des Tages den entsprechenden Sonnenvektor    
    % Speichere alle Sonnenvektoren für diesen Tag
    sun_vector(:, :, i) = Vektor_zur_Sonne(phi, i, t);  % Sonnenvektoren für alle Stunden des Tages
end

% Definiere die Zielfunktion für die Jahresenergie
% x(1) = Höhenwinkel Panel
% x(2) = Azimut Panel
energy_fun = @(x) -sum(arrayfun(@(i) ...
    sum(arrayfun(@(h) Leistung_Solarzelle([sind(x(2))*cosd(x(1)); sind(x(2))*sind(x(1)); cosd(x(2))], ...
    sun_vector(:, h, i)), 1:24)), 1:365));

% Startwerte für die Optimierung
x0 = [45, 45];

% Optimierung durchführen
optimal_orientation = fminsearch(energy_fun, x0);
energy=-energy_fun(optimal_orientation);
end



