clear all
close all
clc

%% Hyperparameters
p = 100;                % #cells
q = 25;                 % #sensors
eps = 1e-8;
delta = 1e-12;
debug = 0;

load("localization.mat");

x_tilde = randn(p,1);
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
tol = 0.05;
necessary = 0;

if necessary == 1
    for i=1:(p+q)
       if abs(z(i)) < tol
            z(i)=0;
        end
    end
end


%% Debug

if debug == 1
    z_new
end

x = z_new(1:p);
a = z_new(p+1:p+q);
