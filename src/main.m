C=1;
gl=0.08;
ga=1;

a = 0.7;
b = 0.8;
tau = 12.5;

v0 = -1.1994;
w0 = -0.6242600441;

n0 = [v0;w0];

dE = 0.5;
gpeak = 1;
tpeak = 50;

eSyn = Synapse(C,gl,v0,v0+dE,gpeak,tpeak);
section = PassiveSection(C,gl,v0);
nagumo = Nagumo(a,b,tau);

N = 40;
sec = constructCellArray(nagumo,N);
%A = zeros(N);
A = diag(ga*ones(N-1,1),1) + diag(ga*ones(N-1,1),-1);

s0 = nvertcat(n0,N);

inputVec = vertcat(1,zeros(N-1,1));
neur = FiniteElementNeuron(graph(A), sec, @(t) inputVec*istim(t));

[t,s] = ode15s(@neur.dyn,[0 200],s0);

v = voltages(s,sec);

%plot(t,s(:,1))
mesh(1:40,t,v);

function v = voltages(s,sec)
    n = length(sec);
    v = zeros(size(s,1),n);
    index = 1;
    for i = 1:n
        v(:,i) = s(:,index);
        index = index + sec(i).stateArity; 
    end
end

function I = istim(t)
    % input current params
    epsilon = 10;
    tstart = 0;
    tstop = 107.5;
    IAmp = 2;

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
