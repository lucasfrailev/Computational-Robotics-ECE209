function PlotTile(x,y,color)
hold on
patch([x-0.5 x+0.5 x+0.5 x-0.5],[y-0.5 y-0.5 y+0.5 y+0.5],color)
