% MCSB Bootcamp
% VStudent - Project X Saturated futile cycle

% Goldbeter & Koshland 1981
% https://en.wikipedia.org/wiki/Ultrasensitivity#Saturation_mechanisms_(Zero-order_ultrasensitivity)

% simulation parameters
nParam = 100;

% model parameters to sweep through
KTotArray = 10.^linspace(-3,2,nParam); % KTot = 100;

% data collection
A_SS = zeros(nParam,1);

% loop through parameters
for iParam=1:nParam
    
    % model parameters to sweep through
    KTot = KTotArray(iParam);
    
    % model parameters
    ITot = 1;
    
    PTot = 1;
    
    konA = 10;
    koffA = 10;
    kcatI = 10;
    
    konI = 10;
    koffI = 10;
    kcatA = 100;
        
    % model equations
    dAdt  =@(A,AP,I,IK) -konA*(PTot-AP)*A + koffA*AP + kcatA*IK ;
    dAPdt =@(A,AP,I,IK) +konA*(PTot-AP)*A - koffA*AP - kcatI*AP ;
    dIdt  =@(A,AP,I,IK) -konI*(KTot-IK)*I + koffI*IK + kcatI*AP ;
    dIKdt =@(A,AP,I,IK) +konI*(KTot-IK)*I - koffI*IK - kcatA*IK ;
    
    dxdt =@(t,x) [ dAdt(x(1),x(2),x(3),x(4));
                   dAPdt(x(1),x(2),x(3),x(4));
                   dIdt(x(1),x(2),x(3),x(4));
                   dIKdt(x(1),x(2),x(3),x(4))];
        
    % solve system
    [T,X] = ode45(dxdt,[0,100],[0,0,ITot,0]);
    
    if (0)
        %% plot and analyze
        
        figure(1); clf; hold on; box on;
        plot(T,X)
        
        legend('A', 'AP', 'I', 'IK')
        
        % fraction active
        
        figure(2); clf; hold on; box on;
        fracA = X(:,1)./sum(X,2);
        
        plot(T,fracA);
    end
    
    % data collection
    A_SS(iParam) = X(end,1);
    
end

%% analysis

figure(1); clf; hold on; box on;
plot(KTotArray,A_SS, '-x');
xlabel('Kinase concentration KTot');
ylabel('Steady state in active form A')
set(gca,'xscale', 'log')