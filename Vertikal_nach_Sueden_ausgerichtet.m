function jahres_energie = Vertikal_nach_Sueden_ausgerichtet(phi)
    
    zeiten = 0:1:24; % tag in stunden
    tages = [21, 21, 21, 21]; % Tage des Monats
    monate = [3, 6, 9, 12]; % Monate

    neigung = [0; 0; 1]; % Normalenvektor der Solarzelle
    
    energie_pro_tag = zeros(1, length(monate)); % Energieumrechnung pro Tag in den vier Monaten

    for i = 1:length(monate)
        % Datum für jeden der 21. Tage der Monate
        datum = datetime(2025, monate(i), tages(i));
        
        delta = Deklination(datum);
        a = Hoehenwinkel(phi, delta, zeiten);
        az = Azimut(delta, a, phi, zeiten);

        s = Vektor_zur_Sonne(a, az); % vektor zur Sonne

        % Leistung pro Stunde berechnen
        P = zeros(size(zeiten));
        for j = 1:length(zeiten)
            P(j) = Leistung_Solarzelle(neigung, s(:, j));
        end

        % Tagesenergie berechnen (Integration über die Tageszeit)
        tagesenergie = trapz(zeiten, P); % Trapezregel zur Integration
        energie_pro_tag(i) = tagesenergie;
    end

    % Jahresenergie durch mittelwert
    jahres_energie = sum(energie_pro_tag);
    
    % Ergebnisse ausgeben
    fprintf('Energie pro Tag an den jeweiligen Tagen (März, Juni, September, Dezember):\n');
    disp(energie_pro_tag);
    fprintf('Gesamte umgewandelte Energie innerhalb eines Jahres: %.2f kWh\n', jahres_energie);
end