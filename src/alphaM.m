function am = alphaM(v)
%ALPHAM Summary of this function goes here
%   Detailed explanation goes here
    v = vrate(v);
    am = 0.1*(25-v)./(exp((25-v)/10)-1);
end

