classdef Autapse < NeuronSection
    %AUTAPSE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        C_m
        g_Na
        g_K
        g_Cl
        E_Na
        E_K
        E_Cl
        g_aut
        E_aut
        k
        theta
    end
    
    methods
        function obj = Autapse(C_m, g_Na, g_K, g_Cl, E_Na, E_K, E_Cl,...
                                    g_aut, E_aut, k, theta)
            obj = obj@NeuronSection(4);
            
            obj.C_m = C_m;
            obj.g_Na = g_Na;
            obj.g_K = g_K;
            obj.g_Cl = g_Cl;
            obj.E_Na = E_Na;
            obj.E_K = E_K;
            obj.E_Cl = E_Cl;
            obj.g_aut = g_aut;
            obj.E_aut = E_aut;
            obj.k = k;
            obj.theta = theta;
        end
        
        function sDot = dyn(this, ~, s, del, input)
            V = s(1);
            h = s(2);
            m = s(3);
            n = s(4);

            vDot = 1/this.C_m *...
                        (input - this.g_aut*this.scaleAut(del(1))*(V-this.E_aut)...
                                - this.g_Na*m^3*h*(V-this.E_Na)...
                                - this.g_K*n^4*(V-this.E_K)...
                                - this.g_Cl*(V-this.E_Cl));
            hDot = (alphaH(V)*(1-h) - betaH(V)*h);
            mDot = (alphaM(V)*(1-m) - betaM(V)*m);
            nDot = (alphaN(V)*(1-n) - betaN(V)*n);
            sDot = [vDot; hDot; mDot; nDot];
        end
        
        function s = scaleAut(this, v)
            s = 1/exp(-(this.k*v + this.theta));
        end
    end
    
end

