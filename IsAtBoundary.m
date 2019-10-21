function [isBoundary, wallHeading] = IsAtBoundary(state,length,width)
length=length-1;
width=width-1;
pos = ~mod(state(1:2),[length,width]);
if sum(pos)~=0
    isBoundary = true;
else
    isBoundary = false;
end
wallHeading = pos.*fix(state(1:2)./[length,width]);
wallHeading = wallHeading +  pos.*fix((state(1:2)-[length,width])./[length,width]);
