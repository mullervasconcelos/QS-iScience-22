clc 
clear all
close all

Gon = [5.80E+05	6.00E+05	8.60E+05
7.60E+05	1.00E+06	9.60E+05
4.20E+06	2.80E+06	3.40E+06
6.40E+06	5.20E+06	7.40E+06
1.80E+07	1.80E+07	1.60E+07
2.40E+07	3.20E+07	2.60E+07
4.00E+07	4.80E+07	3.40E+07
6.20E+07	7.40E+07	7.00E+07
1.10E+08	1.18E+08	1.26E+08
1.64E+08	1.78E+08	1.86E+08
2.20E+08	2.60E+08	2.00E+08
3.40E+08	3.00E+08	2.80E+08
4.80E+08	4.80E+08	5.20E+08
7.20E+08	6.40E+08	6.40E+08
6.40E+08	6.60E+08	7.40E+08
8.80E+08	6.20E+08	7.20E+08
7.00E+08	8.00E+08	8.60E+08
7.20E+08	8.80E+08	9.20E+08
7.80E+08	8.60E+08	8.80E+08];

param = [];

global i

for i = 1:3

[arg_star,J_star] = fminsearch('Logistic_Single_Phase1',[0.65,1.3]);

x = [0:18]';

param = [param; arg_star]

lambda=arg_star(1);
kappa=arg_star(2);

No=mean(Gon(1,:))/10^8;

N = [No*10^8];

N_now = No*10^8;

for k=[1:length(x)-1]
    
    N_next = N_now + lambda*N_now*(1-N_now/(kappa*10^8));
    
    N = [N; N_next];
    
    N_now = N_next;
    
end

plot(x,N)
hold on
plot(x,Gon,'o')
set(gca,'yscale','log')

end


mean(param)
std(param)

P = anova1(param')