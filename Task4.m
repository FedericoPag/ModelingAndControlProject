clear all
close all
clc

%% Hyperparameters
p = 100;                % #cells
q = 25;                 % #sensors
eps = 1e-8;
delta = 1e-12;
n_iter = 50;
debug = 0;

% Controls on aware attacks
aware = 0;
change_sensors = 0;

% Loading data
load("tracking_moving_targets.mat");
load("z_new_task_3.mat");

% Variables
G = normalize([D eye(q)]);
tau = norm(G)^(-2) - eps;
lambda = [10 20];
Gamma = tau * [lambda(1)*ones(p, 1); lambda(2)*ones(q, 1)];


%% Aware attack
% ---In this part we define x_true with 3(n_targets) targets and 2 
% (n_attacks) aware attacks on sensors

if aware
    n_targets = 3;
    n_attacks = 2;
    noise = 1e-2*randn(q,1);

    x_true = unif_funct(n_targets,p);
    supp_a_true = randperm(q);
    supp_a_true = supp_a_true(1:n_attacks);
    
    Y_aware = zeros(size(Y));

    for i=1:n_iter
       Y_aware(:,i) = D*x_true+noise;
       Y_aware(:,i) = aware_attack(2, q, Y_aware(:,1), supp_a_true);
       x_true = A*x_true;
       if change_sensors && i==25
           supp_a_true = randperm(q);
           supp_a_true = supp_a_true(1:n_attacks);
       end
    end
end


%% Sparse observer
z_hat = zeros(p+q,1);

Z_matrix = zeros(p+q, n_iter);

for i=1:n_iter
    if aware
        z_plus = thresholding(z_hat+tau*G'*(Y_aware(:,i)-G*z_hat), Gamma);
    else
        z_plus = thresholding(z_hat+tau*G'*(Y(:,i)-G*z_hat), Gamma);
    end
    % Create matrix with max-three values filter for graphical
    % representation
    Z_matrix(:,i) = [
        max_filter(z_hat(1:p),3,1); 
        max_filter(z_hat(p+1:p+q),2,1)
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
