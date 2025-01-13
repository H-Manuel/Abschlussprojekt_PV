function [optimal_orientations, improvement_factor] = Fixiert_optimal_ausgerichtet(phi, tag1, tag2,tag3, tag4)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
t=0:1:24;
optimal_orientations(1)=Ausrichtung(phi,tag1,t);
optimal_orientations(2)=Ausrichtung(phi,tag2,t);
optimal_orientations(3)=Ausrichtung(phi,tag3,t);
optimal_orientations(4)=Ausrichtung(phi,tag4,t);

%optimale ausrichtung fürs gesamte jahr 
%Verbersserungsfaktor von horizontale Anlage 

end

function optimal_orientation = Ausrichtung(phi, tag,t )
%AUSRICHTUNG Berechnet die optimale Ausrichtung für einen spezifischen Tag
sun_vector = Vektor_zur_Sonne(phi, tag, t); % Einheitsvektor der Sonne
panel_beta = 0:5:90;
panel_az = -180:5:180;
max_energy = 0;
for beta = panel_beta
    for azimut = panel_az
        panel_vector = [sind(beta)*cosd(azimut), sind(beta)*sind(azimut), cosd(beta)];
        leistung = Leistung_Solarzelle(panel_vector,sun_vector);
        energy = sum(leistung);
        if energy > max_energy
            max_energy = energy;
            optimal_orientation = [beta, azimut];
        end
    end
end
end



% function sun_vector = Vektor_zur_Sonne(phi, tag, t)
% %VEKTOR_ZUR_SONNE Berechnet den Einheitsvektor zur Sonne
% delta = Deklination(datetime(tag)); % Deklination
% 
% % Sonnenhöhe und Azimut berechnen
% a = Hoehenwinkel(phi,delta,t);
% az = Azimut(delta, a, phi, t);
% az(t > 12) = 360 - az(t > 12); % Nachmittagskorrektur
% 
% % Einheitsvektor berechnen
% sun_vector = [cosd(a).*cosd(az); cosd(a).*sind(az); sind(a)];
% end