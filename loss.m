% Read n_eff data
data = readmatrix('n_eff1.csv');       % Ensure the file name matches (n_eff1.csv or n_eff.csv)

% Extract wavelength and real/imaginary parts of n_eff
lambda_nm = data(:,1);                 % Wavelength in nm (Column A)
real_n_eff = data(:,3);                % Real part of n_eff (Column C)
imag_n_eff = data(:,4);                % Imaginary part of n_eff (Column D)

% Construct complex n_eff
n_eff = real_n_eff + 1i * imag_n_eff;  % Create complex number: real + j*imag

% Convert wavelength from nm to µm
lambda = lambda_nm ;             % Convert nm to µm

% Extract imaginary part of n_eff (for clarity, though we already have it)
n_eff_imag = imag(n_eff);              % Should match data(:,4)

% Free space wave number k0
k0 = 2 * pi ./ lambda;                 % in µm⁻¹

% Attenuation Loss (dB/km)
L = 8.686 .* k0 .* n_eff_imag * 1e9;   % 1e3 converts µm⁻¹ to km⁻¹

% Plot Attenuation Loss
figure;
plot(lambda_nm, L, 'r', 'LineWidth', 2);
xlabel('Wavelength (nm)');
ylabel('Attenuation Loss (dB/km)');
title('Attenuation Loss vs Wavelength');
grid on;

% Save to CSV
output = [lambda_nm, L];
writematrix(output, 'attenuation_loss.csv');
disp('Attenuation loss data saved to attenuation_loss.csv');