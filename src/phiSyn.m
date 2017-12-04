function phi = phiSyn(v,k,theta)
%GSYN Summary of this function goes here
%   Detailed explanation goes here
    v = v * 1e3;
    phi = 1 / exp(-(k*v + theta));
end

