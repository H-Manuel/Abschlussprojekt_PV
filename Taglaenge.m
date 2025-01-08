function taglaenge = Taglaenge(phi)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
t=0:1:24;
taglaenge = zeros(1, 365); % Platzhalter für die Taglängen
for doy=1:365
    delta=23.45*sin((2*pi/365)*(doy+284));
    sonnenaufgang = fzero(@(t) (sind(phi)*sind(delta)+cosd(phi)*cosd(delta)*cosd(15*(t-12))),[0 12]);
    sonnenuntergang = fzero(@(t) (sind(phi)*sind(delta)+cosd(phi)*cosd(delta)*cosd(15*(t-12))),[12 24]);
    taglaenge(doy)=sonnenuntergang-sonnenaufgang;
end
    plot(1:365,taglaenge)
    xlim([1,365]);
    xlabel('Tag des Jahres');
    ylabel('Taglänge (Stunden)');
    title('Taglänge über das Jahr');
    grid on;
end