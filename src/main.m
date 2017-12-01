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

% determined from geometry
dx = 4.5161e-4;

% Active isopotential cell simulation
surfAreaSoma = 4 * pi * rSoma^2;
surfAreaSection = pi * r^2 * dx;
crossArea = pi * r^2;
C_m_soma = Cm * surfAreaSoma;
g_Na_soma = gNa * surfAreaSoma;
g_K_soma = gK * surfAreaSoma;
g_Cl_soma = gCl * surfAreaSoma;
C_m_section = Cm * surfAreaSection;
g_Cl_section = gCl * surfAreaSection;
g_i_section = gCy * crossArea / dx;
g_i_soma = 2/3 * gCy * pi * rSoma^3;

section = PassiveSection(C_m_section,g_Cl_section,E_Cl);
soma = ActiveSection(C_m_soma,g_Na_soma,g_K_soma,g_Cl_soma,...
                            E_Na,E_K,E_Cl);
                        
[t,s] = ode15s(@(t,s) isoActive.dyn(s,istim(t)),[0 5], [V0; h0; m0; n0]);
plot(t,s);

function I = istim(t)
    if (t > 1 && t < 2)
        I = 0.8e-9;
    else
        I = 0;
    end
end