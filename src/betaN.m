function bn = betaN(v)
%BETAN Summary of this function goes here
%   Detailed explanation goes here
    v = v*1e3;
    bn = exp((v+65)/-80)/8;
end

