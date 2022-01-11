clear all
close all
clc

x = [0:24]';

%%%%%% ON %%%%%%

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

kappa1 = 13.6748;  
lambda1 = 0.6307; 
    
kappa0 = 4.1447; 
lambda0 = 1.1512;

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

 semilogy(x,N*10^8,'b')

 hold on

 errorbar(x,mean(Gon')*10^8,std(Gon')*10^8,'b.')
 
 
%%%%%%%%%


D = [0.0133
    0.0006
    0.0532
    0.0024
    0.0080
    0.0067
    7.3460
    9.2600
   22.1565];

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

l = 0;

for i = [3 5 8 9]  
    
l = l + 1; 
    
color = ['g' 'k' 'm' 'c'];

growthdata;

x = [0:24]';

y = eval(strcat('G',num2str(Ti(i))))/10^8;

kappa1 = 13.1080;  
lambda1 = 0.6759; 
    
kappa0 = 4.2182; 
lambda0 = 1.1806;


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

 semilogy(x,N*10^8,color(l))
 
 hold on

 errorbar(x,mean(y')*10^8,std(y')*10^8,strcat(color(l),'.'))

end


%%%%%% OFF %%%%%%%%%%

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


kappa1 = 13.1080;  
lambda1 = 0.6759; 
    
kappa0 = 4.2182; 
lambda0 = 1.1806;


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

 semilogy(x,N*10^8,'r')

 hold on

 errorbar(x,mean(Goff')*10^8,std(Goff')*10^8,'r.')
 
legend({'0h Induction (model)' '0h Induction (data)' '3h Induction (model)' '3h Induction (data)' '5h Induction (model)' '5h Induction (data)' '8h Induction (model)' '8h Induction (data)' '12h Induction (model)' '12h Induction (data)' 'No Induction (model)' 'No Induction (data)'})

xlabel('time (hr)')
ylabel('cell density (CFU/ml)')