function PlotHistogramStateEvolution(state,action,errorProb,len,width,samples)
mat=zeros(samples,3);
for i = 1:samples
    mat(i,:)=EvolveState(state,action,errorProb,len,width)';
end
uA = unique(mat, 'rows', 'stable');
histogramVals=zeros(samples,1);
for i = 1 : samples
    if sum(mat(i,:)==uA(1,:))==3
        histogramVals(i) = 1;
    elseif sum(mat(i,:)==uA(2,:))==3
        histogramVals(i) = 2;
    elseif sum(mat(i,:)==uA(3,:))==3
        histogramVals(i) = 3;
    end
end
histogram(histogramVals,'Normalization','probability')
xticks([1 2 3])
xticklabels({strcat('state: [',num2str(uA(1,:)), ']');,strcat('state: [',num2str(uA(2,:)), ']');,strcat('state: [',num2str(uA(3,:)), ']');})
title(strcat('State Evolution with Error Probability: ',num2str(errorProb)))