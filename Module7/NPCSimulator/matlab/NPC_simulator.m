% MCSB Bootcamp Dry
% Jun Allard jun.allard@uci.edu
% Simulate a transcription factor diffusing inside the cytoplasm, searching
% for a nuclear pore complex

% numerical parameters
dt = 0.001; % s
ntmax = 1e6;

NSample = 2000; % number of samples

% model parameters
D = 10; %microns^2/second
L = 10; % microns
NPCSize = 0.1; % microns
NPCLocation = [-L/2,0];

alpha = sqrt(2*D*dt);

% data collection
tCapture = zeros(NSample,1);

% set up figure
figure(1); clf; hold on; box on;
xlabel('x (um)'); ylabel('y (um)')
set(gca,'xlim', [-L/2,L/2],'ylim',[-L/2,L/2]);
plot(NPCLocation(1), NPCLocation(2),'or','markerfacecolor','r','markersize',10);

%% Simulate!

tic;

parfor iSample=1:NSample
%for iSample=1:NSample
    
    % intial condition
    x = [L/2,0];
    
    t = 0;
    for nt=1:ntmax
        
        % dynamics
        x = x + alpha*randn(1,2);
        
        % boundaries
        if x(1)>L/2
            x(1)=L/2;
        elseif x(1)<-L/2
            x(1)=-L/2;
        end
        
        if x(2)>L/2
            x(2)=L/2;
        elseif x(2)<-L/2
            x(2)=-L/2;
        end
        
        % test for NPC capture
        if ( (x(1)-NPCLocation(1))^2 + (x(2)-NPCLocation(2))^2 < NPCSize^2 )
            tCapture(iSample) = t;
            break;
        end
        
        if 1 % visualize
            figure(1);
            plot(x(1),x(2),'-ob');
            drawnow;
        end % finished visualization
        
        t = t+dt;
        
    end % finished loop through time
        
    %display(iSample);
    
end % finished loop through samples

toc % report the time

%% analyze results

figure(2); clf; hold on; box on;
histogram(tCapture)
%set(gca,'yscale','log')

display(mean(tCapture))
