clc;
clear;
close all;

%% Constants
r_earth = 6371;
LEO_alt = 500;
GEO_alt = 35786;
MEO_alt = 20200;
HEO_apogee = 40000;
HEO_perigee = 500;
i_LEO = 0;
i_MEO = 0;
i_GEO = 0;
i_HEO = 63.4; % Molniya

%% Orbit Rotation
rotateOrbit = @(x, y, z, inc_deg) deal( ...
    x, ...
    y*cosd(inc_deg) - z*sind(inc_deg), ...
    y*sind(inc_deg) + z*cosd(inc_deg) ...
);

%% Generate Earth Sphere and Set Orbits
[xe, ye, ze] = sphere(100);
earth = surf(r_earth*xe, r_earth*ye, r_earth*ze); 
hold on
set(earth, 'FaceColor', 'g', 'EdgeColor', 'none', 'FaceAlpha', 0.7);

% Lower Earth Orbit
r_LEO = r_earth + LEO_alt;
theta = linspace(0, 2*pi, 500);
x_LEO = r_LEO * cos(theta);
y_LEO = r_LEO * sin(theta);
z_LEO = zeros(size(theta));
[x_LEO, y_LEO, z_LEO] = rotateOrbit(x_LEO, y_LEO, z_LEO, i_LEO);
plot3(x_LEO, y_LEO, z_LEO, 'r', 'LineWidth', 2);

% Medium Earth Orbit
r_MEO = r_earth + MEO_alt;
x_MEO = r_MEO * cos(theta);
y_MEO = r_MEO * sin(theta);
z_MEO = zeros(size(theta));
[x_MEO, y_MEO, z_MEO] = rotateOrbit(x_MEO, y_MEO, z_MEO, i_MEO);
plot3(x_MEO, y_MEO, z_MEO, 'c', 'LineWidth', 2);

% Greater Earth Orbit
r_GEO = r_earth + GEO_alt;
x_GEO = r_GEO * cos(theta);
y_GEO = r_GEO * sin(theta);
z_GEO = zeros(size(theta));
[x_GEO, y_GEO, z_GEO] = rotateOrbit(x_GEO, y_GEO, z_GEO, i_GEO);
plot3(x_GEO, y_GEO, z_GEO, 'b', 'LineWidth', 2);

% Highly Elliptical Orbit
a_HEO = (HEO_apogee + HEO_perigee + 2*r_earth)/2; % semi-major axis
e_HEO = (HEO_apogee - HEO_perigee)/(HEO_apogee + HEO_perigee + 2*r_earth); % eccentricity
r_HEO = a_HEO * (1 - e_HEO^2) ./ (1 + e_HEO * cos(theta));
x_HEO = r_HEO .* cos(theta);
y_HEO = r_HEO .* sin(theta);
z_HEO = zeros(size(theta));
[x_HEO, y_HEO, z_HEO] = rotateOrbit(x_HEO, y_HEO, z_HEO, i_HEO);
plot3(x_HEO, y_HEO, z_HEO, 'm', 'LineWidth', 2);

%% Graph
axis equal;
grid on;
set(gcf, 'Color', 'k');  
ax = gca;
ax.XColor = 'w';
ax.YColor = 'w';
ax.ZColor = 'w';
set(gca, 'Color', 'k');
xlabel('X (km)');
ylabel('Y (km)');
zlabel('Z (km)');
title = title('Earth with LEO, MEO, GEO, and HEO Orbits (3D)');
set(title, 'Color', 'w');
lgd = legend('Earth', 'LEO', 'MEO', 'GEO', 'HEO');
set(lgd, 'Color', 'k', 'TextColor', 'w');
view(3);