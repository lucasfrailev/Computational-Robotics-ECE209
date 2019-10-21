function PlotProbMap(state,action,length,width)

matPlot=zeros(length,width);
for i = 0:length-1
    for j = 0:width-1
        for h = 0:11
            matPlot(i+1,j+1)=matPlot(i+1,j+1)+ComputeProb(state,action,0.02,[i,j,h],length,width);
        end
    end
end
imshow(mat2gray(matPlot))