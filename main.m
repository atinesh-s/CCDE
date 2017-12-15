clear; clc;
addpath('bf');       

% Minimum allowed fitness
minFit = 1e-12;

% Independent runs
runs = 3;

% cec 2010 functions
func = [1,2,3,4,5,6];

% Dimension
D = 1000;

% Parameters
maxFe = 3e+6;                 % Maximum Fitness Evolution
nPop    = 50;                 % Population Size (Swarm Size)

% Running CCCDE
tic
for fn = 1:length(func)
	file_res    = strcat('res\resccde_', num2str(D), '.txt');
    fileID_res  = fopen(file_res, 'a');
    
    fprintf(fileID_res, 'Func_%d:', fn);
    
    for i=1:runs    
        disp('Running CCDE ...');
        [varMin, varMax] = range(func(fn));
        [bestCC] = ccde(D, maxFe, minFit,  nPop, func(fn), varMin, varMax);
        disp('CCDE Finished ...'); 
       
        fprintf(fileID_res, ' %e', bestCC);
    end
    fprintf(fileID_res, '\n');
    fclose(fileID_res);
end