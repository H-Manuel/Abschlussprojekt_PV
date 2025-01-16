function [annual_energy,monthly_energies] = Horizontal_ausgerichtete(phi)
%Horizontal ausgerichtete Anlage
%   Berechnen Sie die Energie, die eine horizontale Solaranlage am jeweils 21. der Monate März,
%   Juni,September und Dezember in Elektrizität umwandeln kann.
%   Berechnen Sie die Energie, die diese Anlage innerhalb eines Jahres umwandeln kann.



%Definieren der Startwerte
%[80,172,264,355] Tage des jahres jeweisl der 21.

days = [datetime('21-März-2025'), datetime('21-Juni-2025'),datetime('21-September-2025'), datetime('21-Dezember-2025')];%gesuchten Tage des Jahres
hours = 0:1:23;
P_max = 200;

%Initialisierung
annual_energy = 0;
monthly_energies = zeros(1, numel(days));


for d = 1:numel(days)
    delta = Deklination(days(d));
    daily_energy = 0;


    for h = hours
        stundenwinkel = Stundenwinkel(hours(h));
        
        
     alpha=Hoehenwinkel(phi,delta,stundenwinkel);
    
         if alpha > 0
             P = P_max * sin(alpha);
             daily_energy = daily_energy + P;
        
         end
    end

 %Energie pro Monatstag berechnen
 monthly_energies(d) = daily_energy;
 annual_energy = annual_energy +daily_energy;
%Test
%Test
end


