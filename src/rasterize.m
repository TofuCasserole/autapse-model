function spikes = rasterize(t,v)
%RASTERIZE Summary of this function goes here
%   Detailed explanation goes here
    v_thresh = -20e-3;
    delta_t = 0.01;
    n = 1;
    i = 1;
    spike = false;
    t_last = 0;
    while i <= length(t)
        if spike && v(i) < v_thresh && t(i) >= t_last + delta_t
            spike = false;
            t_last = t(i);
        elseif ~spike && v(i) >= v_thresh && t(i) >= t_last + delta_t
            spike = true;
            spikes(n) = t(i);
            t_last = t(i);
            n = n+1;
        end
        i = i+1;
    end
end

