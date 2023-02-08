function Se = calculateSolarPower(current_date)

    % Steven Sharp
    % AERO 452 - California Polytechnic State University
    % Dr. Abercromby
    % 4 December 2022

if (current_date.Year < 2022 || current_date.Year > 2026)
    Da = caldays(between(datetime([current_date.Year, 7, 5, 0, 0, 0]), current_date, 'days'));
else
    if (current_date.Year == 2022)
        Da = caldays(between(datetime([2022, 7, 4, 0, 10, 0]), current_date, 'days'));
    elseif (current_date.Year == 2023)
        Da = caldays(between(datetime([2023, 7, 6, 13, 6, 0]), current_date, 'days'));
    elseif (current_date.Year == 2024)
        Da = caldays(between(datetime([2024, 7, 4, 22, 6, 0]), current_date, 'days'));
    elseif (current_date.Year == 2025)
        Da = caldays(between(datetime([2025, 7, 3, 12, 54, 0]), current_date, 'days'));
    elseif (current_date.Year == 2026)
        Da = caldays(between(datetime([2026, 7, 6, 10, 30, 0]), current_date, 'days'));
    end
end

Se = 1358 / (1.004 + 0.0534 * cosd(Da));

end