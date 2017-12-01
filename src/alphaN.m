function an = alphaN(v)
%ALPHAN Summary of this function goes here
%   Detailed explanation goes here
    v = vrate(v);
    an = 0.01*(10-v)./(exp((10-v)/10)-1); 
end

