function action = ComputeInitialPolicy(state,len,width,goal)
action = zeros(1,2);
action(1) = sign(ComputeHeading(state)*(goal(1:2)-state(1:2))');
if action(1) == 0 && norm(goal(1:2)-state(1:2))~=0
    action(1) = 1;
end
expectedState = EvolveState(state,action,0,len,width);
angle=(-atan((goal(2)-expectedState(2))/(goal(1)-expectedState(1)))+pi/2)/2/pi*360/30;
if isnan(angle)
    action(2) = 0;
elseif abs(angle-state(3))<3
    action(2) = sign(angle-state(3));
else
    action(2) = sign(mod(angle-6,12)-state(3));
end

