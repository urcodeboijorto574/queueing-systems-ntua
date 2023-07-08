% M/M/1 simulation. We will find the probabilities of the first states.
clear all;
close all;
clc;

lambda = 5; 
mu = 5;

Probability = [0,0,0,0,0,0,0,0,0,0,0];
Arrivals = [0,0,0,0,0,0,0,0,0,0,0];
total_arrivals = 0; % to measure the total number of arrivals
current_state = 0;  % holds the current state of the system
previous_mean_clients = 0; % will help in the convergence test
index = 0;

threshold = lambda/(lambda + mu); % the threshold used to calculate probabilities
transitions = 0; % holds the transitions of the simulation in transitions steps

while transitions >= 0 
  ++transitions;% one more transitions step

  % check for convergence every 1000 transitions steps
  if mod(transitions,1000) == 0
    ++index;
    for i=1:1:length(Arrivals)
      % calcuate the probability of every state in the system
      Probability(i) = Arrivals(i)/total_arrivals;
    endfor

    % calculate the mean number of clients in the system
    mean_clients = 0;
    for i=1:1:length(Arrivals)
       mean_clients += (i-1).*Probability(i);
    endfor

    to_plot(index) = mean_clients;

    % convergence test
    if abs(mean_clients-previous_mean_clients)<0.000001 || transitions>1000000
      break;
    endif
    previous_mean_clients = mean_clients;
  endif

  random_number = rand(1); % generate a random number (Uniform distribution)
  if current_state == 0 || random_number < threshold % arrival
    if current_state < 11
      ++total_arrivals;
      # The code in the next 5 lines is for debugging.
      if transitions < 31
        printf("Current state: %d\n", current_state);
        display("Next transition is an arrival.");
        printf("Total arrivals in current state = %d\n", Arrivals(current_state + 1));
      endif
      ++Arrivals(current_state + 1);
      if current_state < 10
        ++current_state;
      endif
    endif
  else % departure
    if current_state != 0 % no departure from an empty system
      # The code in the next 5 lines is for debugging.
      if transitions < 31
        printf("Current state: %d\n", current_state);
        display("Next transition is a departure.");
        printf("Total arrivals in current state = %d\n", Arrivals(current_state + 1));
      endif
      --current_state;
    endif
  endif
endwhile

printf("State probabilities:\n");
for i=1:1:length(Arrivals)
  printf("%d: %d\n", i-1, Probability(i));
endfor

gamma = lambda * (1 - Probability(11));
average_delay_time = mean_clients / gamma;
printf("Average delay time = %d\n", average_delay_time);
printf("Blocking probability = %d\n", Probability(11));

figure(1);
plot(to_plot,"r","linewidth",1.3);
title("Average number of clients in the M/M/1 queue: Convergence");
xlabel("Transitions in thousands");
ylabel("Average number of clients");

array=[0,1,2,3,4,5,6,7,8,9,10];
figure(2);
bar(array,Probability,0.4);
title("Probabilities")
