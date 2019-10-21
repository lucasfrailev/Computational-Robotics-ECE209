function policyValueMap = ComputePolicyValueFast(actionMap,errorProb,discountFactor,len,width,goal)
value = 0;
remainder = 1;
counter = 1;
policyValueMap=ones(len,width,12);
newpolicyValueMap=policyValueMap;
while remainder>1e-4
    counter = counter + 1;
    for i=0:len-1
        for j=0:width-1
            for k=0:11
                value = ComputeReward([i,j,k],len,width,goal);
                for index=1:3
                    action = reshape(actionMap(i+1,j+1,k+1,1:2),1,[]);
                    statePrime=EvolveStateCases([i,j,k],action,errorProb,len,width,index);
                    value = value + discountFactor*ComputeProb([i,j,k],action,errorProb,statePrime,len,width)*policyValueMap(statePrime(1)+1,statePrime(2)+1,statePrime(3)+1);
                end
                newpolicyValueMap(i+1,j+1,k+1)= value;
            end
        end
    end
    
    remainder= max(max(max(abs(newpolicyValueMap-policyValueMap))));
    policyValueMap=newpolicyValueMap;
end