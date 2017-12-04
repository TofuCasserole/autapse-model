function bh = betaH(v)
%BETAH Summary of this function goes here
%   Detailed explanation goes here
    v = v*1e3;
    bh = 1./(exp((v+31.5)/-10)+1);
end

