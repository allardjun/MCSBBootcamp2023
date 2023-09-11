% MCSB Bootcamp
% VStudent - Project X FitzHugh Nagumo

% model parameters
eps = 0.08;
a = 1.00;
b = 0.2;

% model definition
f = @(v,w) v - 1/3*v.^3 - w;
g = @(v,w) eps*(v + a -b*w);

%% single cell
dxdt =@ (t,x) [f(x(1),x(2)); g(x(1),x(2));];

% solve!
[T,X] = ode45(dxdt,[0,100], [-0,-0.5]);

% analysis

figure(2); clf; hold on; box on;
plot(T,X(:,1), '-r')
plot(T,X(:,2), '-b')


%% single cell with injection

I0 = 1.0;
tStart = 40;
tStop = 47;
I =@(t) I0*(t>tStart).*(t<tStop);

% single cell

dxdt =@ (t,x) [f(x(1),x(2)) + I(t); g(x(1),x(2));];

[T,X] = ode45(dxdt,[0,200], [-1.5,-0.5]);

figure(3); clf; hold on; box on;
plot(T,X(:,1), '-r')
plot(T,X(:,2), '-b')

%% multicell


I0 = 1.0;
tStart = 40;
tStop = 47;

I =@(t) I0*(t>tStart).*(t<tStop);

D = 0.9;

dxdt =@(t,x) [f(x(1:10),x(11:20)) ...
    + D*([x(2:10); x(1)] -2*x(1:10) + [x(10); x(1:9)] ... % cell-cell coupling, periodic boundaries
    + [0;0;0;1;0;0;0;0;0;0]*I(t) ); % injection in fourth cell
    g(x(1:10),x(11:20)) ];

ic = [-1.1*ones(10,1);-0.6*ones(10,1)];

[T,X] = ode45(dxdt,[0,100], ic);


% plot results
% time series
figure(4); clf; hold on; box on;
%plot(T,X)
plot(T,X(:,1:10));
xlabel('Time');
ylabel('Voltage')

figure(5)
% movie
for nt=1:numel(T)
    figure(5); clf; hold on; box on;
    plot(X(nt,1:10)); 
    set(gca,'ylim', [-2.5,2.5])
    xlabel('Cell');
    ylabel('Voltage')
    drawnow;
end