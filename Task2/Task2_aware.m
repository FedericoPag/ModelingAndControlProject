close all
clear all
clc

%% Hyperparameters
q =20;
n = 10;
h = 2;
C = randn(q, n);
eps = 1e-8;
tau = norm(C) ^(-2)- eps;
lambda = 2/1000/tau;
delta=1e-12;
gamma = (lambda*ones(1,n))*tau;
nu = 1e-2 * randn(q,1);
debug=0;

%% Definition variables
x_tilde = randn(n,1);

a = unif_funct(h,q);
y = C*x_tilde + nu;
y = aware_attack(h,q,y,0);

x=zeros(n,1);


%% ISTA
T = 0;

while 1
    x_new = thresholding(x + tau*C'*( y - C*x ) , gamma);
    norm_difference_squared = norm(x_new - x);
    x = x_new;
    T = T + 1;
    if norm_difference_squared < delta
        break
    end
end


%%debug
if debug == 1
    x_new'
    x_tilde'
end

diff = norm(x_tilde-x_new)^2;     %Estimation accurancy
