function C = constructInputMatrix(A)
%CONSTRUCTINPUTMATRIX creates a matrix mapping voltages to neuron inputs
    
    connGraph = graph(A);
    inputWeights = arrayfun(@(k) sumInputWeights(connGraph,k),...
                                    1:height(connGraph.Nodes));
    C = A - diag(inputWeights);
end

function gSum = sumInputWeights(G, k)
    gSum = 0;
    for i = 1:height(G.Nodes)
        e = findedge(G,i,k);
        if (e ~= 0)
            gSum = gSum + G.Edges.Weight(e);
        end
    end
end