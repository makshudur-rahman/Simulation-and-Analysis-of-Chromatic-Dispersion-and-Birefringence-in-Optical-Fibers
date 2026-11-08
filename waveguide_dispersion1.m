clc;
close all;
clear;

% Step 1: Read the data
data = readmatrix('n_eff2.csv');

% Step 2: Extract wavelength (in nm) and real part of neff
lambda_nm = data(:,1);      % 1st column: wavelength in nm
Re_neff = data(:,2);        % 3rd column: Real(neff)

% Step 3: Constants
c = 3e8;                    % speed of light in m/s

% Step 4: Cubic Spline interpolation of Re(neff)
pp = spline(lambda_nm, Re_neff); % Piecewise polynomial structure

% Step 5: Differentiate spline twice
pp_deriv2 = fnder(pp, 2); % 2nd derivative of Re(neff)

% Step 6: Define evaluation points exactly matching material dispersion
lambda_selected = 1400:10:1600; % Discrete points in nm (1400, 1410, ..., 1600)

% Step 7: Evaluate second derivative at selected points
d2neff_dlambda2_selected = ppval(pp_deriv2, lambda_selected);

% Step 8: Calculate waveguide dispersion D_w (ps/(nm·km))
Dw_selected = -(lambda_selected / c) .* d2neff_dlambda2_selected * 1e12; % Correct scaling

% Step 9: Plot waveguide dispersion
figure;
plot(lambda_selected, Dw_selected, 'k', 'LineWidth', 2);
xlabel('Wavelength (nm)');
ylabel('Waveguide Dispersion D_w (ps/(nm·km))');
title('Waveguide Dispersion vs Wavelength');
grid on;

% Step 10: Save waveguide dispersion data to CSV
output_data = [lambda_selected', Dw_selected']; % Make sure column vectors
csv_filename = 'waveguide_dispersion1.csv';
writematrix(output_data, csv_filename);

disp(['Waveguide dispersion data saved to ', csv_filename]);
