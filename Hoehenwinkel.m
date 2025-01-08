function a = Hoehenwinkel(phi, delta, t)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
sin_a=@(t) (sind(phi)*sind(delta)+cosd(phi)*cosd(delta)*cosd(15*(t-12)));
a = asind(sin_a(t)); % Höhenwinkel alpha
plot(t,a)
ylim([-50 50]);
xlim([0 24]);
end