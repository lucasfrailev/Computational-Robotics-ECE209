function PlotRewards(length,width,Goal)
hold on
scatter(Goal(1),Goal(2),'b')
hold on
for i=0:length-1
    for j=0:width-1
       reward(i+1,j+1)=ComputeReward([i,j,0],length,width,Goal);
       if reward(i+1,j+1)==-100
           scatter(i,j,'k')
       elseif reward(i+1,j+1)==-10
           scatter(i,j,'r')
       end
    end
end
hold on

