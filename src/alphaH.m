function ah = alphaH(v)
%ALPHAH Summary of this function goes here
%   Detailed explanation goes here
    v = v*1e3;
    ah = 0.07*exp((v+61.5)/-20);
end
