clc 
clear all
close all

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
3.40E+08	4.20E+08	4.40E+08];


param_off = [];

global i

for i = 1:3

[arg_star,J_star] = fminsearch('logistic_single_phase_off',[0.65,1.3]);

x = [0:24]';

param_off = [param_off; arg_star]

lambda=arg_star(1);
kappa=arg_star(2);

No=mean(Goff(1,:))/10^8;

N = [No*10^8];

N_now = No*10^8;

for k=[1:length(x)-1]
    
    N_next = N_now + lambda*N_now*(1-N_now/(kappa*10^8));
    
    N = [N; N_next];
    
    N_now = N_next;
    
end

Noff = N;

plot(x,N)
hold on
plot(x,Goff,'o')
set(gca,'yscale','log')

end

mean(param_off)
std(param_off)

P = anova1(param_off')