clear all
close all
clc

global Ti y No

D_matrix = [];

INIT_POP_matrix = [];

d = zeros(3,1);

for Ti = [1:8 12]
    
    for i = 1:3
        
        growthdata;
        
        x = [0:24]';
        
        y = eval(strcat('G',num2str(Ti)))/10^8;
        
        No = mean(y(1,:));
        
        y = y(:,i);
        
        gs = GlobalSearch;
        
        problem = createOptimProblem('fmincon','x0',[7],'objective','logistic_bi_phase','lb',[0],'ub',[30]);
        
        [arg_star] = run(gs,problem);
        
        No = mean(y(1,:));
        
        D = arg_star(1);
        
        kappa1 = 13.1080;
        lambda1 = 0.6759;
        
        kappa0 = 4.2182;
        lambda0 = 1.1806;
        
        k=0:length(x)-1;
        
        kappa = kappa0 + (kappa1-kappa0)*min(max(0,(k-Ti)/D),1);
        
        kappa;
        
        lambda = lambda0 + (lambda1-lambda0)*boolean(k>=Ti);
        
        lambda;
        
        N = [No];
        
        N_now = No;
        
        for k=[1:length(x)-1]
            
            N_next = N_now + lambda(k)*N_now*(1-N_now/kappa(k));
            
            N = [N; N_next];
            
            N_now = N_next;
            
        end
        
        semilogy(x,N)
        
        hold on
        
        semilogy(x,y,'o')
        
        d(i) = D;
        
    end
    
    D_matrix = [D_matrix; d']
    
end

mean(D_matrix,2)