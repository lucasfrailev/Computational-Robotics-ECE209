function nextStateProb = ComputeProb(state,action,errorProb,desiredState,length,width)
[isBoundary, wallHeading] = IsAtBoundary(state,length,width);
fakeState(:,:,1)=state+[ComputeHeading(state+[0 0 -1])*action(1) action(2)-1];
fakeState(:,:,2)=state+[ComputeHeading(state+[0 0 0])*action(1) action(2)+0];
fakeState(:,:,3)=state+[ComputeHeading(state+[0 0 1])*action(1) action(2)+1];
if isBoundary
    if fakeState(1,1:2,1)*wallHeading'>state(1:2)*wallHeading'
        fakeState(1,1:2,1) = state(1:2);
    end
    if fakeState(1,1:2,2)*wallHeading'>state(1:2)*wallHeading'
        fakeState(1,1:2,2) = state(1:2);
    end
    if fakeState(1,1:2,3)*wallHeading'>state(1:2)*wallHeading'
        fakeState(1,1:2,3) = state(1:2);
    end
end
fakeState(1,3,1)=mod(fakeState(1,3,1),12);
fakeState(1,3,2)=mod(fakeState(1,3,2),12);
fakeState(1,3,3)=mod(fakeState(1,3,3),12);
if sum(desiredState == fakeState(1,:,1)) == 3 || sum(desiredState == fakeState(1,:,3)) == 3
    nextStateProb = errorProb;
elseif sum(desiredState == fakeState(1,:,2)) == 3
    nextStateProb = 1 - 2*errorProb;
else
    nextStateProb = 0;
end
