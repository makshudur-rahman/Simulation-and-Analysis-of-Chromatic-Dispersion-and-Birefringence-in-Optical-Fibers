clc;
close all;
clear;

% Step 1: Read Material Dispersion data
material_data = readmatrix('material_dispersion1.csv');
lambda_material = material_data(:,1); % Wavelength in nm
D_material = material_data(:,2);      % Material dispersion in ps/(nm·km)

% Step 2: Read Waveguide Dispersion data
waveguide_data = readmatrix('waveguide_dispersion1.csv');
lambda_waveguide = waveguide_data(:,1); % Wavelength in nm
D_waveguide = waveguide_data(:,2);      % Waveguide dispersion in ps/(nm·km)

% Step 3: Check if wavelength grids match
if ~isequal(lambda_material, lambda_waveguide)
    error('Wavelengths do not match between material and waveguide dispersion files!');
end

% Step 4: Calculate Chromatic Dispersion
D_chromatic = D_material + D_waveguide;

% Step 5: Plot all three dispersions together
figure;
hold on;
plot(lambda_material, D_material, 'b-', 'LineWidth', 2); % Material Dispersion (blue solid)
plot(lambda_waveguide, D_waveguide, 'r--', 'LineWidth', 2); % Waveguide Dispersion (red dashed)
plot(lambda_material, D_chromatic, 'k-.', 'LineWidth', 2); % Chromatic Dispersion (black dash-dot)
hold off;

xlabel('Wavelength (nm)', 'FontSize', 12);
ylabel('Dispersion D (ps/(nm·km))', 'FontSize', 12);
title('Material, Waveguide, and Chromatic Dispersion vs Wavelength', 'FontSize', 14);
legend('Material Dispersion', 'Waveguide Dispersion', 'Chromatic Dispersion', 'Location', 'best');
grid on;
set(gca, 'FontSize', 12); % Set font size for better readability
