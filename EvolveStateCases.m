function newState = EvolveStateCases(state,action,errorProb,len,width,statePrime)
if statePrime == 0
    roll=rand(1);
    if roll<=errorProb
        newState=state+[ComputeHeading(state+[0 0 -1])*action(1) action(2)-1];
    elseif roll<=2*errorProb
        newState=state+[ComputeHeading(state+[0 0 1])*action(1) action(2)+1];
    else
        newState=state+[ComputeHeading(state+[0 0 0])*action(1) action(2)+0];
    end
else
    switch statePrime
        case 1
            newState=state+[ComputeHeading(state+[0 0 -1])*action(1) action(2)-1];
        case 2
            newState=state+[ComputeHeading(state+[0 0 1])*action(1) action(2)+1];
        case 3
            newState=state+[ComputeHeading(state+[0 0 0])*action(1) action(2)+0];
    end
end

newState(3)= mod(newState(3),12);
[isBoundary, wallHeading] = IsAtBoundary(state,len,width);
if isBoundary
    if newState(1:2)*wallHeading'>state(1:2)*wallHeading'
        newState(1:2) = state(1:2);
    end
end