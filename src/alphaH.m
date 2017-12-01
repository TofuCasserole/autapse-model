function ah = alphaH(v)
%ALPHAH Summary of this function goes here
%   Detailed explanation goes here
    v = vrate(v);
    ah = 0.07*exp(-v/20);
end
