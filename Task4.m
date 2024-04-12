clear all
close all
clc

%% Hyperparameters
p = 100;                % #cells
q = 25;                 % #sensors
eps = 1e-8;
delta = 1e-12;
debug = 0;

load("tracking_moving_targets.mat");
load("z_new_task_3.mat");

G = normalize([D eye(q)]);
tau = norm(G)^(-2) - eps;
lambda = [10 20];
Gamma = tau * [lambda(1)*ones(p, 1); lambda(2)*ones(q, 1)];


%% Sparse observer
z_hat = zeros(p+q,1);
n_iter = 50;

Z_matrix = zeros(p+q, n_iter);

for i=1:n_iter
    z_plus = thresholding(z_hat+tau*G'*(Y(:,i)-G*z_hat), Gamma);
    z_hat = [A*z_plus(1:p); z_plus(p+1:p+q)];
    Z_matrix(:,i) = [
        max_filter(A*z_plus(1:p),3); 
        max_filter(z_plus(p+1:p+q),2)
        ];
end


%% Debug
x_hat = z_hat(1:p);
a_hat = z_hat(p+1:p+q);

if debug == 1
    Z_matrix
end

plot_field(p, 10, 10, Z_matrix, n_iter);
