function actionMap = ComputeOneStepOptimalPolicy(policyValueMap,errorProb,discountFactor,length,width)
value(:) = [0 0];
reward = -Inf;
tempReward = 0;
actionMap=zeros(length,width,12,2);
for i=0:length-1
    for j=0:width-1
        for k=0:11
            for l=-1:1
                for m=-1:1
                    if ~(l == 0 && ismember(m,[-1,1]))
                        for n=1:3
                            statePrime=EvolveStateCases([i,j,k],[l,m],errorProb,length,width,n);
                            tempReward = tempReward + discountFactor*ComputeProb([i,j,k],[l,m],errorProb,statePrime,length,width)*policyValueMap(statePrime(1)+1,statePrime(2)+1,statePrime(3)+1);
                            tempValue=[l,m];
                        end
                        if tempReward>reward
                            value = tempValue;
                            reward = tempReward;
                        end
                        tempReward = 0;
                    end
                end
            end
            actionMap(i+1,j+1,k+1,1:2) = value;
            reward = -Inf;
        end
    end
end