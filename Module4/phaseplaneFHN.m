% model parameters
eps = 0.08;
a = 0.5;
b = 0.2;

% model definition
f = @(v,w) v - 1/3*v.^3 - w;
g = @(v,w) eps*(v + a -b*w);

%% single cell
dxdt =@ (t,x) [f(x(1),x(2)); g(x(1),x(2));];

% solve!
[T,X] = ode45(dxdt,[0,100], [-0,-0.5]);



figure(405); clf; hold on;
set(gca, 'xlim', [-2.5, 2.5], 'ylim', [-2.5,2.5])
ylabel('w');
xlabel('v')

uArray = linspace(-2.5, 2.5,32);
wArray = linspace(-2.5, 2.52,32);

[uMesh,wMesh] = meshgrid(uArray, wArray);

% the Matlab plot command for a field of arrows is:
quiver(uMesh, wMesh, f(uMesh, wMesh), g(uMesh,wMesh), 0.5)

plot(X(:,1),X(:,2),'-r')
plot(X(end,1),X(end,2), 'or')