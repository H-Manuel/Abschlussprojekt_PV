function sonnen_vektor = Vektor_zur_Sonne(breite, doy, zeit)
    % Umwandlung des DOY (Tag des Jahres) in ein datetime-Objekt
    datum = datetime(2025, 1, 1) + days(doy - 1);  % Jahr 2025, mit DOY als Tag des Jahres
    
    % Berechnungen der Deklination, Stundenwinkel, Höhenwinkel und Azimut
    delta = Deklination(datum); % Deklination (mit datetime)
    hoehenwinkel = Hoehenwinkel(breite, delta, zeit); % Höhenwinkel
    azimutwinkel = Azimut(delta, hoehenwinkel, breite, zeit); % Azimutwinkel
    
    % Berechnung des Sonnenvektors
    sx = cosd(hoehenwinkel) .* cosd(azimutwinkel);
    sy = cosd(hoehenwinkel) .* sind(azimutwinkel);
    sz = sind(hoehenwinkel);
    sonnen_vektor = [sx, sy, sz];
end
