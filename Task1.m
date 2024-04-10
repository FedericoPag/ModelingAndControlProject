clear all
close all
clc

%% Hyperparameters
q = 10;
p = 20;
C = randn(q, p);
eps = 1e-8;
tau = norm(C) ^(-2)- eps;
k = 5;
lambda = 1/(100*tau);
gamma = (lambda*ones(1,p))*tau;
nu = 1e-2 * randn(q,1);
debug = 0;

% Definition of variables
% S = unifrnd(1,2,k,1);
% x_tilde = [S; zeros(p-k , 1)];
x_tilde= unif_funct(k,p);

x=zeros(p,1);
delta=1e-12;
y = C * x_tilde + nu;

%% ISTA
T = 0;          % Counter

while 1
    x_new= thresholding(x + tau*C'*( y - C*x ) , gamma);
    norm_difference_squared = norm(x_new - x);
    x = x_new;
    T = T + 1;
    if norm_difference_squared < delta
        break

    end
end

%% Debug
if debug == 1
    x_new'
    x_tilde'
end