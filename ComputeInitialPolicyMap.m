function policyMap = ComputeInitialPolicyMap(len,width,goal)
policyMap = zeros(len,width,12,2);
for i = 0:len-1
    for j = 0:width-1
        for k = 0:11
            policyMap(i+1,j+1,k+1,1:2) = ComputeInitialPolicy([i,j,k],len,width,goal);
        end
    end
end
