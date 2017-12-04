function am = alphaM(v)
%ALPHAM Summary of this function goes here
%   Detailed explanation goes here
    v = v*1e3;
    am = 0.1*(v+40)./(1-exp((v+40)/-10));
end

