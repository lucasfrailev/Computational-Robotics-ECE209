function [optimalPolicyMap, optimalValueMap] = ComputeValueIteration(errorProb,discountFactor,len,width,goal)
value = [0,0];
remainder = 1;
reward = -Inf;
tempReward = 0;
counter = 1;
policyValueMap=zeros(len,width,12);
optimalPolicyMap=zeros(len,width,12,2);
newpolicyValueMap=policyValueMap;
while remainder(counter)>1e-4
%     if ~mod(counter,10)
%         disp(strcat('Iteration Number: ', num2str(counter)))
%     end
    for i=0:len-1
        for j=0:width-1
            for k=0:11
                for l=-1:1
                    for m=-1:1
                        if ~(l == 0 && ismember(m,[-1,1]))
                            for n=1:3
                                statePrime=EvolveStateCases([i,j,k],[l,m],errorProb,len,width,n);
                                tempReward = tempReward + ComputeProb([i,j,k],[l,m],errorProb,statePrime,len,width)*(ComputeReward(statePrime,len,width,goal)+discountFactor*policyValueMap(statePrime(1)+1,statePrime(2)+1,statePrime(3)+1));
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
                optimalPolicyMap(i+1,j+1,k+1,1:2) = value;
                newpolicyValueMap(i+1,j+1,k+1)= reward;
                reward = -Inf;
            end
        end
    end
    counter = counter + 1;
    remainder(counter)= max(max(max(abs(newpolicyValueMap-policyValueMap))));
    policyValueMap=newpolicyValueMap;  
end
optimalValueMap = policyValueMap;