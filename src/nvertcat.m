function a = nvertcat(x,n)
%NCAT Summary of this function goes here
%   Detailed explanation goes here
    a = [];
    for i = 1:n
        a = vertcat(x,a);
    end
end

