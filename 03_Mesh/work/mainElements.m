clear classes
%
element1 = P1(2);
element2 = Q1(2);
%
figure(1); Visualizer.showData2D(@(x)element1.evalBasis(x,0)(1,:),200,1);
figure(2); Visualizer.showData2D(@(x)element2.evalBasis(x,0)(4,:),200,0);