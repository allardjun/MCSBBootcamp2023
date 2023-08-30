% Modified Logistic Growth
% UCI COSMOS 2022:  Tissue and Tumor Modeling (Cluster 3)

clear

%% User-defined inputs

TimeStep = 0.001;           % Time step (baseline = 0.001)
InitialPopulation = 200;    % Initial condition (baseline = 200)
lambdam = 1;                % Growth rate (baseline = 1)
theta = 1000;               % Carrying capacity (baseline = 1000)
alpha = 2;                  % Exponent (baseline = 2)
endTime = 10;               % End time of simulation (baseline = 10)

% Note: If alpha is 1, this becomes the orginal Logistic Growth model.

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
    Time(n) = (n-1)*dT;     

    %% Simplified Modified Logistic Growth
        N(n) = N(n-1) + dT*( lambdam*N(n-1)*(1-(N(n-1)/theta)^alpha) );    
end

%% Plotting
    %% Exact Solution to the simplified MLG
       ExactPopulation = theta*((N(1)^alpha)./(N(1)^alpha + (theta^alpha-N(1)^alpha)*exp(-alpha*lambdam*Time))).^(1/alpha);

figure,plot(Time,N,Time,ExactPopulation,'LineWidth',2)
xlabel('Time','FontWeight','bold')
ylabel('Population','FontWeight','bold')
grid on
legend('Numerical solution','Exact solution')
title('Modified Logistic Growth','FontSize',12,'FontWeight','bold')
set(gca,'FontWeight','bold')
