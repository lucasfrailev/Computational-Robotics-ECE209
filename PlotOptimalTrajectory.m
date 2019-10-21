function trajectory = PlotOptimalTrajectory(state,optimalPolicy,errorProb,length,width,Goal)
close all
dbstop if error
trajectory(1,:) = state;
counter = 1;
[u,v] = pol2cart(pi/2-state(3)*2*pi/12,0.02);
while sum(state(1:2)== Goal)~=2
    counter = counter + 1;
    state = EvolveState(state,reshape(optimalPolicy(state(1)+1,state(2)+1,state(3)+1,1:2),1,[]),errorProb,length,width);
    trajectory(counter,:) = state;
    [a,b] = pol2cart(pi/2-state(3)*2*pi/12,0.02);
    u=[u;a];
    v=[v;b];  
end
u(end)=[];
v(end)=[];
PlotFloor(length,width,Goal)
quiver(trajectory(1:end-1,1),trajectory(1:end-1,2),u,v,0.4)
hold on
arrow(trajectory(end-1,1:2),trajectory(end,1:2))
plot(trajectory(:,1),trajectory(:,2),'b')
PlotPolicyMap(optimalPolicy,Goal,length,width)
PlotRewards(length,width,Goal)