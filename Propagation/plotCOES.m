function f = plotCOESforSun(results)

% Steven Sharp
% AERO 452 - California Polytechnic State University
% Dr. Abercromby
% 4 December 2022

f = cell(1, 2);

% Variation of Parameters
f{1} = figure("Name", "Perturbations");
f{1}.Position = [100 0 900 1000];

subplot(3, 1, 1)

plot(results.time_final / 24 / 3600, results.COES_final(:, 1) - results.COES_final(1, 1), 'k')

grid on
hold on

ylabel("\Deltae")
xlabel("Time (days)")

subplot(3, 1, 2)

plot(results.time_final / 24 / 3600, results.COES_final(:, 2) - results.COES_final(1, 2), 'k')

grid on
hold on

ylabel("\Deltah (km^2/s)")
xlabel("Time (days)")

subplot(3, 1, 3)

plot(results.time_final / 24 / 3600, results.COES_final(:, 3) - results.COES_final(1, 3), 'k')

grid on
hold on

ylabel("\Deltai (°)")
xlabel("Time (days)")

sgtitle("Perturbational effects on COEs using Variation of Parameters")

f{2} = figure("Name", "Perturbations II");
f{2}.Position = [100 0 900 1000];

subplot(3, 1, 1)

plot(results.time_final / 24 / 3600, results.COES_final(:, 4) - results.COES_final(1, 4), 'k')

grid on
hold on

ylabel("\Delta\Omega (°)")
xlabel("Time (days)")

subplot(3, 1, 2)

plot(results.time_final / 24 / 3600, results.COES_final(:, 5) - results.COES_final(1, 5), 'k')

grid on
hold on

ylabel("\Delta\omega (°)")
xlabel("Time (days)")

subplot(3, 1, 3)

plot(results.time_final / 24 / 3600, results.semi_major_axis - results.semi_major_axis(1), 'k')

grid on
hold on

ylabel("\Deltaa (km)")
xlabel("Time (days)")

end