function value = ComputeTrayectoryValue(trajectory,policyValueMap)
value = 0;
for i=1:size(trajectory,1)
    value = value + policyValueMap(trajectory(i,1)+1,trajectory(i,2)+1,trajectory(i,3)+1);
end