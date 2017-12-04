function bm = betaM(v)
%BETAM Summary of this function goes here
%   Detailed explanation goes here
    v = v*1e3;
    bm = 4*exp((v+63)/-18);
end

