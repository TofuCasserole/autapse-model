classdef PassiveSection < NeuronSection
    %PASSIVESECTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Constant)
        stateArity = 1
        inputArity = 1
    end
    
    properties
        C_m
        g_Cl
        E_Cl
    end
    
    methods
        function sDot = dyn(s, input)
            sDot = 1/this.C_m * (input - this.g_Cl(s - this.E_Cl));
        end
    end
    
end

