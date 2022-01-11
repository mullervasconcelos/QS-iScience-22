function [y] = delay_pop(x,a,b)

y = max(0,a*(x-b))

