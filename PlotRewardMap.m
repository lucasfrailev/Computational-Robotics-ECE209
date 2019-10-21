function PlotRewardMap(length,width,Goal)

matPlot=zeros(length,width);
for i = 0:length-1
    for j = 0:width-1
            matPlot(length-i,j+1)=ComputeReward([j,i,0],length,width,Goal);
    end
end
imshow(mat2gray(matPlot))