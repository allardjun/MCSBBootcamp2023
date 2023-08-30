% Curve Fitting - Modified Logistic Growth
% UCI COSMOS 2022:  Tissue and Tumor Modeling (Cluster 3)

% clear all

% For the user to run this curve-fitting routine, the workspace must
% contain the vectors Time and Population. These vectors can be either data
% loaded from GroupX_ModifiedLogisticData.mat from week 1, or experiemental
% data manually entered with the appropriate names.

%% User-defined inputs

% Initial guess in the order of:
% [lambdam; theta; InitialPopulation; alpha]
% Note: Order here is important.
initialguess = [1; 1; 1; 1];

%% Begin Curve Fit

FinalTime = Time(end);

% Transpose population vector and time vectors if they are rows
if size(Population,1) == 1
    Population = Population';
end
if size(Time,1) == 1
    Time = Time';
end

% Find parameter values minimizing error.
min = fminsearch(@CF_Error_ModLog2022,initialguess,[],Time,Population);

lambdam = min(1)            % Growth rate
theta = min(2)              % Carrying Capacity
InitialPopulation = min(3)  % Initial Population
alpha = min(4)              % Exponent

[h,N,times] = CF_Sim_ModLog2022(lambdam,theta,InitialPopulation,alpha,Time);

%% Plotting

figure,plot(Time,Population,'o',times,N,'r')
xlabel('Time','FontWeight','bold')
ylabel('Population','FontWeight','bold')
grid on
title('Modified Logistic Growth Curve Fit','FontSize',12,'FontWeight','bold')
set(gca,'FontWeight','bold')
legend('Data','Curve fit')
