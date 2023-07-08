clc;
clear all;
close all;
pkg load queueing;

function res = erlangb_factorial(r,c)
  s = 0;
  for k = 0:1:c
    s += (power(r,k)/factorial(k));
  endfor
  res = (power(r,c)/factorial(c))/s;
end

function res = erlangb_iterative (r,c)
  res = 1;
  for i = 0:1:c
    res = ((r*res)/((r*res)+i));
  endfor
end

printf("erlangb_factorial(13,13) = %d\n", erlangb_factorial(13,13));
printf("erlangb(13,13)           = %d\n", erlangb(13,13));
printf("erlangb_iterative(13,13) = %d\n", erlangb_iterative(13,13));

printf("erlangb_factorial(1024,1024) = %d\n", erlangb_factorial(1024,1024));
printf("erlangb_iterative(1024,1024) = %d\n", erlangb_iterative(1024,1024));

P = zeros(0,200);

for i = 1:1:200
  P(i) = erlangb_iterative (i * (23/60),i);
endfor

figure(1);
stem(P, 'r', "linewidth", 0.4);
title("Blocking Probabilities");
xlabel("Servers");
ylabel("Blocking Probability");
