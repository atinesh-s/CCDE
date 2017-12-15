
function fit = benchmark_func(x, func_num)
  
    % sphere : separable, unimodal
    % rastrigin : separable, multimodal
    % ackley : separable, multimodal
    % schwefel problem 1.2 : non-separable
    % griewank : non-separable, multimodal
    % rosenbrock : non-separable, unimodal
    
    if (func_num ==  1)  
        fhd = str2func('sphere_func');
    elseif (func_num ==  2)
        fhd = str2func('rastrigin_func');
    elseif (func_num ==  3)
        fhd = str2func('ackley_func');
    elseif (func_num ==  4)
        fhd = str2func('schwefel_func');
    elseif (func_num ==  5)
        fhd = str2func('griewank_func');
    elseif (func_num ==  6)
        fhd = str2func('rosenbrock_func');
    end

    fit = feval(fhd, x);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% F1: Sphere Function 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function fit = sphere_func(x)
    fit = sum(x.^2);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% F2: Rastrigin's Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function fit = rastrigin_func(x)
    d = length(x);
    sq = x.^2;   
    fit = 10*d + sum(sq - 10*cos(2*pi*x));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% F3: Ackley's Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function fit = ackley_func(x)    
    d = length(x);
    a = 20;
    b = 0.2;
    c = 2*pi;

    term1 = -a * exp(-b*sqrt(1/d * sum(x.^2)));
    term2 = -exp(1/d * sum(cos(c * x)));

    fit = term1 + term2 + a + exp(1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% F4: Schwefel's Problem 1.2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function fit = schwefel_func(x)
    D = length(x);
    fit = 0;
    for i = 1:D
        fit = fit + sum(x(:,1:i)).^2;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% F5: Griewank's Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function fit = griewank_func(x)
    sum1 = sum(x.^2 / 4000);
    sum2 = 1;
    len = length(x);
    for i = 1:len
        sum2 = sum2 * cos(x(i)/sqrt(i));
    end
    fit = sum1 - sum2 + 1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% F6: Rosenbrock's Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function fit = rosenbrock_func(x)
    fit = sum(100*(x(2:end) - x(1:end-1).^2).^2 + (1-x(1:end-1)).^2);
end