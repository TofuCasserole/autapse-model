function an = alphaN(v)
%ALPHAN Summary of this function goes here
%   Detailed explanation goes here
    v = v*1e3;
    an = 0.0075*(v+65)./(1-exp((v+65)/-10));
end

