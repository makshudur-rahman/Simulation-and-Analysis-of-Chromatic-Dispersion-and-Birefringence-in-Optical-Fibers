clc;
close all;
% Define the wavelength range (in micrometers) with step size of 10 nm (0.01 µm)
lambda = (1.4:0.01:1.6); % 1400-1600 nm

% Sellmeier coefficients for fused silica
B1 = 0.6961663;
B2 = 0.4079426;
B3 = 0.8974794;
C1 = 0.0684043^2;
C2 = 0.1162414^2;
C3 = 9.896161^2;

% Compute refractive index using the Sellmeier equation
n_squared = 1 + (B1 * lambda.^2) ./ (lambda.^2 - C1) + ...
               (B2 * lambda.^2) ./ (lambda.^2 - C2) + ...
               (B3 * lambda.^2) ./ (lambda.^2 - C3);
           
n = sqrt(n_squared); % Refractive index

% Plot the refractive index curve
figure;
plot(lambda * 1000, n, 'k','LineWidth', 2); % Convert µm to nm
xlabel('Wavelength (nm)');
ylabel('Refractive Index (n)');
title('Refractive Index of Fused Silica');
grid on;

% Save data to CSV file
data = [lambda' * 1000, n']; % Convert µm to nm
csv_filename = 'fused_silica_refractive_index.csv';
writematrix(data, csv_filename);

disp(['Data saved to ', csv_filename]);
