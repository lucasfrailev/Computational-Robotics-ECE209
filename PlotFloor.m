function PlotFloor(len,width,goal)
x=0:len-1;
y=0:width-1;
for i = 1:len
    for j=1:width
        reward=ComputeReward([x(i),y(j),-1],len,width,goal);
        switch reward
            case -100
                PlotTile(x(i),y(j),'red')
            case -10
                PlotTile(x(i),y(j),'yellow')
            case 1
                PlotTile(x(i),y(j),'green')
            otherwise
                PlotTile(x(i),y(j),'white')
        end
    end
end