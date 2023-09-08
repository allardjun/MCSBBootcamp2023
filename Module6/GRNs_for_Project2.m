%% Parameter sweeps across an input for various gene regulatory network motifs
% Jun Allard allardlab.com


%% 3.1 ----- (DIRECT) NEGATIVE FEEDBACK -----

paramArray = 0:0.01:2;

p_storage = zeros(size(paramArray));

for iParam = 1:numel(paramArray)

    delta_ma = 0.05;
    gamma_pa = 0.02;
    delta_pa = 0.01;
    
    Kaa = 0.1; % Strength of inhibition of A by A 
    gamma_ma0 = 5; % Baseline production rate mRNA for A
    
    input = paramArray(iParam);
    
    gamma_ma =@(pa) gamma_ma0./(1+Kaa*pa).*(1+input);

    dmadt =@(ma,pa,mb,pb,t) +gamma_ma(pa) - delta_ma*ma;
    dpadt =@(ma,pa,mb,pb,t) +gamma_pa*ma - delta_pa*pa;

    dxdt = @(t,x)[dmadt(x(1),x(2),t);
                  dpadt(x(1),x(2),t)];

    initialCondition = [0,0];

    [T, X] = ode45(dxdt, [0.0,600], initialCondition);


    % finished running this simulation 
    % now store steady-state protein level

    p_storage(iParam) = X(end,end);
end

figure(31); clf; hold on; box on;

ylabel('Protein')
xlabel('Concentration of activating TF (uM)')
plot(paramArray,p_storage,'+b')

%% 4.1 ----- INDIRECT NEGATIVE FEEDBACK -----

paramArray = 0:0.01:2;

p_storage = zeros(size(paramArray));

for iParam = 1:numel(paramArray)
    
    input = paramArray(iParam);

    delta_ma = 0.08;
    gamma_pa = 1;
    delta_pa = 1;

    delta_mb = 1e-4;
    gamma_pb = 1;
    delta_pb = 1;

    params{2}.title = 'Feedback';
    params{2}.Kba   = 1.0;
    params{2}.Kab   = 1e4;
    params{2}.tMax  = 400;
    
    % an input signal, e.g., externally-induced production
    i =@(t) input;

    Kba = params{2}.Kba; % Strength (IC50^-1) of inhibition of A by B 
    gamma_ma =@(pb,t) 1./(1+Kba*pb).*(1.0+i(t));

    Kab = params{2}.Kab; % Strength (EC50^-1) of activation of B by A 
    gamma_mb =@(pa) 1e-3.*(1+Kab*pa);

    dmadt =@(ma,pa,mb,pb,t) +gamma_ma(pb,t) - delta_ma*ma;
    dpadt =@(ma,pa,mb,pb,t) +gamma_pa*ma - delta_pa*pa;

    dmbdt =@(ma,pa,mb,pb,t) +gamma_mb(pa) - delta_mb*mb;
    dpbdt =@(ma,pa,mb,pb,t) +gamma_pb*mb - delta_pb*pb;

    dxdt = @(t,x)[dmadt(x(1),x(2),x(3),x(4),t);
                  dpadt(x(1),x(2),x(3),x(4),t);
                  dmbdt(x(1),x(2),x(3),x(4),t);
                  dpbdt(x(1),x(2),x(3),x(4),t)];

    initialCondition = [20,20,0,0];
    tMax = params{2}.tMax;

    [T, X] = ode45(dxdt, [-10000.0,tMax], initialCondition);

    % finished running this simulation 
    % now store steady-state protein level

    p_storage(iParam) = X(end,2);

end

figure(41); clf; hold on; box on;

ylabel('Protein')
xlabel('Concentration of activating TF (uM)')
plot(paramArray,p_storage,'+b')

%% 5.0 ----- DOUBLE NEGATIVE FEEDBACK -----

paramArray = 0:0.01:2;

p_storage = zeros(size(paramArray));

for iParam = 1:numel(paramArray)

    input = paramArray(iParam);

    noisiness = 0;
    
    delta_ma = 1*(1+noisiness*rand());
    gamma_pa = 1*(1+noisiness*rand());
    delta_pa = 1*(1+noisiness*rand());
    
    delta_mb = 1*(1+noisiness*randn());
    gamma_pb = 1*(1+noisiness*rand());
    delta_pb = 1*(1+noisiness*rand());
    
    Kba = 1*(1+noisiness*randn()); % Strength (IC50^-1) of inhibition of A by B
    Kaa = 0;
    gamma_ma =@(pb) 3./(1+abs(Kba*pb).^3).*(1.0+input);
    
    Kab = 1*(1+noisiness*randn()); % Strength (IC50) of inhibition of B by A
    Kbb = 0;
    gamma_mb =@(pa) 3./(1+abs(Kab*pa).^3);
    
    dmadt =@(ma,pa,mb,pb,t) +gamma_ma(pb) - delta_ma*ma;
    dpadt =@(ma,pa,mb,pb,t) +gamma_pa*ma - delta_pa*pa;
    
    dmbdt =@(ma,pa,mb,pb,t) +gamma_mb(pa) - delta_mb*mb;
    dpbdt =@(ma,pa,mb,pb,t) +gamma_pb*mb - delta_pb*pb;

    dxdt = @(t,x)[dmadt(x(1),x(2),x(3),x(4),t);
                  dpadt(x(1),x(2),x(3),x(4),t);
                  dmbdt(x(1),x(2),x(3),x(4),t);
                  dpbdt(x(1),x(2),x(3),x(4),t)];

     initialCondition = [0,0,1,1];
                  
     [T, X] = ode45(dxdt, [0.0,60], initialCondition);

    % finished running this simulation 
    % now store steady-state protein level

    p_storage(iParam) = X(end,2);

