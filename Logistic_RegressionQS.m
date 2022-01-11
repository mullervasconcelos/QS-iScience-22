clc 
clear all
close all

G_QS = [9.60E+05	7.40E+05	8.00E+05
1.18E+06	9.40E+05	9.60E+05
6.20E+06	6.80E+06	6.60E+06
1.10E+07	8.60E+06	9.20E+06
2.60E+07	2.40E+07	2.20E+07
5.00E+07	3.80E+07	5.40E+07
9.00E+07	8.00E+07	9.40E+07
1.66E+08	1.74E+08	1.62E+08
2.40E+08	2.80E+08	3.20E+08
3.80E+08	4.20E+08	4.60E+08
4.60E+08	5.40E+08	5.60E+08
6.20E+08	5.80E+08	6.60E+08
7.00E+08	6.40E+08	6.20E+08
7.80E+08	7.40E+08	6.60E+08
7.00E+08	8.00E+08	7.40E+08
8.20E+08	9.00E+08	8.00E+08
7.20E+08	8.60E+08	8.40E+08
6.80E+08	8.20E+08	7.40E+08
8.40E+08	8.80E+08	8.60E+08];

param = [];

global i

for i = 1:3

[arg_star,J_star] = fminsearch('Logistic_Single_PhaseQS',[0.65,1.3]);

x = [0:18]';

param = [param; arg_star]

lambda=arg_star(1);
kappa=arg_star(2);

No=mean(G_QS(1,:))/10^8;

N = [No*10^8];

N_now = No*10^8;

for k=[1:length(x)-1]
    
    N_next = N_now + lambda*N_now*(1-N_now/(kappa*10^8));
    
    N = [N; N_next];
    
    N_now = N_next;
    
end

plot(x,N)
hold on
plot(x,G_QS,'o')
set(gca,'yscale','log')

end

mean(param)
std(param)

P = anova1(param')
