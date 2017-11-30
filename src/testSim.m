function sDot = testSim(~,s)
    r = 0.8e-4;             % radius (cm)
    crossArea = pi * r^2;   % cross sectional area (cm^2)

    length = 0.25;          % length (cm)
    dx = length / 3;        % section length (cm)

    surfArea = 2 * pi * r * dx; % surface are (cm^2)

    Rm = 15e3;      % Ohm*cm^2
    Ri = 470;       % Ohm*cm
    Rout = 24e4;    % Ohm*cm^2
    Cm = 3e-6;      % Farad/cm^2
    Io = 13e-9;     % Ampres

    g_Cl = surfArea / Rm;
    g_a = crossArea / (Ri * dx);
    g_out = crossArea / Rout;
    C_m = Cm * surfArea;

    E_Cl = -23e-3;

    dendriteSection = PassiveSection(C_m, g_Cl, E_Cl);

    adjMatrix = [0, g_a, 0; g_a, 0, g_a; 0, g_a, 0];
    inputMatrix = constructInputMatrix(adjMatrix);

    input = (inputMatrix * s) + [Io/2; 0; 0];
    sDot = arrayfun(@dendriteSection.dyn, s, input);
end
