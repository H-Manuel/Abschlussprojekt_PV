function [az] = Azimut(delta, a, phi)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

cosaz=(sind(delta)-sind(a)*sind(phi))./(cosd(a)*cosd(phi));
az=real(acosd(cosaz)); % Azimut az (Winkel zur Nordrichtung)

end