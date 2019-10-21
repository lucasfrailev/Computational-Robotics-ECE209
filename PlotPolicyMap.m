function PlotPolicyMap(policyMap,len,width)
u = 0;
v = 0;
x = 0;
y = 0;
for i = 0:len-1
    for j = 0:width-1
        for k = 0:11
            [a,b] = pol2cart(k*2*pi/12,policyMap(i+1,j+1,k+1,1));
            u=[u;a];
            v=[v;b];
            x=[x;i];
            y=[y;j];
        end
    end
end
u(1) = [];
v(1) = [];
x(1) = [];
y(1) = [];
quiver(x,y,v,u,'g')


