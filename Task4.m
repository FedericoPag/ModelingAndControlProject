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
    
    % Create matrix with max-three values filter for graphical
    % representation
    Z_matrix(:,i) = [
        max_filter(z_hat(1:p),3); 
        max_filter(z_hat(p+1:p+q),2)
        ];

    % Update of x_hat and a_hat
    z_hat = [A*z_plus(1:p); z_plus(p+1:p+q)];
end


%% Debug
x_hat = Z_matrix(1:p, n_iter);
a_hat = Z_matrix(p+1:p+q, n_iter);

if debug == 1
    Z_matrix
    x_hat'
    a_hat'
end

% Plot position matrix 
plot_field(p, q, 10, 10, Z_matrix, n_iter, find(z_new(1:100,1)));

% Note: it converges at time 24
