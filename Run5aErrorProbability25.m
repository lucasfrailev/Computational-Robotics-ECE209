%%% 3(b) & 3(c) Create a function that plots and returns a trajectory given a policy, initial state and error probability
% The trajectory is in black and heading at each step is represented by the
% blue arrows
figure
trajectory = PlotTrajectory(initialState,policyMap,errorProbability,len,width,goal);
title('Trajectory Map under Naive Policy')

%%% 3(d) & 3(e) Create a function to compute the policy evaluation of a given policy, returning a map indexed by the state
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

%%% 3(f) Create a function to compute the optimal policy given a one step look-ahead policy evaluation, returning a map indexed by the state

newPolicyMap = ComputeOneStepOptimalPolicy(policyValueMap,errorProbability,discountFactor,len,width);

%%% 3(g) & 3(h) Create a function to compute policy iteration on the system given parts 3(e) and 3(f) and that returns the optimal policy and policy evaluation maps and recompute the trajectory and trajectory values using the output
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

%%% 3(i) Time step 3(h)
disp(strcat('Computing the optimal policy and policy value maps, the optimal trajectory and its value with policy iteration took ', {' '}, num2str(timeTaken), {' '},'seconds'))

%%% 4(a) & 4(b) Create a function to compute value iteration on the system that returns the optimal policy and policy evaluation maps and recompute the trajectory and trajectory values using the output
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

%%% 3(i) Time step 3(h)
disp(strcat('Computing the optimal policy and policy value maps, the optimal trajectory and its value with value iteration took ', {' '}, num2str(timeTaken), {' '},'seconds'))
