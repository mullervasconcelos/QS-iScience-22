clc 
clear all
close all

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
1.44E+09	1.30E+09	1.22E+09];

param_on = [];

global i

for i = 1:3

[arg_star,J_star] = fminsearch('logistic_single_phase_on',[0.65,8]);

x = [0:24]';

param_on = [param_on; arg_star]

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

Noff = N;

plot(x,N)
hold on
plot(x,Gon,'o')
set(gca,'yscale','log')

end

mean(param_on)
std(param_on)

P = anova1(param_on')