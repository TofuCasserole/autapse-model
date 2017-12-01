function bh = betaH(v)
%BETAH Summary of this function goes here
%   Detailed explanation goes here
    v = vrate(v);
    bh = 1./(exp((30-v)/10)+1);
end

