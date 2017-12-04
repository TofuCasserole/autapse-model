% From Yilmaz, Ozer, Baysal, & Perc (2016)
Cm = 1e-6;

E_K = -77e-3;
E_Na = 50e-3;
E_Cl = -54.5e-3;

gCl = 0.3e-3;
gNa = 120e-3;
gK = 36e-3;

% from HW4
gCy = 3.33e-3;

% Preliminary neuron geometry parameters
% from wikipedia (specify sources later)
rSoma = 8.75e-4;    % soma radius (cm)
r = 0.5e-4; % axon/dendrite radius (cm)

% determined from geometry
dx = 4.5161e-4;

% computed parameters
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
g_Na_n = gNa * surfAreaSection;
g_K_n = gNa * surfAreaSection;

C_m_c = Cm * surfAreaCap;
g_Cl_c = gCl * surfAreaCap;
g_Na_c = gNa * surfAreaCap;
g_K_c = gNa * surfAreaCap;

g_i_n = gCy * crossArea / dx;
g_i_s = (2/3 * gCy * pi * rSoma^2) + g_i_n/2;
g_i_c = g_i_n/2;

% Initial values
v0 = -76.6e-3;
n0 = 0.6092;
m0 = 0.01253;
h0 = 0;
a0 = [v0;h0;m0;n0];

% Finite Element Neuron Simulation
dend = PassiveSection(C_m_n,g_Cl_n,v0);
soma = ActiveSection(C_m_s,g_Na_s,g_K_s,g_Cl_s,E_Na,E_K,E_Cl);
axon = ActiveSection(C_m_n,g_Na_n,g_K_n,g_Cl_n,E_Na,E_K,E_Cl);

N_dend = 3;
N_axon = 40;
N = 1 + N_dend + N_axon;

sec = horzcat(constructCellArray(dend,N_dend),...
                 {soma}, constructCellArray(axon,N_axon));
weights = horzcat(g_i_n*ones(1,N_dend-1),...
                     g_i_s*ones(1,2), g_i_n*ones(1,N_axon-1));
A = diag(weights,1) + diag(weights,-1);
s0 = vertcat(nvertcat(v0,N_dend),a0,nvertcat(a0,N_axon));
inputVec = vertcat(1,zeros(N-1,1));
neur = FiniteElementNeuron(graph(A),sec,@(t) istim(t)*inputVec);

[t,s] = ode15s(@(t,s) soma.dyn(t,s,1e-8), [0 0.01], a0);

% v = voltages(s,sec);
% mesh(1:N,t,v);

function v = voltages(s,sec)
    n = length(sec);
    v = zeros(size(s,1),n);
    index = 1;
    for i = 1:n
        v(:,i) = s(:,index);
        index = index + sec{i}.stateArity; 
    end
end

function I = istim(t)
    % input current params
    epsilon = 1e-6;
    tstart = 0;
    tstop = 1e-4;
    IAmp = 1e-7;

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
