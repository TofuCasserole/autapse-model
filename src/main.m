% From Hodgkin & Huxley, 1952
% @ https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1392413/pdf/jphysiol01442-0106.pdf
Cm = 1e-6;       % bulk membrane capacitance (F/cm^2)
gNa = 120e-3;    % bulk maximum sodium channel conductance (S/cm^2)
gK = 36e-3;      % bulk maximum potassium channel conductance (S/cm^2)
gCl = 0.301e-3;  % bulk chloride channel conductance (S/cm^2)
gCy = 3.33e-3;   % bulk internal conductance (S/cm)

% From Textbook
E_Na = 56e-3;      % sodium nernst potential (V) 
E_K = -77e-3;      % potassium nernst potential (V)
E_Cl = -68e-3;     % chloride nernst potential (V)

V0 = -68e-3;
h0 = 0.6833;
m0 = 0.03877;
n0 = 0.2787;

% Preliminary neuron geometry parameters
% from wikipedia (specify sources later)
rSoma = 8.75e-4;    % soma radius (cm)
r = 0.5e-4;         % axon/dendrite radius (cm)

% Active isopotential cell simulation
surfArea = 4 * pi * rSoma^2;
C_m = Cm * surfArea;
g_Na = gNa * surfArea;
g_K = gK * surfArea;
g_Cl = gCl * surfArea;

isoActive = ActiveSection(C_m,g_Na,g_K,g_Cl,E_Na,E_K,E_Cl);
isoPassive = PassiveSection(C_m,g_Cl,E_Cl);

[t,s] = ode15s(@(t,s) isoActive.dyn(s,istim(t)),[0 5], [V0; h0; m0; n0]);
plot(t,s);

function I = istim(t)
    if (t > 1 && t < 2)
        I = 0.8e-9;
    else
        I = 0;
    end
end