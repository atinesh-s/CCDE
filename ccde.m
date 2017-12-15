function [bestCC] = ccde(D, maxFe, minFit, nPop, f, varMin, varMax)
    global dimIndex;
    global curBest;
    global sp;
    
    dim(1:D)  = 1;    % Dimension broken down
    maxIt     = 100;  % Maximum iterations for subpopulation
    % Helps in creating the subpopulation
    dimIndex = zeros(1, length(dim)); 
    dimIndex(1) = 1;
    for i=2:(length(dim)+1)
        dimIndex(i) = dimIndex(i-1) + dim(i-1);
    end

    empty_individual2.Position = [];
    empty_individual2.Cost = [];
    pop = repmat(empty_individual2, nPop, 1);

    curBest.Position = (varMin + (varMax + varMax)*rand(D, 1))';

    % Intializing Population
    for i = 1:nPop
        % Generate a 100-by-1 row vector of uniformly distributed numbers in the 
        % interval [-5 5]
        pop(i).Position = (varMin + (varMax + varMax)*rand(D, 1))';
        pop(i).Cost = benchmark_func(pop(i).Position, f);
        if (pop(i).Cost < benchmark_func(curBest.Position, f))
            curBest.Position = pop(i).Position;
        end
    end
    
    BestCost = [];
    
    %% Each dimension is evolved separately for certain FE's
    fe = 2*nPop;
    flag = 0;
    while ( fe < maxFe)

        for sp = 1:length(dim)

            % Intializing Sub-Population
            empty_individual.Position = [];
            empty_individual.Cost = [];
            subpop = repmat(empty_individual, nPop, 1);

            for i = 1:nPop
                subpop(i).Position = pop(i).Position( dimIndex(sp) : (dimIndex(sp+1) - 1) );
                % collaboration for fitness evaluation
                evalPos = curBest.Position;
                evalPos(dimIndex(sp) : (dimIndex(sp+1) - 1)) = subpop(i).Position;
                subpop(i).Cost = benchmark_func(evalPos, f);
            end    
            
            [best, nsubpop] = de(dim(sp), subpop, nPop, f, varMin, varMax, maxIt);
            
            BestCost = [BestCost best];
            
            if (BestCost(end) < minFit)
                flag = 1;
                break;
            end
            
            % updating pop with new subpop
            for i = 1:nPop
                pop(i).Position( dimIndex(sp) : (dimIndex(sp+1) - 1) ) = nsubpop(i).Position;
            end

        end
        
        fe = fe + (length(dim) * (nPop + maxIt*nPop));
        
        if (flag == 1)
            break;
        end

    end
    
    bestCC = BestCost(end);

end