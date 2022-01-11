close all
clear all

growthdata


RF = zeros(10,3);

RF(1,:) = mean(Gon./Goff);

RF(2,:) = mean(G1./Goff);

RF(3,:) = mean(G2./Goff);

RF(4,:) = mean(G3./Goff);

RF(5,:) = mean(G4./Goff);

RF(6,:) = mean(G5./Goff);

RF(7,:) = mean(G6./Goff);

RF(8,:) = mean(G7./Goff);

RF(9,:) = mean(G8./Goff);

RF(10,:) = mean(G12./Goff);

RF;


%%%%%%%%%

x = [0:24]';

Goff=[4.60E+05	3.60E+05	3.40E+05
6.40E+05	5.20E+05	6.40E+05
3.40E+06	4.00E+06	3.20E+06
5.40E+06	6.60E+06	6.40E+06
8.80E+06	1.00E+07	1.08E+07
2.00E+07	2.20E+07	3.00E+07
4.00E+07	4.00E+07	4.40E+07
7.40E+07	8.00E+07	8.60E+07
1.00E+08	1.80E+08	1.40E+08
2.20E+08	3.00E+08	2.60E+08
4.00E+08	4.40E+08	4.40E+08
4.20E+08	4.00E+08	5.80E+08
4.00E+08	4.80E+08	4.20E+08
3.80E+08	5.40E+08	4.00E+08
3.80E+08	4.80E+08	4.00E+08
5.40E+08	4.00E+08	3.80E+08
4.60E+08	3.20E+08	3.80E+08
3.40E+08	4.80E+08	3.40E+08
4.00E+08	3.80E+08	5.40E+08
4.20E+08	4.00E+08	4.60E+08
3.00E+08	5.60E+08	2.80E+08
5.20E+08	3.40E+08	3.80E+08
4.00E+08	3.60E+08	5.00E+08
5.20E+08	4.00E+08	3.80E+08
3.40E+08	4.20E+08	4.40E+08]/10^8;


kappa1 = 13.6748;  
lambda1 = 0.6307; 
    
kappa0 = 4.1447; 
lambda0 = 1.1512;


kappa = kappa0;
lambda = lambda0;

No = mean(Goff(1,:));

N = [No];

N_now = No;

for k=[1:length(x)-1]
    
    N_next = N_now + lambda*N_now*(1-N_now/kappa);
    
    N = [N; N_next];
    
    N_now = N_next;
    
end

Noff = N*10^8;


%%%%%%%%%

RF_model = zeros(1,10);

%%%%%%

Gon = [
3.60E+05	3.40E+05	3.80E+05
3.00E+05	3.20E+05	3.00E+05
2.00E+06	1.80E+06	2.00E+06
3.20E+06	3.00E+06	3.00E+06
4.00E+06	3.60E+06	3.20E+06
3.80E+06	5.40E+06	4.40E+06
7.20E+06	9.60E+06	6.80E+06
1.04E+07	1.36E+07	1.00E+07
1.60E+07	2.00E+07	1.80E+07
2.80E+07	3.00E+07	3.40E+07
5.60E+07	4.80E+07	4.60E+07
9.00E+07	8.40E+07	8.40E+07
1.26E+08	1.24E+08	1.38E+08
1.60E+08	1.80E+08	1.80E+08
2.60E+08	2.20E+08	2.80E+08
4.80E+08	5.00E+08	4.80E+08
8.60E+08	9.40E+08	8.40E+08
1.08E+09	1.12E+09	1.34E+09
1.24E+09	1.26E+09	1.20E+09
1.02E+09	1.16E+09	1.40E+09
1.34E+09	1.32E+09	1.38E+09
1.28E+09	1.26E+09	1.18E+09
1.50E+09	1.26E+09	1.18E+09
1.28E+09	1.20E+09	1.20E+09
1.44E+09	1.30E+09	1.22E+09]/10^8;

kappa1 = 13.1080;  
lambda1 = 0.6759; 
    
kappa0 = 4.2182; 
lambda0 = 1.1806;


kappa = kappa1;
lambda = lambda1;

No = mean(Gon(1,:));

N = [No];

N_now = No;

for k=[1:length(x)-1]
    
    N_next = N_now + lambda*N_now*(1-N_now/kappa);
    
    N = [N; N_next];
    
    N_now = N_next;
    
end
 
 Non = N*10^8;
 
 
 RF_model(1) = mean(Non./Noff);
 


%%%%%%%%%


D = [0.0000
    0.0000
    0.0000
    0.0000
    0.0000
    0.0000
    8.2545
    9.1754
   23.2244];

No = [0.0042
    0.0050
    0.0057
    0.0069
    0.0075
    0.0054
    0.0048
    0.0042
    0.0038];

Ti = [1:8 12];

for i = [1:9]  
    
x = [0:24]';

y = eval(strcat('G',num2str(Ti(i))))/10^8;

kappa1 = 13.6748;  
lambda1 = 0.6307; 
    
kappa0 = 4.1447; 
lambda0 = 1.1512;

k=0:length(x)-1;

kappa = kappa0 + (kappa1-kappa0)*min(max(0,(k-Ti(i))/D(i)),1);

kappa;

lambda = lambda0 + (lambda1-lambda0)*boolean(k>=Ti(i));

lambda;

N = [No(i)];

N_now = No(i);

for k=[1:length(x)-1]
    
    N_next = N_now + lambda(k)*N_now*(1-N_now/kappa(k));
    
    N = [N; N_next];
    
    N_now = N_next;
    
end

N = N*10^8;

RF_model(i+1) = mean(N./Noff);

end

RF_model';

errorbar([0:8 12],mean(RF'),std(RF'),'ko')

hold on

plot([0:8 12],RF_model,'ro-')

ylabel('Relative Fitness')
xlabel('Induction time (hr)')

legend({'data','model'})


