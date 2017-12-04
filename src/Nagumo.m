classdef Nagumo < NeuronSection
    %NAGUMO Summary of this class goes here
    %   Detailed explanation goes here
    
    % Single spike threshnold: ~ 0.14375 +/- 25e-5
    % Bursting threshold:      ~ 0.325 +/- 1e-3
    
    properties
        a
        b
        tau
    end
    
    methods
        function obj = Nagumo(a,b,tau)
            obj = obj@NeuronSection(2);
            obj.a = a;
            obj.b = b;
            obj.tau = tau;
        end
        
        function sDot = dyn(this,~,s,input)
            v = s(1);
            w = s(2);
            vDot = v - v^3/3 - w + input;
            wDot = 1/this.tau * (v + this.a - this.b*w);
            sDot = [vDot;wDot];
        end
    end
    
end

