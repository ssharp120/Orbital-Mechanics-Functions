vr_ECI = zeros(results.v_length, 3);

for (i = 1:results.v_length)
    vr_ECI(i, :) = COEStoVectors(earth.mu, ...
        results.COES_final(i, 1), results.COES_final(i, 2), results.COES_final(i, 6), ...
        results.COES_final(i, 5), results.COES_final(i, 3), results.COES_final(i, 4));
end

f{1} = figure("Name", "Target orbit")
f{1}.Position = [100 100 900 800];

plot3(vr_ECI(:, 1), vr_ECI(:, 2), vr_ECI(:, 3), 'Color', '#F3F3F3', 'LineWidth', 2)

grid on
hold on

plot3(vr_ECI(1, 1), vr_ECI(1, 2), vr_ECI(1, 3), 'o', 'Color', '#F3F3F3', 'MarkerSize', 8, 'MarkerFaceColor', '#AAAAAA')

[x, y, z] = sphere(100);
s = surf(x * earth.r, y * earth.r, z * earth.r);
s.EdgeColor = 'none';
s.FaceColor = '#11119A';

title("Target orbit and starting position in ECI")
xlabel("x [km]")
ylabel("y [km]")
zlabel("z [km]")

axis([-45000 45000 -45000 45000 -45000 45000])

set(gca, 'color', '#030303')