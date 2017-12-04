function an = alphaN(v)
%ALPHAN Summary of this function goes here
%   Detailed explanation goes here
    v = v*1e3;
    an = 0.01*(v+55)./(1-exp((v+55)/-10));
end

