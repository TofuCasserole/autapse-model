% From Yilmaz, Ozer, Baysal, & Perc (2016)
Cm = 1e-6;

E_K = -77e-3;
E_Na = 50e-3;
E_Cl = -54.5e-3;

gCl = 0.3e-3;
gNa = 120e-3;
gK = 36e-3;

E_aut = -2e-3;
k = 8;
theta = 0.25;

% from Foster K.R., Bidinger J.M., & Carpenter D.O. (1976)
gCy = 17.5e-3;

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

sectionArea = 6e-8; % cm^2

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
v0 = -68e-3;
n0 = 0.3430;
m0 = 0.0650;
h0 = 0.4798;
a0 = [v0;h0;m0;n0];

nTau = 4;
nG = 4;
solutions = cell(nTau,nG);
for tindex = 1:nTau
    tau = 4*tindex + 4;
    for gindex = 1:nG
        gAut = (gindex-1)*2e-4;
        g_aut_s = gAut * sectionArea;
        aut = Autapse(C_m_s,g_Na_s,g_K_s,g_Cl_s,E_Na,E_K,E_Cl,g_aut_s,E_aut,k,theta);

        sol = dde23(@(t,s,Z) aut.dyn(t,s,Z,1e-10),tau,@(t) a0,[0 100]);
        plot(sol.x,sol.y(1,:));
        solutions{tindex,gindex} = sol;
    end
end

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
    epsilon = 0.1;
    tstart = 0;
    tstop = 30;
    IAmp = 0.5e-9;

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
