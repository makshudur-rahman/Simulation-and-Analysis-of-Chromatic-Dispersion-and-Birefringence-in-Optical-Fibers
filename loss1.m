clc;
close all;
clear;

% Step 1: Read the data
data = readmatrix('n_eff2.csv');

% Step 2: Extract lambda (wavelength in nm) and Imaginary part of neff
lambda_nm = data(:,1);      % 1st column: wavelength in nm
Img_neff = data(:,4);       % 4th column: Img(neff)

% Step 3: Convert lambda from nm to meters
lambda_m = lambda_nm * 1e-9;  

% Step 4: Calculate k0 = 2*pi/lambda (lambda in meters)
k0 = (2*pi) ./ lambda_m;     

% Step 5: Calculate Loss L (dB/km)
L = Img_neff .* 8.686 .* k0 * 1e3;

% Step 6: Plotting
figure;
plot(lambda_nm, L, 'k', 'LineWidth', 2);
xlabel('Wavelength (nm)');
ylabel('Attenuation Loss (dB/km)');
title('Attenuation Loss vs Wavelength');
grid on;

% Step 7: Save Attenuation Loss data to CSV
output_data = [lambda_nm, L]; % Combine into two columns
csv_filename = 'attenuation_loss.csv';
writematrix(output_data, csv_filename);

disp(['Attenuation loss data saved to ', csv_filename]);
