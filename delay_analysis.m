close all;

growthdata;

x = [0:24]';

POP = [];

for Ti = [1:8 12]
    
y = eval(strcat('G',num2str(Ti)));

POP = [POP; y(Ti+1,:)]

end

POP = mean(log10(POP),2);

DELAY = [     0.0000    0.0000    0.0000
    0.0000    0.0000    0.0000
    0.0000    0.0000    0.0000
    0.0000    0.0000    0.0000
    0.0000    0.0000    0.0000
    0.0000    0.0000    0.0000
    9.1924    8.1060    7.4651
    9.7514    8.7747    9.0000
   21.3310   24.3228   24.0195];

%DELAY = mean(DELAY,2);
    
 fo = fitoptions('Method','NonlinearLeastSquares','lower',[0,0] ,'StartPoint',[15,7])

 ft = fittype( 'delay_pop(x,a,b)' ,'options',fo)

 f = fit( POP(:,1), mean(DELAY,2), ft)

 errorbar(10.^POP(:,1),mean(DELAY'),std(DELAY'),'.')
 hold on

 func = @(x) max(0,f.a*(log10(x)-f.b))

 ezplot(func,[10^5,10^9])
 
 set(gca,'xscale','log')
 
 xlabel('cell density (CFU/ml)')
 ylabel('delay, d (hr)')

 legend({'data','model'})
 title('')
 grid('on')






