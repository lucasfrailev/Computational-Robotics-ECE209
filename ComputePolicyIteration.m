function [optimalPolicy, optimalValue] = ComputePolicyIteration(actionMap,errorProb,discountFactor,len,width,goal)
policyValueMap = ComputePolicyValueFast(actionMap,errorProb,discountFactor,len,width,goal);
actionMapNew = ComputeOneStepOptimalPolicy(policyValueMap,errorProb,discountFactor,len,width);
policyValueMapNew = ComputePolicyValueFast(actionMapNew,errorProb,discountFactor,len,width,goal);
while max(max(max(abs(policyValueMap-policyValueMapNew))))>0
    actionMapNew = ComputeOneStepOptimalPolicy(policyValueMapNew,errorProb,discountFactor,len,width);
    policyValueMap = policyValueMapNew;
    policyValueMapNew = ComputePolicyValueFast(actionMapNew,errorProb,discountFactor,len,width,goal);
end
optimalPolicy = actionMapNew;
optimalValue = policyValueMap;
