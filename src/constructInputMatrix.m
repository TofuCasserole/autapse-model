function C = constructInputMatrix(connGraph)
%CONSTRUCTINPUTMATRIX creates a matrix mapping voltages to neuron inputs
    
    inputWeights = arrayfun(@(k) sumInputWeights(connGraph,k),...
                                    1:height(connGraph.Nodes));
    C = A + diag(inputWeights);
end

function gSum = sumInputWeights(connGraph, k)
    gSum = 0;
    for i = 1:height(connGraph.Nodes)
        gSum = gSum + findedge(connGraph,i,k);
    end
end