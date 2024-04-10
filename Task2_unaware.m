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
nu = 1e-2 * randn(q,1);
debug = 0;

%% Definition of variables
x_tilde = randn(n,1);
a = unif_funct(h,q);

G = [C eye(q)];
z_tilde = [x_tilde; a];

y = G *z_tilde + nu;
z = zeros(n+q,1);
delta=1e-12;

Gamma = [zeros(n,1); ones(q,1)];

%% ISTA
T = 0;      % Counter

while 1
    z_new= thresholding(z + tau*G'*( y - G*z ) , Gamma);
    norm_difference_squared = norm(z_new - z);
    z = z_new;
    T = T + 1;
    if norm_difference_squared < delta
        break
    end
end


%% Observations
if debug == 1
    z_tilde'
    z_new'
end

diff = norm(z_tilde-z_new)^2;        %Estimation accurancy
