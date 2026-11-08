data = readmatrix('n_eff2.csv');

lambda = data(:,1) * 1e-3; % Convert nm to µm
n_eff = data(:,3);

% Speed of light in km/s
c = 299792.458; 

% Compute first derivative (dn_eff/dλ) using central differences
h = lambda(2) - lambda(1); % Step size
dn_eff_dlambda = zeros(size(lambda));

% Central difference for interior points (2nd-order accurate)
for i = 2:length(lambda)-1
    dn_eff_dlambda(i) = (n_eff(i+1) - n_eff(i-1)) / (2*h);
end

% Higher-order forward/backward differences for endpoints (2nd-order accurate)
dn_eff_dlambda(1) = (-3*n_eff(1) + 4*n_eff(2) - n_eff(3)) / (2*h); % Forward
dn_eff_dlambda(end) = (3*n_eff(end) - 4*n_eff(end-1) + n_eff(end-2)) / (2*h); % Backward

% Compute second derivative (d²n_eff/dλ²) using central differences
d2n_eff_dlambda2 = zeros(size(lambda));

% Central difference for interior points (2nd-order accurate)
for i = 2:length(lambda)-1
    d2n_eff_dlambda2(i) = (n_eff(i+1) - 2*n_eff(i) + n_eff(i-1)) / (h^2);
end

% Higher-order forward/backward differences for endpoints (2nd-order accurate)
d2n_eff_dlambda2(1) = (2*n_eff(1) - 5*n_eff(2) + 4*n_eff(3) - n_eff(4)) / (h^2); % Forward
d2n_eff_dlambda2(end) = (2*n_eff(end) - 5*n_eff(end-1) + 4*n_eff(end-2) - n_eff(end-3)) / (h^2); % Backward

% Compute waveguide dispersion D_w (ps/(nm·km))
D_w = - (lambda ./ c) .* d2n_eff_dlambda2 * 1e3; % Convert to ps/(nm·km)

% Plot waveguide dispersion curve
figure;
plot(lambda * 1000, D_w, 'r', 'LineWidth', 2); % Convert µm to nm
xlabel('Wavelength (nm)');
ylabel('Waveguide Dispersion D_w (ps/(nm·km))');
title('Waveguide Dispersion from n_{eff} Data');
grid on;

% Save computed waveguide dispersion data to CSV
output_data = [lambda * 1000, D_w]; % Convert µm to nm
csv_filename = 'waveguide_dispersion.csv';
writematrix(output_data, csv_filename);

disp(['Waveguide dispersion data saved to ', csv_filename]);