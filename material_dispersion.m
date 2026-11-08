clc;
close all;
clear;

% Define the wavelength range (in micrometers) with 10 nm (0.01 µm) step
lambda_dense = linspace(1.4, 1.6, 1000); % Dense points in micrometers (for spline fitting)

% Sellmeier coefficients for fused silica
B1 = 0.6961663;
B2 = 0.4079426;
B3 = 0.8974794;
C1 = 0.0684043^2;
C2 = 0.1162414^2;
C3 = 9.896161^2;

% Compute refractive index using the Sellmeier equation
n_squared = 1 + (B1 * lambda_dense.^2) ./ (lambda_dense.^2 - C1) + ...
               (B2 * lambda_dense.^2) ./ (lambda_dense.^2 - C2) + ...
               (B3 * lambda_dense.^2) ./ (lambda_dense.^2 - C3);
n = sqrt(n_squared); % Refractive index

% Step 1: Cubic Spline interpolation of n(lambda)
pp_n = spline(lambda_dense, n); % Piecewise polynomial structure

% Step 2: Differentiate spline twice to get second derivative
pp_n_deriv2 = fnder(pp_n, 2); % 2nd derivative of n(lambda)

% Step 3: Define discrete wavelength points
lambda_discrete = 1400:10:1600; % in nm
lambda_discrete_um = lambda_discrete * 1e-3; % convert nm to µm

% Step 4: Evaluate second derivative at discrete points
d2n_dlambda2_discrete = ppval(pp_n_deriv2, lambda_discrete_um);

% Step 5: Calculate Material Dispersion D(λ) (ps/(nm·km))
c = 299792.458; % Speed of light in km/s
D_material = -(lambda_discrete_um ./ c) .* d2n_dlambda2_discrete * 1e9; % Correct scaling

% Step 6: Plot Material Dispersion curve
figure;
plot(lambda_discrete, D_material, 'k', 'LineWidth', 2);
xlabel('Wavelength (nm)');
ylabel('Material Dispersion D (ps/(nm·km))');
title('Material Dispersion of Fused Silica (Discrete Points)');
grid on;

% Step 7: Save Material Dispersion data to CSV
output_data = [lambda_discrete', D_material']; % Column vectors
csv_filename = 'material_dispersion1.csv';
writematrix(output_data, csv_filename);

disp(['Material dispersion data saved to ', csv_filename]);
