function [timer_overhead, cost_in_flops] = costOfClockCall(nrepetitions,n)
% See: http://www.cs.indiana.edu/classes/p573/notes/time/3resol.html

% Block 1
y = zeros(1,n);
x = ones(1,n);
alpha = rand();

tic;
for i = 1:nrepetitions
    y = y + alpha * x;
end
t1 = toc;
gflops_per_sec = 2e-9 * n * nrepetitions / t1;

% Block 2
y = zeros(1,n);
x = ones(1,n);
alpha = rand();

tic;
for i = 1:nrepetitions
    time = toc; %#ok
    y = y + alpha * x;
end
t2 = toc;

timer_overhead = (t2 - t1) / nrepetitions;
cost_in_flops  = 1e9 * gflops_per_sec * timer_overhead;