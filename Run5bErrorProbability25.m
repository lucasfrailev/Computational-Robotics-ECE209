
errorProbability = 0.25;
discountFactor = 0.9;
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

%%% 4(c)
disp(strcat('Computing the optimal policy and policy value maps, the optimal trajectory and its value with value iteration took ', {' '}, num2str(timeTaken), {' '},'seconds'))
