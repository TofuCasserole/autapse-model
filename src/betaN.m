function bn = betaN(v)
%BETAN Summary of this function goes here
%   Detailed explanation goes here
    v = vrate(v);
    bn = exp(-v/80)/8;
end

