function jahres_energie = Vertikal_nach_Sueden_ausgerichtet(phi)
    
    zeiten = 0:1:24; % tag in stunden
    tages = [21, 21, 21, 21]; % Tage des Monats
    monate = [3, 6, 9, 12]; % Monate

    neigung = [0; 0; 1]; % Normalenvektor der Solarzelle
    
    energie_pro_tag = zeros(1, length(monate)); % Energieumrechnung pro Tag in den vier Monaten

    for i = 1:length(monate)

        datum = datetime(2025, monate(i), tages(i)); % Erstelle ein Datum
        Doy = day(datum, 'dayofyear'); % Extrahiere den Tag des Jahres

        s = Vektor_zur_Sonne(phi, Doy,zeiten); % vektor zur Sonne

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