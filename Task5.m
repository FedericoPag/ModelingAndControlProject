clear all
close all
clc

%% Hyperparameters
load("distributed_localization_data.mat");

p = 100;                % #cells
q = 25;                 % #sensors
eps = 1e-8;
delta = 1e-8;
debug = 0;
n_targets = 2;

% Variables
G = [D eye(25)];
tau = 4e-7;
lambda = [10 0.1];
Gamma = tau*[lambda(1)*ones(p,1); lambda(2)*ones(q,1)];

tol = 0.002;

%% DIST Algorithm
% Q = Q_4;
% Q = Q_8;
% Q = Q_12;
Q = Q_18;
z = zeros(p+q, q);
z_new = z;
T = 0;

while 1
    T = T+1;
    norm_condition = 0;
    for i=1:q
        val = 0;
        for j=1:q
            val = val + Q(i,j)*z(:,j);
        end
        z_new(:,i) = thresholding(val + tau*G(i,:)'*(y(i)-G(i,:)*z(:,i)), Gamma);
        norm_condition = norm_condition + norm(z_new(:,i)-z(:,i))^2;
    end
    
    if norm_condition < delta
        break;
    end

    z = z_new;
end

% Cleaning values
necessary = 1;

if necessary == 1
    for i=1:q
        for j=1:q
            if abs(z_new(p+i,j)) < tol
                z_new(p+i,j) = 0;
            end
        end
    end
    for i=1:q
        z_new(1:p,i) = max_filter(z_new(1:p,i),n_targets,1);
    end
end


%% Debug

x = z_new(1:p,:);
a = z_new(p+1:p+q,:);

if debug == 1
    x
    a
    T
end