end

figure(51); clf; hold on; box on;

ylabel('Protein')
xlabel('Concentration of activating TF (uM)')
plot(paramArray,p_storage,'+b')

%% 6.0 ----- INCOHERENT FEED FORWARD -----

paramArray = 0:0.01:2;

p_storage = zeros(size(paramArray));

for iParam = 1:numel(paramArray)

    input = paramArray(iParam);
    
    delta_ma = 0.05;
    gamma_pa = 0.1;
    delta_pa = 0.02;
    
    delta_mb = 0.05;
    gamma_pb = 0.1;
    delta_pb = 0.02;
    
    delta_mc = 0.05;
    gamma_pc = 0.1;
    delta_pc = 0.02;
    
    gamma_ma = 10;
    
    Kab = 10; % Strength (EC50) of activation of  by B
    gamma_mb =@(pa) 10.*(1+(Kab*pa));
    
    Kac = 10;
    Kbc = 10; % Strength (IC50) of inhibition of B by A
    gamma_mc =@(pa,pb) 10.*(1+(Kac*pa))./(1+Kbc*pb);
    
    dmadt =@(ma,pa,mb,pb,mc,pc,t) +gamma_ma.*(1.0+input) - delta_ma*ma;
    dpadt =@(ma,pa,mb,pb,mc,pc,t) +gamma_pa*ma - delta_pa*pa;
    
    dmbdt =@(ma,pa,mb,pb,mc,pc,t) +gamma_mb(pa) - delta_mb*mb;
    dpbdt =@(ma,pa,mb,pb,mc,pc,t) +gamma_pb*mb - delta_pb*pb;
    
    dmcdt =@(ma,pa,mb,pb,mc,pc,t) +gamma_mc(pa,pb) - delta_mc*mc;
    dpcdt =@(ma,pa,mb,pb,mc,pc,t) +gamma_pc*mc - delta_pc*pc;


    dxdt = @(t,x)[dmadt(x(1),x(2),x(3),x(4),x(5),x(6),t);
                  dpadt(x(1),x(2),x(3),x(4),x(5),x(6),t);
                  dmbdt(x(1),x(2),x(3),x(4),x(5),x(6),t);
                  dpbdt(x(1),x(2),x(3),x(4),x(5),x(6),t);
                  dmcdt(x(1),x(2),x(3),x(4),x(5),x(6),t);
                  dpcdt(x(1),x(2),x(3),x(4),x(5),x(6),t)];

    initialCondition = [0,0,0,0,0,0];
          
    [T, X] = ode45(dxdt, [0.0,400], initialCondition);

    % finished running this simulation 
    % now store steady-state protein level

    p_storage(iParam) = X(end,end);

end

figure(61); clf; hold on; box on;

ylabel('Protein')
xlabel('Concentration of activating TF (uM)')
plot(paramArray,p_storage,'+b')

%% 7.0 ----- REPRESSILATOR -----

paramArray = 0:0.05:2; % use fewer sampled values just because this simulation is a bit slower than others.

p_storage = zeros(size(paramArray));

for iParam = 1:numel(paramArray)

    input = paramArray(iParam);

    delta_ma = 100*0.05;
    gamma_pa = 100*0.1;
    delta_pa = 100*0.02;

    delta_mb = 0.05;
    gamma_pb = 0.1;
    delta_pb = 0.02;

    delta_mc = 0.05;
    gamma_pc = 0.1;
    delta_pc = 0.02;

    Kca = 100; % Strength (IC50) of inhibition of  by B 
    gamma_ma =@(pc) 10./(1+(Kca*pc)).*(1.0+input);

    Kab = 100; % Strength (IC50) of inhibition of B by A 
    gamma_mb =@(pa) 10./(1+(Kab*pa));

    Kbc = 100; % Strength (IC50) of inhibition of B by A 
    gamma_mc =@(pb) 10./(1+(Kbc*pb));

    dmadt =@(ma,pa,mb,pb,mc,pc,t) +gamma_ma(pc) - delta_ma*ma;
    dpadt =@(ma,pa,mb,pb,mc,pc,t) +gamma_pa*ma - delta_pa*pa;

    dmbdt =@(ma,pa,mb,pb,mc,pc,t) +gamma_mb(pa) - delta_mb*mb;
    dpbdt =@(ma,pa,mb,pb,mc,pc,t) +gamma_pb*mb - delta_pb*pb;

    dmcdt =@(ma,pa,mb,pb,mc,pc,t) +gamma_mc(pb) - delta_mc*mc;
    dpcdt =@(ma,pa,mb,pb,mc,pc,t) +gamma_pc*mc - delta_pc*pc;


    dxdt = @(t,x)[dmadt(x(1),x(2),x(3),x(4),x(5),x(6),t);
                  dpadt(x(1),x(2),x(3),x(4),x(5),x(6),t);
                  dmbdt(x(1),x(2),x(3),x(4),x(5),x(6),t);
                  dpbdt(x(1),x(2),x(3),x(4),x(5),x(6),t);
                  dmcdt(x(1),x(2),x(3),x(4),x(5),x(6),t);
                  dpcdt(x(1),x(2),x(3),x(4),x(5),x(6),t)];

    initialCondition = [0,0,0,0,0,0];

    [T, X] = ode45(dxdt, [0,1e4], initialCondition);

    % finished running this simulation 
    % now store steady-state protein level

    p_storage(iParam) = X(end,2);

end

figure(71); clf; hold on; box on;

ylabel('Protein')
xlabel('Concentration of activating TF (uM)')
plot(paramArray,p_storage,'+b')

