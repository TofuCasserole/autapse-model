function bm = betaM(v)
%BETAM Summary of this function goes here
%   Detailed explanation goes here
    v = vrate(v);
    bm = 4*exp(-v/18);
end

