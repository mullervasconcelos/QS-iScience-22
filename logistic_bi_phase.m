function [J] = logistic_bi_phase(arg)

global Ti y No

kappa1 = 13.1080;  
lambda1 = 0.6759; 
    
kappa0 = 4.2182; 
lambda0 = 1.1806;
    
x = [0:24]';

D=arg(1);

k=0:length(x)-1;

kappa = kappa0 + (kappa1-kappa0)*min(max(0,(k-Ti)/D),1);

lambda = lambda0 + (lambda1-lambda0)*boolean(k>=Ti);

N = [No];

N_now = No;

for k=[1:length(x)-1]
    
    N_next = N_now + lambda(k)*N_now*(1-N_now/kappa(k));
    
    N = [N; N_next];
    
    N_now = N_next;
    
end

N

J = sum((y-N).^2)+0.01*D;