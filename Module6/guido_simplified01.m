

%% Binding and unbinding of a TF to a promotor -- 1.1 Simple simulation

% parameters
kon = 0.01; % attachment rate, s^-1 uM^-1
koff = 0.005; %s^-1

C = 1.0; % microMolar, concentration of transcription factor

% set up a figure
figure(11); clf; hold on; box on;
xlabel('Time (seconds)')
ylabel('Number of promotors in each state')

% initial conditions
u_bound = 0;
u_unbound = 100; % the total number of times this promotor occurs in the system

dt = 1; % second EVERY SECOND, update the number of bound and unbound promotors
ntmax = 1000;
for nt=1:ntmax
    
    u_bound   = u_bound   + (+ kon*C*u_unbound - koff*u_bound)*dt;
    u_unbound = u_unbound + (- kon*C*u_unbound + koff*u_bound)*dt;
    
    plot(nt, u_bound, '+g')
    plot(nt, u_unbound, 'or')
    
end


%% 1.2 Matlab's built-in solver

% Now let's use Matlab's built-in ODE solver (which is faster and more accurate, but less flexible)

% parameters
kon = 0.01;
koff = 0.005; %s^-1

C = 1.0; % microMolar, concentration of transcription factor

initialCondition = [0,100];

% set up a figure
figure(12); clf; hold on; box on;
xlabel('Time (seconds)')
ylabel('Number of promotors in each state')

f =@(u,w) +kon*C*w - koff*u;
g =@(u,w) -kon*C*w + koff*u;

dxdt = @(t,x)[f(x(1),x(2));
    g(x(1),x(2))];

[T, X] = ode45(dxdt, [0.0,1000], initialCondition);

figure(12); hold on;
plot(T,X(:,1),'-g'); % red for RNA
plot(T,X(:,2),'-r'); % purple

%% 1.3 Parameter sweep

paramArray = 0:0.01:10;
b_storage = zeros(size(paramArray));

for iParam=1:numel(paramArray)

    % parameters
    kon = 0.01;
    koff = 0.005; %s^-1

    C = paramArray(iParam); % microMolar, concentration of transcription factor

    initialCondition = [0,100];


    f =@(u,w) +kon*C*w - koff*u;
    g =@(u,w) -kon*C*w + koff*u;

    dxdt = @(t,x)[f(x(1),x(2));
        g(x(1),x(2))];

    [T, X] = ode45(dxdt, [0.0,1000], initialCondition);

    b_storage(iParam) = X(end,1);
    
end

figure(13); clf;
plot(paramArray,b_storage, '-b')
xlabel('Concentration of transcription factor (uM)')
ylabel('Number of bound promotors')

%set(gca, 'xscale', 'log')

%% 1.4 Creation and destruction of mRNA and protein

% protein level

gamma_m = 1;
delta_m = 0.05;
gamma_g = 0.02;
delta_g = 0.01;

f =@(m,g) +gamma_m   - delta_m*m;
g =@(m,g) +gamma_g*m - delta_g*g;

initialCondition = [0,0];

dxdt = @(t,x)[f(x(1),x(2));
    g(x(1),x(2))];

[T, X] = ode45(dxdt, [0.0,1000], initialCondition);

figure(14); clf; hold on; box on;
plot(T,X(:,1),'-r'); % red for RNA
plot(T,X(:,2),'-', 'color', [0.5 0 1]); % purple
xlabel('Time (seconds)')
ylabel('Concentration of RNA (red) and product (purple)')


%% 1.5 promotor binding state

% parameters

delta_m = 0.05;
gamma_g = 0.02;
delta_g = 0.01;

kon = 0.001; % s^-1 uM^-1
koff = 0.0005; % s^-1

gamma_m =@(p0,pr,pa,par) 1.0*p0+0.0*pr+2.0*pa+1.0*par;

I = 10; % concentration of inhibitory transcription factor (uM)
C = 10; % concentration of activatory transcription factor (uM)

M =@(t) [-kon*C-kon*I,  +koff*I,          koff     ,        0;
               +kon*I,  -koff*I-kon*C,             0,   +koff;
               +kon*C      ,              0,   -koff-kon*I,   +koff;
                    0,          kon*C,         kon*I, -2*koff];


f =@(p0,pr,pa,par,m,g,t) +gamma_m(p0,pr,pa,par)   - delta_m*m;
g =@(p0,pr,pa,par,m,g,t) +gamma_g*m - delta_g*g;

initialCondition = [1,0,0,0,0,0];

