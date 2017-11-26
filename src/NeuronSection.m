classdef (Abstract) NeuronSection < handle
    %NEURONSECTION Abstract class describing a section of neuron
    %   stateArity the number of dimensions of the state parameter
    %   inputArity the number of dimensions of the input parameter
    %   sDot = dyn(s,input) computes the time derivative of s given an
    %   input
    
    properties
        stateArity
        inputArity
    end
    
    methods
        dyn(s,input)
    end
    
end

