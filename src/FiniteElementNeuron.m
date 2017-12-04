classdef FiniteElementNeuron
    %FINITEELEMENTNEURON Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        N           % Number of sections
        stateArity  % Number of states
        sec         % Cell array of neuron sections
        cGraph      % connectivity graph
        A_in        % input transformation matrix
        f_in
    end
    
    methods
        function obj = FiniteElementNeuron(cGraph,sec,f_in)
            obj.cGraph = cGraph;
            obj.sec = sec;
            obj.N = length(sec);
            obj.f_in = f_in;
            
            obj.stateArity = 0;
            for i = 1:obj.N
                obj.stateArity = obj.stateArity + sec{i}.stateArity;
            end
            
            % construct input matrix
            for i = 1:obj.N
                rowvec = [];
                for j = 1:obj.N
                    vp = zeros(1,sec{j}.stateArity);
                    if i == j
                        vp(1) = -sumInputWeights(cGraph,i);
                    else
                        vp(1) = weight(cGraph,i,j);
                    end
                    rowvec = horzcat(rowvec,vp);
                end
                obj.A_in = vertcat(obj.A_in, rowvec);
            end
        end
        
        function sDot = dyn(this, t, s)
            input = (this.A_in * s) + this.f_in(t);
            sDot = zeros(this.stateArity,1);
            iState = 1;
            i = 1;
            while i <= this.N
                ns = this.sec{i}.stateArity;
                sDot(iState:iState + ns - 1) = ...
                        this.sec{i}.dyn(t, s(iState:iState + ns - 1),...
                                            input(i));
                i = i + 1;
                iState = iState + ns;
            end
        end
    end
end

function gSum = sumInputWeights(G, k)
    gSum = 0;
    for i = 1:height(G.Nodes)
        gSum = gSum + weight(G,i,k);
    end
end

function w = weight(G, s, t)
    e = findedge(G,s,t);
    if (e ~= 0)
        w = G.Edges.Weight(e);
    else
        w = 0;
    end
end

