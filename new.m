% Erwtima 2iii
%l=10
clc;
clear all;
close all;

rand("seed",1);

P = [0,0,0,0,0,0,0,0,0,0,0];
arrivals = [0,0,0,0,0,0,0,0,0,0,0];
total_arrivals = 0; % to measure the total number of arrivals
current_state = 0;  % holds the current state of the system
previous_mean_clients = 0; % will help in the convergence test
index = 0;

lambda = 10; 
mu = 5;
threshold = lambda/(lambda + mu); % the threshold used to calculate probabilities

transitions = 0; % holds the transitions of the simulation in transitions steps

while transitions >= 0
  transitions = transitions + 1; % one more transitions step
  
  if mod(transitions,1000) == 0 % check for convergence every 1000 transitions steps
    index = index + 1;
    for i=1:1:length(arrivals)
        P(i) = arrivals(i)/total_arrivals; % calcuate the probability of every state in the system
    endfor
    
    mean_clients = 0; % calculate the mean number of clients in the system
    for i=1:1:length(arrivals)
       mean_clients = mean_clients + (i-1).*P(i);
    endfor
    
    to_plot(index) = mean_clients;
        
    if abs(mean_clients - previous_mean_clients) < 0.00001 || transitions > 1000000 % convergence test
      break;
    endif
    
    previous_mean_clients = mean_clients;
    
  endif
  
  random_number = rand(1); % generate a random number (Uniform distribution)
  if current_state == 0 || random_number < threshold % arrival
    if current_state < 11
      total_arrivals = total_arrivals + 1;
      arrivals(current_state + 1) = arrivals(current_state + 1) + 1; % increase the number of arrivals in the current state
      if current_state < 10
        current_state = current_state + 1;
      endif    
    endif   
  else % departure
    if current_state != 0 % no departure from an empty system
      current_state = current_state - 1;
    endif
  endif
endwhile



display("State propabilities:");
for i=1:1:length(arrivals)
  display(P(i));
endfor

g = lambda*(1-P(11));
average_delay_time = mean_clients / g;
display("Average delay time =");
disp(average_delay_time);
display("Blocking propability =");
disp(P(11));

figure(1);
plot(to_plot,"r","linewidth",1.3);
title("Average number of clients in the M/M/1 queue: Convergence, l=10");
xlabel("transitions in thousands");
ylabel("Average number of clients");

x=[0,1,2,3,4,5,6,7,8,9,10];
figure(2);
bar(x,P,0.4);
title("Probabilities, l=10")
display(transitions);