% MCSB Bootcamp
% VStudent - Project 3.1 Discrete logistic

% simulation parameters
ntMax = 1000;
nParam = 1000;

% model parameters to sweep through
rArray = linspace(0.1,2.99,nParam);

% data collection
xSS = zeros(nParam,300);

% loop through parameters
for iParam=1:nParam
    
    % model parameters
    r = rArray(iParam);
    K = 0.6;
   
    x = zeros(1,ntMax);
    
    % initial condition
    x(1) = 0.5;
    
    % loop through time
    for nt=1:ntMax
        x(nt+1) = x(nt) + r*(1-x(nt)/K)*x(nt);
    end
    
    %% data analysis and collection
    if 0
        figure(1); clf; hold on; box on;
        plot(x(1:100), '-ok');
        xlabel('Time');
        ylabel('Population');
    end % finished plotting time series
    
    
    xSS(iParam,:) = x((end-size(xSS,2)+1):end);
    
end % finished loop through parameters

save('xSS.mat', 'xSS');

%% analysis

load('xSS.mat', 'xSS');

% plot parameter-sweep diagram
figure(2); clf; hold on; box on;
plot(rArray,xSS, '.');
ylabel('Population');
xlabel('Growth rate r')