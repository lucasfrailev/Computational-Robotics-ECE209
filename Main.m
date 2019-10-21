%% Initialize Parameters
clear
close all
clc
len = 8;
width = 8;
goal = [5 6 -1];
headings = 12;
errorProbability = 0.02;
initialState = [1 6 6];
desiredState = [1 5 7];
action = [1 1];

%% 1(a) Create State Space Array S
[a, b, c] = meshgrid(0:len-1,0:width-1,0:headings-1);
S = [reshape(a,[],1),reshape(b,[],1),reshape(c,[],1)];
clear a b c

%% 1(b) Create Action Space Array A
[a, b] = meshgrid([-1 1],-1:1);
A = [reshape(a,[],1),reshape(b,[],1); 0, 0];
clear a b 

%% 1(c) Create a function that computes probability psa(s')
% Requires len and width as it runs function IsAtBoundary inside
nextStateProb = ComputeProb(initialState,action,errorProbability,desiredState,len,width);

%% 1(d) Create a function that computes s'
% Requires len and width as it runs function IsAtBoundary inside
newState = EvolveState(initialState,action,errorProbability,len,width);

% Plot histogram of outcomes to show we follow the error probability
samples=10000;
figure
PlotHistogramStateEvolution(initialState,action,errorProbability,len,width,samples); 

%% 2(a) Create a function that returns the rewards given s
reward = ComputeReward(initialState,len,width,goal);

% We use it to plot the arena with red, yellow and green having rewards of
% -100 -10 and 1 respectively
figure
PlotFloor(len,width,goal)
title('Floor Map')

%% 3(a) Create a function that returns a policy map indexed by s
policyMap = ComputeInitialPolicyMap(len,width,goal);

% We use it to plot in green the actions prescribed as a function of the state on
% the arena from part 2(a)
figure
PlotFloor(len,width,goal)
PlotPolicyMap(policyMap,len,width)
title('Policy Map')

%% 3(b) & 3(c) Create a function that plots and returns a trajectory given a policy, initial state and error probability
% The trajectory is in black and heading at each step is represented by the
% blue arrows
errorProbability = 0;
figure
trajectory = PlotTrajectory(initialState,policyMap,errorProbability,len,width,goal);
title('Trajectory Map under Naive Policy')

%% 3(d) & 3(e) Create a function to compute the policy evaluation of a given policy, returning a map indexed by the state
% We created two such functions, one that uses no previous knowledge of the
% state evolution, 'ComputePolicyValue' and one that exploits the fact that
% the state can at most evolve into three different states given a particular 
% action due to the type of error we have, 'ComputePolicyValueFast'. Both
% return the same result, but the latter scales and runs faster as we dont
% need to run 'ComputeProb' for all s' in S for every initial state and action. 
discountFactor = 0.9;
%policyValueMap = ComputePolicyValue(actionMap,errorProb,discountFactor,length,width,Goal);
policyValueMap = ComputePolicyValueFast(policyMap,errorProbability,discountFactor,len,width,goal);
trajectoryValue = ComputeTrayectoryValue(trajectory,policyValueMap);

disp(strcat('The naive trajectory value is',{' '}, num2str(trajectoryValue)))

%% 3(f) Create a function to compute the optimal policy given a one step look-ahead policy evaluation, returning a map indexed by the state

newPolicyMap = ComputeOneStepOptimalPolicy(policyValueMap,errorProbability,discountFactor,len,width);

%% 3(g) & 3(h) Create a function to compute policy iteration on the system given parts 3(e) and 3(f) and that returns the optimal policy and policy evaluation maps and recompute the trajectory and trajectory values using the output
tic
[optimalPolicyMapPolicyIteration, optimalValueMapPolicyIteration] = ComputePolicyIteration(policyMap,errorProbability,discountFactor,len,width,goal);
figure
trajectory = PlotTrajectory(initialState,optimalPolicyMapPolicyIteration,errorProbability,len,width,goal);
trajectoryValue = ComputeTrayectoryValue(trajectory,optimalValueMapPolicyIteration);
timeTaken = toc;
title('Optimal Trajectory Map under Policy Iteration')
figure
PlotFloor(len,width,goal)
PlotPolicyMap(optimalPolicyMapPolicyIteration,len,width)
title('Optimal Policy Map under Policy Iteration')
disp(strcat('The optimal trajectory value under policy iteration is', {' '}, num2str(trajectoryValue)))

%% 3(i) Time step 3(h)
disp(strcat('Computing the optimal policy and policy value maps, the optimal trajectory and its value with policy iteration took ', {' '}, num2str(timeTaken), {' '},'seconds'))

%% 4(a) & 4(b) Create a function to compute value iteration on the system that returns the optimal policy and policy evaluation maps and recompute the trajectory and trajectory values using the output
tic
[optimalPolicyMapValueIteration, optimalValueMapValueIteration] = ComputeValueIteration(errorProbability,discountFactor,len,width,goal);
figure
trajectory = PlotTrajectory(initialState,optimalPolicyMapValueIteration,errorProbability,len,width,goal);
trajectoryValue = ComputeTrayectoryValue(trajectory,optimalValueMapValueIteration);
timeTaken = toc;
title('Optimal Trajectory Map under Value Iteration')
figure
PlotFloor(len,width,goal)
PlotPolicyMap(optimalPolicyMapValueIteration,len,width)
title('Optimal Policy Map under Value Iteration')
disp(strcat('The optimal trajectory value under value iteration is', {' '}, num2str(trajectoryValue)))

disp(strcat('The maximum unsigned difference between both optimal policy maps is', {' '}, num2str(max(max(max(max(abs(optimalPolicyMapPolicyIteration-optimalPolicyMapValueIteration)))))),{'. '},'Thus we assume the difference in the trajectory values to be due to stopping the iterative process at a threshold instead of waiting for convergence'))

%% 4(c)
disp(strcat('Computing the optimal policy and policy value maps, the optimal trajectory and its value with value iteration took ', {' '}, num2str(timeTaken), {' '},'seconds'))


%% 5(a) Recompute with errorProbability=0.25
%Run5aErrorProbability25.m is just a copy of the code above, it was
%separated to keep the code neat
errorProbability=0.25;
run('Run5aErrorProbability25.m')

%% 5(b) Recompute with Reward depeding on heading and errorProbability 0 & 0.25
%Run5bErrorProbability0.m and Run5bErrorProbability25.m are just a copy of
%the code above, they were separated to keep the code neat
goal = [5 6 6];
run('Run5bErrorProbability0.m')
run('Run5bErrorProbability25.m')
