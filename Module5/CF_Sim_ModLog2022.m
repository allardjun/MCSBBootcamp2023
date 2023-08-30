function [h,N,Time] = CF_Sim_ModLog2022(rate,K,initial,alpha,t)
% Curve Fitting - Modified Logistic Growth
% UCI COSMOS 2022:  Tissue and Tumor Modeling (Cluster 3)

%% User-defined inputs

TimeStep = 0.001;               % Time step (baseline = 0.001)
InitialPopulation = initial;    % Initial condition (baseline = 200)
lambdam = rate;                 % Growth rate (baseline = 1)
theta = K;                      % Carrying capacity (baseline = 1000)
% alpha = alpha;                % Exponent (baseline = 2)
endTime = t(end);               % End time of simulation (baseline = 10)

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

%% Spline
pp=spline(Time,N);
h=ppval(pp,t);
