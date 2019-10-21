function heading = ComputeHeading(state)
dir = fix(mod(state(3)+1,12)/3);
switch dir
    case 0
        heading=[0,1];
    case 1
        heading=[1,0];
    case 2
        heading=[0,-1];
    case 3
        heading=[-1,0];
end