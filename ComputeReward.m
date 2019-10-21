function reward=ComputeReward(state,len,width,goal)
reward = 0;
if IsAtBoundary(state,len,width)
    reward=-100;
elseif state(1)==3 && ismember(state(2),[6,5,4])
    reward=-10;
elseif goal(3)<0
    if sum(state(1:2)== goal(1:2)) == 2
        reward=1;
    end
elseif goal(3)>=0
    if sum(state == goal) == 3
        reward=1;
    end
else
    reward = 0;
end