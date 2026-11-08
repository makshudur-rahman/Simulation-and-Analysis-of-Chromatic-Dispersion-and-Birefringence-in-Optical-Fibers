clc;
close all;
clear;

% Step 1: Read Material Dispersion data
material_data = readmatrix('material_dispersion1.csv');
lambda_material = material_data(:,1); % Wavelength in nm
D_material = material_data(:,2);      % Material dispersion in ps/(nm·km)

% Step 2: Read Waveguide Dispersion data
waveguide_data = readmatrix('waveguide_dispersion2.csv');
lambda_waveguide = waveguide_data(:,1); % Wavelength in nm
D_waveguide = waveguide_data(:,2);      % Waveguide dispersion in ps/(nm·km)

% Step 3: Check if wavelength grids match
if ~isequal(lambda_material, lambda_waveguide)
    error('Wavelengths do not match between material and waveguide dispersion files!');
end

% Step 4: Calculate Chromatic Dispersion
D_chromatic = D_material + D_waveguide;

% Step 5: Plot Chromatic Dispersion
figure;
plot(lambda_material, D_chromatic, 'k', 'LineWidth', 2);
xlabel('Wavelength (nm)');
ylabel('Chromatic Dispersion D (ps/(nm·km))');
title('Chromatic Dispersion vs Wavelength');
grid on;

% Step 6: Save Chromatic Dispersion data to CSV
output_data = [lambda_material, D_chromatic];
csv_filename = 'chromatic_dispersion1.csv';
writematrix(output_data, csv_filename);

disp(['Chromatic dispersion data saved to ', csv_filename]);
