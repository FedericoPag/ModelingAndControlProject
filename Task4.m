clear all
close all
clc

%% Hyperparameters
p = 100;                % #cells
q = 25;                 % #sensors
eps = 1e-8;
delta = 1e-12;
debug = 0;

load("localization.mat")

G = normalize([D eye(q)]);
tau = norm(G)^(-2) - eps;
lambda = [10 20];
Gamma = tau * [lambda(1)*ones(p, 1); lambda(2)*ones(q, 1)];
z = zeros(q+p,1);

%% ISTA
while 1
    z_new = thresholding(z + tau*G'*( y - G*z ) , Gamma);
    norm_difference_squared = norm(z_new - z);
    z = z_new;
    if norm_difference_squared < delta
        break
    end
end

% Zerofying numbers under a threshold (tol)
tol = 4;
necessary = 1;

if necessary == 1
    for i=1:(p+q)
       if abs(z_new(i)) < tol
            z_new(i)=0;
        end
    end
end

%% Sparse observer
load("tracking_moving_targets.mat");
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
