classdef Synapse < NeuronSection
    %SYNAPSE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        C_m
        g_Cl
        E_Cl
        E_syn
        g_peak
        t_peak
    end
    
    methods
        function obj = Synapse(C_m,g_Cl,E_Cl,E_syn,g_peak,t_peak)
            obj = obj@NeuronSection(1);
            obj.C_m = C_m;
            obj.g_Cl = g_Cl;
            obj.E_Cl = E_Cl;
            obj.E_syn = E_syn;
            obj.g_peak = g_peak;
            obj.t_peak = t_peak;
        end
        
        function sDot = dyn(this,t,s,i)
            sDot = 1/this.C_m * (i - gSyn(t,this.g_peak,this.t_peak)*...
                                    (s-this.E_syn)...
                                    - this.g_Cl*(s-this.E_Cl));
        end
        
        
    end
    
end

