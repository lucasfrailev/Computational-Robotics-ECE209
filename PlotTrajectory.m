function trajectory = PlotTrajectory(state,policyMap,errorProb,len,width,goal)
dbstop if error
trajectory(1,:) = state;
counter = 1;
u = 0;
v = 0;
if goal(3)>=0
    while sum(state == goal)~=3
        [a,b] = pol2cart(pi/2-state(3)*2*pi/12,0.02);
        u=[u;a];
        v=[v;b];
        counter = counter + 1;
        state = EvolveState(state,reshape(policyMap(state(1)+1,state(2)+1,state(3)+1,1:2),1,[]),errorProb,len,width);
        trajectory(counter,:) = state;
    end
else
    while sum(state(1:2) == goal(1:2))~=2
        [a,b] = pol2cart(pi/2-state(3)*2*pi/12,0.02);
        u=[u;a];
        v=[v;b];
        counter = counter + 1;
        state = EvolveState(state,reshape(policyMap(state(1)+1,state(2)+1,state(3)+1,1:2),1,[]),errorProb,len,width);
        trajectory(counter,:) = state;
    end
end
u(1)=[];
v(1)=[];
PlotFloor(len,width,goal)
hold on
quiver(trajectory(1:end-1,1),trajectory(1:end-1,2),u,v,0.4)
plot(trajectory(:,1),trajectory(:,2),'k')
h = quiver(trajectory(end-1,1),trajectory(end-1,2),trajectory(end,1)-trajectory(end-1,1),trajectory(end,2)-trajectory(end-1,2),0,'k');
set(h,'MaxHeadSize',1e2,'AutoScaleFactor',1);