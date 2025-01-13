function P = Leistung_Solarzelle(n, s)
    % Berechnet die Leistung der Solarzelle basierend auf der Ausrichtung
    % n: Normalenvektor der Solarzelle [3x1]
    % s: Sonnenvektor [3x1]
    % Rückgabe: Leistung der Solarzelle in W/m²
    
    % Maximale Leistung
    P_max = 200; % W/m²
    
    % Skalarprodukt und Normen der Vektoren
    cos_theta = dot(n, s) / (norm(n) * norm(s));
    
    % Leistung basierend auf dem Winkel
    P = P_max * max(0, cos_theta);
end

