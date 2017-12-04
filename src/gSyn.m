function g = gSyn(t,g_peak,t_peak)
%GSYN Summary of this function goes here
%   Detailed explanation goes here
    g = g_peak * t * exp(1-t/t_peak)...
            / t_peak;
end

