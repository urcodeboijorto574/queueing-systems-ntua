pkg load statistics;
clear all;
close all;
clc;

# A Erwtima :
k = 0:0.0001:8;
lambda = [2, 1, 1/3];

for i = 1 : columns(lambda)
  exponential_pdf(i, :) = exppdf(k, lambda(i));
endfor

colors = "rbk";
figure(1);
hold on;
for i = 1 : columns(lambda)
  plot(k, exponential_pdf(i, :), colors(i), "linewidth", 1.2);
endfor
hold off;

title("Probability Density Function of Exponential processes");
xlabel("k Values");
ylabel("Probability");
legend("lambda=0.5", "lambda=1", "lambda=3");

# B Erwtima
for i = 1 : columns(lambda)
  exponential_cdf(i, :) = expcdf(k, lambda(i));
endfor

colors = "rbk";
figure(2);
hold on;
for i = 1 : columns(lambda)
  plot(k, exponential_cdf(i, :), colors(i), "linewidth", 1.2);
endfor
hold off;

title("Cumulative Distribution Function of Exponential processes");
xlabel("k Values");
ylabel("Cumulative Probability");
legend("lambda=0.5", "lambda=1", "lambda=3");


# C Erwtima

k1 = 0:0.00001:8;
Exp = expcdf(k1, 2.5);

Pr_a = 1 - Exp(30000);

display("Probability of X < 30000: ");
display(Pr_a * 1);
display("");

Pr_b = 1 - Exp(50000);
Pr_c = 1 - Exp(20000);

display("Probability X < 50000 | X < 20000: ");
display(Pr_b ./ Pr_c);
