classdef ActiveSection < NeuronSection
    %ACTIVESECTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Constant)
        stateArity = 4
        inputArity = 1
    end
    
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
        function sDot = dyn(s,input)
            V = s(1);
            h = s(2);
            m = s(3);
            n = s(4);

            vDot = 1/this.C_m *... 
                        (input - this.g_Na*m^3*h*(V-this.E_Na) ...
                                - this.g_K*n^4*(V-this.E_K)...
                                - this.g_Cl(V-this.E_Cl));
            hDot = alphaH(V)*(1-h) - betaH(V)*h;
            mDot = alphaM(V)*(1-m) - betaM(V)*m;
            nDot = alphaN(V)*(1-n) - betaN(V)*n;
            sDot = [vDot, hDot, mDot, nDot];
        end
    end
        
end

function alpha_h = alphaH(V)
    alpha_h = 0.07 * exp(-(V+71e-3) / 20);
end

function alpha_m = alphaM(V)
    alpha_m = 0.1 * (51e-3+V)/(1 - exp(-(51e-3+V)/10));
end

function alpha_n = alphaN(V)
    alpha_n = 0.01 * (V+61e-3)/(1-exp(-(V+61e-3)/10));
end

function beta_h = betaH(V)
    beta_h = 1 / (exp(-(41e-3+V)/10) + 1);
end

function beta_m = betaM(V)
    beta_m = 4 * exp(-(V+71e-3)/18);
end

function beta_n = betaN(V)
    beta_n = exp(-(V+71e-3)/80) / 8;
end
