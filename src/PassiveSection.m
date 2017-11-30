classdef PassiveSection < NeuronSection
    %PASSIVESECTION Describes a section of passive cable
    %   C_m membrane capacitance
    %   g_Cl chloride channel conductance
    %   E_Cl nernst potential of chloride
    
    properties
        C_m
        g_Cl
        E_Cl
    end
    
    methods
        function obj = PassiveSection(C_m, g_Cl, E_Cl)
            obj = obj@NeuronSection(1,1);
            
            obj.C_m = C_m;
            obj.g_Cl = g_Cl;
            obj.E_Cl = E_Cl;
        end
        
        function sDot = dyn(this, s, input)
            sDot = 1/this.C_m * (input - this.g_Cl*(s - this.E_Cl));
        end
    end
    
end

