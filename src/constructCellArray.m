function arr = constructCellArray(obj,n)
%CONSTRUCTCELLARRAY Summary of this function goes here
%   Detailed explanation goes here

    arr = {};
    for i = 1:n
        arr = horzcat(obj,arr);
    end

end

