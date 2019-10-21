function policyValueMap = ComputePolicyValue(actionMap,errorProb,discountFactor,len,width,goal)
value = 0;
remainder = 1;
counter = 1;
policyValueMap=rand(len,width,12);
newpolicyValueMap=policyValueMap;
while remainder>0
    counter = counter + 1;
    for i=0:len-1
        for j=0:width-1
            for k=0:11
                value = ComputeReward([i,j,k],len,width,goal);
                for l=0:len-1
                    for m=0:width-1
                        for n=0:11
                            value = value+ discountFactor*ComputeProb([i,j,k],reshape(actionMap(i+1,j+1,k+1,1:2),1,[]),errorProb,[l,m,n],len,width)*policyValueMap(l+1,m+1,n+1);
                        end
                    end
                end
                newpolicyValueMap(i+1,j+1,k+1)= value;
            end
        end
    end
    remainder= max(max(max(abs(newpolicyValueMap-policyValueMap))));
    policyValueMap=newpolicyValueMap;
end