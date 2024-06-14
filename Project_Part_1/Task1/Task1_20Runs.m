%% ----------------------------------------------
%  Task 1: Implementation of ISTA
%  Creators: Federico Paglialunga - s328876
%            Luigi Graziosi - s331564
%            Marco Luppino - s333997
%
%  Last modification date:  26/04/2024
% -----------------------------------------------
%% This file has the function of extract statistics on 20 runs
clear
close all
clc

min = 9999999999;
max = 0;
mean = 0;
same = 0;
diff = 0;

for i=0:19
    run("Task1.m");
    if min>T
        min = T;
    end
    if max<T
        max = T;
    end
    mean = mean + T;

    if length(find(x_tilde)) == length(find(x_new))
        if find(x_tilde) == find(x_new)
            disp("Same support");
            same = same+1;
        else
            disp("Different supports");diff = diff+1;
        end
    else
        disp("Different supports");
        diff = diff+1;
    end
end

mean = mean/20;



% We estimated same support 17 times to 20 with given dimensions
% Increasing q from 1o to p, we corrected estimated all the 20 supports

% Convergence time:
%       MAX:7938
%       MIN:134
%       AVG:1367
%       COUNTER TIMES: 20

% Lower values of tau increase the iterations before reaching the 
% exit condition. Also keeping tau constant and varying lambda we 
% can notice that lower values of lambda require more iterations, 
% while higher values of lambda require less iterations. 