dxdt = @(t,x)[M(t)*[x(1);x(2);x(3);x(4)];
    f(x(1),x(2),x(3),x(4),x(5),x(6));
    g(x(1),x(2),x(3),x(4),x(5),x(6))];

[T, X] = ode45(dxdt, [0.0,1000], initialCondition);

figure(15); clf; 

subplot(2,1,1);hold on; box on;
plot(T,X(:,1:4))
xlabel('Time (seconds)')
ylabel('Number of promotors in each state')

subplot(2,1,2);hold on; box on;
plot(T,X(:,5),'-r'); % red for RNA
plot(T,X(:,6),'-', 'color', [0.5 0 1]); % purple
xlabel('Time (seconds)')
ylabel('Concentration of RNA (red) and product (purple)')



%% 1.6 a parameter sweep

paramArray = 0:1:100;
g_storage = zeros(size(paramArray));

for iParam=1:numel(paramArray)
    
    % parameters
    delta_m = 0.05;
    gamma_g = 0.02;
    delta_g = 0.01;
    
    kon = 0.001; % s^-1 uM^-1
    koff = 0.0005; % s^-1
    
    I = 10; 
    C = paramArray(iParam); 
    
    
    M =@(t) [-kon*C-kon*I,  +koff*I,          koff     ,        0;
        +kon*I,  -koff*I-kon*C,             0,   +koff;
        +kon*C      ,              0,   -koff-kon*I,   +koff;
        0,          kon*C,         kon*I, -2*koff];
    
    gamma_m =@(p0,pr,pa,par) 1.0*p0+0.0*pr+2.0*pa+1.0*par;
    
    f =@(p0,pr,pa,par,m,g,t) +gamma_m(p0,pr,pa,par)   - delta_m*m;
    g =@(p0,pr,pa,par,m,g,t) +gamma_g*m - delta_g*g;
    
    initialCondition = [1,0,0,0,0,0];
    
    dxdt = @(t,x)[M(t)*[x(1);x(2);x(3);x(4)];
        f(x(1),x(2),x(3),x(4),x(5),x(6));
        g(x(1),x(2),x(3),x(4),x(5),x(6))];
    
    [T, X] = ode45(dxdt, [0.0,100], initialCondition);
    
    g_storage(iParam) = X(end,6);
    
end

figure(16); clf;
plot(paramArray,g_storage, '-b')
xlabel('Concentration of activating TF (uM)') 
ylabel('Concentration of product (uM)')
set(gca,'ylim', [0,40]);

%% 1.7 positive feedback

paramArray = 0:1:100;
g_storage = zeros(size(paramArray));

for iParam=1:numel(paramArray)
    
    % parameters
    delta_m = 0.05;
    gamma_g = 0.02;
    delta_g = 0.01;
    
    gamma_g2 = 0.1;
    
    kon = 0.001; % s^-1 uM^-1
    koff = 0.0005; % s^-1
    
    I = 10; % EDIT FOR HW1
    C = paramArray(iParam); % ENDOGENOUS activatory transcription factor % EDIT FOR HW1
    
    M =@(C2,t) [-kon*(C+C2)-kon*I,  +koff*I,          koff     ,        0;
                +kon*I,             -koff*I-kon*(C+C2),             0,   +koff;
                +kon*(C+C2)      ,              0,   -koff-kon*I,   +koff;
                        0,          kon*(C+C2),         kon*I, -2*koff];
    
    gamma_m =@(p0,pr,pa,par) 1.0*p0+0.0*pr+2.0*pa+1.0*par;
    
    f =@(p0,pr,pa,par,m,g,m2,C2) +gamma_m(p0,pr,pa,par)   - delta_m*m;
    g =@(p0,pr,pa,par,m,g,m2,C2) +gamma_g*m - delta_g*g;
    
    f2 =@(p0,pr,pa,par,m,g,m2,C2) + gamma_m(p0,pr,pa,par)   - delta_m*m2;
    g2 =@(p0,pr,pa,par,m,g,m2,C2) + gamma_g2*m2 - delta_g*C2;
    
    
    initialCondition = [1,0,0,0,0,0,0,0];
    
    dxdt = @(t,x)[M(x(8),t)*[x(1);x(2);x(3);x(4)];
        f(x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8));
        g(x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8));
        f2(x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8));
        g2(x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8))];
    
    [T, X] = ode45(dxdt, [0.0,100], initialCondition);
    
    g_storage(iParam) = X(end,6);
    
end

figure(17); clf;
plot(paramArray,g_storage, '-b')
xlabel('Concentration of activating TF (uM)') % EDIT FOR HW1
ylabel('Concentration of product (uM)')
set(gca,'ylim', [0,40]);

%%


