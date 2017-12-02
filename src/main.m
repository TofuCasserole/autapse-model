% From Hodgkin & Huxley, 1952
% @ https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1392413/pdf/jphysiol01442-0106.pdf
Cm = 1e-6;       % bulk membrane capacitance (F/cm^2)
gNa = 120e-3;    % bulk maximum sodium channel conductance (S/cm^2)
gK = 36e-3;      % bulk maximum potassium channel conductance (S/cm^2)
gCl = 0.301e-3;  % bulk chloride channel conductance (S/cm^2)

% source??
gCy = 3.33e-3;   % bulk internal conductance (S/cm)

% From Textbook
E_Na = 56e-3;      % sodium nernst potential (V) 
E_K = -77e-3;      % potassium nernst potential (V)
E_Cl = -68e-3;     % chloride nernst potential (V)

V0 = -68e-3;

% from HW3
g_peak = 2e-9;
E_syn = E_Cl + 300e-3;
t_peak = 5e-3;

% determined from testing
h0 = 0.6833;
m0 = 0.03877;
n0 = 0.2787;

% Preliminary neuron geometry parameters
% from wikipedia (specify sources later)
rSoma = 8.75e-4;    % soma radius (cm)
r = 0.5e-4;         % axon/dendrite radius (cm)

% determined from geometry
dx = 4.5161e-4;

% cell simulation
surfAreaSoma = 4 * pi * rSoma^2;
surfAreaSection = pi * r^2 * dx;
surfAreaCap = 2 * pi * r^2;
crossArea = pi * r^2;

C_m_s = Cm * surfAreaSoma;
g_Na_s = gNa * surfAreaSoma;
g_K_s = gK * surfAreaSoma;
g_Cl_s = gCl * surfAreaSoma;

C_m_n = Cm * surfAreaSection;
g_Cl_n = gCl * surfAreaSection;

C_m_c = Cm * surfAreaCap;
g_Cl_c = gCl * surfAreaCap;

g_i_n = gCy * crossArea / dx;
g_i_s = (2/3 * gCy * pi * rSoma^2) + g_i_n/2;
g_i_c = g_i_n/2;

section = PassiveSection(C_m_n,g_Cl_n,E_Cl);
soma = FitzHughSection(C_m_s,g_Na_s,g_K_s,g_Cl_s,E_Na,E_K,E_Cl);
eSyn = Synapse(C_m_c,g_Cl_c,E_Cl,E_syn,g_peak,t_peak);
                        
sec = {eSyn, section, section, soma};
weights = horzcat(g_i_c,g_i_n*ones(1,1),g_i_s);
A = diag(weights,1) + diag(weights,-1);
 
cGraph = graph(A);

s0 = vertcat(V0*ones(4,1), n0);

%inputVec = [1;0;0;0];
neuron = FiniteElementNeuron(cGraph,sec,@(t) 0);

[t,s] = ode15s(@neuron.dyn, [0 0.05], s0); 

%plot(t,s)
mesh(1:4,t,s(:,1:4));

function I = istim(t)
    % input current params
    epsilon = 1e-6;
    tstart = 0;
    tstop = 3e-3;
    IAmp = 12e-9;

    if (t >= tstart - epsilon && t < tstart)
        I = (IAmp/epsilon)*t + IAmp - (IAmp*tstart)/epsilon;
    elseif (t >= tstart && t <= tstop)
        I = IAmp;
    elseif (t > tstop && t <= tstop + epsilon)
        I = -(IAmp/epsilon)*t + IAmp + (IAmp*tstop)/epsilon;
    else
        I = 0;
    end
end