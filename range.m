function [lb, ub] = range(func)
    
    if (func == 1 | func == 4 | func == 6)
        lb = -10;
        ub = 10;
    end
    if (func == 2 | func == 3 | func == 5)
        lb = -5;
        ub = 5;
    end
end