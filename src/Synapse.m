classdef Synapse < NeuronSection
    %SYNAPSE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        C_m
        g_Cl
        E_Cl
        E_syn
        g_syn
        k
        theta
    end
    
    methods
        function obj = Synapse(C_m,g_Cl,E_Cl,E_syn,g_syn,k,theta)
            obj = obj@NeuronSection(1);
            obj.C_m = C_m;
            obj.g_Cl = g_Cl;
            obj.E_Cl = E_Cl;
            obj.E_syn = E_syn;
            obj.g_syn = g_syn;
            obj.k = k;
            obj.theta = theta;
        end
        
        function sDot = dyn(this,~,s,input)
            v_syn = input(1);
            I_ext = input(2);
            sDot = 1/this.C_m * (I_ext - this.g_syn*phiSyn(v_syn,this.k,this.theta)...
                                    * (s-this.E_syn) - this.g_Cl*(s-this.E_Cl));
        end
    end
    
end

