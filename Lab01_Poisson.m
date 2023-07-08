pkg load statistics;
clc;
clear all;
close all;

# A Erwtima

# Απάντηση στην Ερώτηση της Εκφώνησης:
#  Οι χρόνοι που μεσολαβούν ανάμεσα στην εμφάνιση δύο διαδοχικών γεγονότων
# ακολουθούν κατανομή Poisson με ρυθμό λ*ΔΤ.

poisson_events = exprnd(0.2, 1, 100);

x = zeros(100, 1);
y = 0 : 100;

for i = 1 : 100
  x(i+1) = x(i) + poisson_events(i);
endfor


figure(1);
stairs(x, y);


# B Erwtima

display("100: ");
display( 100/x(100) );
display("");

# (i) 200

poisson_events_200 = exprnd(0.2, 1, 200);
x = zeros(200, 1);
y = 0 : 200;

for i = 1 : 200
  x(i+1) = x(i) + poisson_events_200(i);
endfor

figure(2);
stairs(x, y);
display("200: ");
display( 200/x(200) );
display("");

# (ii)  300

poisson_events_300 = exprnd(0.2, 1, 300);
x = zeros(300, 1);
y = 0 : 300;

for i = 1 : 300
  x(i+1) = x(i) + poisson_events_300(i);
endfor

figure(3);
stairs(x, y);
display("300: ");
display( 300/x(300) );
display("");

# (iii) 500
poisson_events_500 = exprnd(0.2, 1, 500);
x = zeros(500, 1);
y = 0 : 500;

for i = 1 : 500
  x(i+1) = x(i) + poisson_events_500(i);
endfor

figure(4);
stairs(x, y);
display("500: ");
display( 500/x(500) );
display("");

# (iv)  1000
poisson_events_1000 = exprnd(0.2, 1, 1000);
x = zeros(1000, 1);
y = 0 : 1000;

for i = 1 : 1000
  x(i+1) = x(i) + poisson_events_1000(i);
endfor

figure(5);
stairs(x, y);
display("1000: ");
display( 1000/x(1000) );
display("");

# (v)   10000
poisson_events_10000 = exprnd(0.2, 1, 10000);
x = zeros(10000, 1);
y = 0 : 10000;

for i = 1 : 10000
  x(i+1) = x(i) + poisson_events_10000(i);
endfor

figure(6);
stairs(x, y);
display("10000: ");
display( 10000/x(10000) );
display("");
