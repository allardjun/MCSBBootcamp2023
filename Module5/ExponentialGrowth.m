% Exponential Growth
% UCI COSMOS 2022:  Tissue and Tumor Modeling (Cluster 3)

clear

%% User-defined inputs

TimeStep = 0.01;        % Time step (baseline = 0.01)
InitialPopulation = 3;  % Initial condition (baseline = 3)
lambdam = 0.5;          % Growth rate (baseline = 0.5)
endTime = 10;           % End time of simulation (baseline = 10)

%% Begin simulation

% Program execution parameters
dT = TimeStep;
tsteps = ceil(endTime/dT) + 1;    % Number of time steps required

% Pre-allocate vectors for faster runtime
Time = zeros(1,tsteps);
N = zeros(1,tsteps);

% Set initial time and initial population
Time(1) = 0;                % Set initial time to zero
N(1) = InitialPopulation;   % Set initial population

% Euler Method
for n = 2:tsteps
    Time(n) = (n-1)*dT;                 % Compute the current time
    N(n) = N(n-1) + dT*lambdam*N(n-1);  % Compute the population size
end

%% Plotting
ExactPopulation = InitialPopulation*exp(lambdam*Time);

figure,plot(Time,N,Time,ExactPopulation,'LineWidth',2)
xlabel('Time','FontWeight','bold')
ylabel('Population','FontWeight','bold')
grid on
legend('Numerical solution','Exact solution','Location','NorthWest')
title('Exponential Growth','FontSize',12,'FontWeight','bold')
set(gca,'FontWeight','bold')
