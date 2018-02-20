% From Yilmaz, Ozer, Baysal, & Perc (2016)
Cm = 1e-6;

E_K = -77e-3;
E_Na = 50e-3;
E_Cl = -54.5e-3;

gCl = 0.3e-3;
gNa = 120e-3;
gK = 36e-3;
gAut = 1e-3;

E_aut = -2e-3;
k = 8;
theta = 0.25;

sectionArea = 6e-8; % cm^2

% computed parameters
C_m_s = Cm * sectionArea;
g_Na_s = gNa * sectionArea;
g_K_s = gK * sectionArea;
g_Cl_s = gCl * sectionArea;
g_aut_s = gAut * sectionArea;

% Initial values
v0 = -68e-3;
n0 = 0.3430;
m0 = 0.0650;
h0 = 0.4798;
a0 = [v0;h0;m0;n0];

% simulation length (ms)
t_end = 40;

% Batch processing parameters
tau_init = 6;
tau_step = 0;
tau_n = 1;

I_init = 0.1e-12;
I_step = 0.1e-12;
I_n = 20;

% run simulations in parallel
n_sim = tau_n * I_n;
solutions = cell(n_sim,1);
parfor i = 1:n_sim
    tau_index = mod(i-1,tau_n);
    I_index = floor((i-1)/tau_n);
    
    tau = (tau_index * tau_step) + tau_init;
    I_stim = (I_index * I_step) + I_init;
    aut = Autapse(C_m_s,g_Na_s,g_K_s,g_Cl_s,E_Na,E_K,E_Cl,g_aut_s,E_aut,k,theta);

    sol = dde23(@(t,s,Z) aut.dyn(t,s,Z,I_stim),tau,@(t) a0,[0 tEnd]);
    solutions{i} = sol;
end

solutionGrid = cell(tau_n, I_n);
for i = 1:n_sim    
    tau_index = mod(tau_n-i,tau_n) + 1;
    I_index = ceil((i-1)/tau_n);
    
    solutionGrid{tau_index, I_index} = solutions{i};
end
plotFiringRate(solutionGrid, tau_init, tau_step, I_init, I_step);
filename = "solutions_" + string(tau_init) + "_" + string(tau_n)...
    + "_" + string(I_init) + "_" + string(I_n);
save(filename, 'solutionGrid');