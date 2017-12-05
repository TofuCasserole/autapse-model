classdef FitzHugh < NeuronSection
    %FITZHUGHSECTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        C_m
        g_Na
        g_K
        g_Cl
        E_Na
        E_K
        E_Cl
    end
    
    methods
        function obj = FitzHugh(C_m, g_Na, g_K, g_Cl,...
                                            E_Na, E_K, E_Cl)
            obj = obj@NeuronSection(2);
            
            obj.C_m = C_m;
            obj.g_Na = g_Na;
            obj.g_K = g_K;
            obj.g_Cl = g_Cl;
            obj.E_Na = E_Na;
            obj.E_K = E_K;
            obj.E_Cl = E_Cl;
        end
        
        function sDot = dyn(this, ~, s, ~, input)
            V = s(1);
            n = s(2);
            
            m = alphaM(V) / (alphaM(V) + betaM(V));
            h = (0.87-n);

            vDot = 1/this.C_m *... 
                        (input - this.g_Na*m^3*h*(V-this.E_Na) ...
                                - this.g_K*n^4*(V-this.E_K)...
                                - this.g_Cl*(V-this.E_Cl));
            nDot = alphaN(V)*(1-n) - betaN(V)*n;
            sDot = [vDot; nDot];
        end
    end
    
end

