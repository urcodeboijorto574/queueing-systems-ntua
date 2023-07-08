% M/M/1 simulation. We will find the probabilities of the first states.
clear all;
close all;
clc;
rand("seed", 1);

for j=1:3
  Probability = [0,0,0,0,0,0,0,0,0,0,0];
  Arrivals = [0,0,0,0,0,0,0,0,0,0,0];
  total_arrivals = 0; % to measure the total number of arrivals
  current_state = 0;  % holds the current state of the system
  mean_clients = 0;
  previous_mean_clients = 0; % will help in the convergence test
  index = 0;
  lambda = [1,5,10]; 
  mu = 5;
  threshold = lambda(j)/(lambda(j)+mu);
  transitions = 0; %holds the transitions of the simulation in transitions steps

  while transitions >= 0 
    ++transitions;% one more transitions step
    if mod(transitions,1000) == 0 %check for convergence every 1000 transitions steps
      ++index;
      % calcuate the probability of every state in the system
      for i=1:1:length(Arrivals)
          Probability(i) = Arrivals(i)/total_arrivals;
      endfor
      mean_clients = 0; %calculate the mean number of clients in the system
      for i=1:1:length(Arrivals)
         mean_clients = mean_clients + (i-1).*Probability(i);
      endfor
      to_plot(index) = mean_clients;
      % convergence test
      if abs(mean_clients - previous_mean_clients) < 0.000001 || transitions > 1000000
        break;
      endif
      previous_mean_clients = mean_clients;
    endif

    random_number = rand(1); % generate a random number (Uniform distribution)
    if (current_state == 0 || random_number < threshold) % arrival
      if current_state < 11
        ++total_arrivals;
        ++Arrivals(current_state + 1);
        if current_state < 10
          ++current_state;
        endif
      endif
    else % departure
      if (current_state != 0) % no departure from an empty system
        --current_state;
      endif
    endif
  endwhile
  printf("For lambda = %d, %d transitions were needed.\n", lambda(j), transitions);
endfor
