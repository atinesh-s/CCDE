function [bestC, subpop] = de(nVar, subpop, nPop, CostFunction, VarMin, VarMax, MaxIt)
    %% DE Parameters
    % Global Variables
    global dimIndex;
    global curBest;
    global sp;

    VarSize  = [1 nVar]; % Decision Variables Matrix Size

    beta_min = 0.2;      % Lower Bound of Scaling Factor
    beta_max = 0.8;      % Upper Bound of Scaling Factor

    pCR      = 0.2;      % Crossover Probability
    
    BestCost = zeros(1, MaxIt);
    %% DE Main Loop

    for it = 1:MaxIt
        BestSol.Cost = inf;
        for i = 1:nPop

            x = subpop(i).Position;

            A = randperm(nPop);

            a = A(1);
            b = A(2);
            c = A(3);

            % Mutation
            % beta = unifrnd(beta_min, beta_max);
            beta = unifrnd(beta_min,beta_max,VarSize);
            y    = subpop(a).Position + beta.*(subpop(b).Position - subpop(c).Position);
            y    = max(y, VarMin);
            y    = min(y, VarMax);

            % Crossover
            z = zeros(size(x));
            j0 = randi([1 numel(x)]);
            for j = 1:numel(x)
                if j == j0 || rand <= pCR
                    z(j) = y(j);
                else
                    z(j) = x(j);
                end
            end

            NewSol.Position = z;
            
            % collaboration for fitness evaluation
            evalPos = curBest.Position;
            evalPos(dimIndex(sp) : (dimIndex(sp+1) - 1)) = NewSol.Position;
            NewSol.Cost     = benchmark_func(evalPos, CostFunction);

            if NewSol.Cost < subpop(i).Cost
                subpop(i).Position = NewSol.Position;
                subpop(i).Cost = NewSol.Cost;
            end
            
            if NewSol.Cost < benchmark_func(curBest.Position, CostFunction)
                curBest.Position = evalPos;
            end
              
            if NewSol.Cost < BestSol.Cost
                BestSol.Cost = NewSol.Cost;
            end

        end

        % Update Best Cost
        BestCost(it) = BestSol.Cost;
     
    end

    bestC = BestCost(it);
    
end
