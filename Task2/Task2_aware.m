%% Hyperparameters
q =20;
n = 10;
h = 2;
C = randn(q, n);
eps = 1e-8;
tau = norm(C)^(-2) - eps;
lambda = 2/1000/tau;
delta=1e-12;
gamma = lambda * ones(1,n+q) * tau;
nu = 1e-2 * randn(q,1);
debug=0;

%% Definition variables
x_tilde = randn(n,1);

a = unif_funct(h,q);
supp_a = find(a);

G = normalize([C eye(q)]);

y = C*x_tilde + nu;
y = aware_attack(h,q,y,supp_a);

z_tilde = [x_tilde; a];
z=zeros(n+q,1);

%% ISTA
T = 0;

while 1
    z_new = thresholding(z + tau*G'*(y - G*z) , gamma);
    norm_difference = norm(z_new - z);
    z = z_new;
    T = T + 1;
    if norm_difference < delta
        break
    end
end


%% Debug

x = z_new(1:n);
a_estimated = z_new(n+1:n+q);

if debug == 1
    x'
    x_tilde'
    a'
    a_estimated'
end
