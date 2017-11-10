clear classes
% PARAMETERS
isSimplex = 1;
dimP = 1;
dimW = 3;
N = 25;
% MESH
switch dimP
  case 1
    [nodes elem] = Mesh.getTensorProductMesh({linspace(0,1,N)});
    switch dimW
      case 1
        f = @(x)x;
      case 2
        f = @(x) [x.*cos(2*pi*x) x.*sin(2*pi*x)];
      case 3
        f = @(x) [x.*cos(2*pi*x) x.*sin(2*pi*x) x];
    end
  case 2
    [nodes elem] = Mesh.getTensorProductMesh({linspace(0,1,N); linspace(0,1,N)}, isSimplex);
    switch dimW
      case 2
        f = @(x)x;
      case 3
        f = @(x) [x(:,1) x(:,2) 0.2*sin(2*pi*prod(x,2))];;
    end
  case 3
    [nodes elem] = Mesh.getTensorProductMesh({linspace(0,1,N); linspace(0,1,N); linspace(0,1,N)}, isSimplex);
    f = @(x)[x(:,1).*sin(1+1.75*x(:,2))+0.2*sin(2*pi*x(:,3)) 2*(x(:,2)+0.1*sin(2*pi*x(:,3))) 3*x(:,3)];
end
m = Mesh(f(nodes), elem, dimP);
% SHOW
m.show();













return
%interval
[nodes, elem] = Mesh.getTensorProductMesh({linspace(0,1,50)}, 0);
m = Mesh([nodes sin(2*pi*nodes) cos(2*pi*nodes)], elem, 1);
m.show();
%
pause
% triangles
load('./main/meshData/nodesRing.txt');
load('./main/meshData/elemRing.txt');
m = Mesh([nodesRing prod(nodesRing,2)], elemRing, 2);
m.show();
%
pause
% quadrilaterals
[nodes, elem] = Mesh.getTensorProductMesh({linspace(0,1,20), linspace(0,1,10)}, 0);
m = Mesh([nodes prod(nodes,2)], elem, 2);
m.show();
%
pause
%tetrahedra
load('./main/meshData/nodesBall.txt');
load('./main/meshData/elemBall.txt');
m = Mesh(nodesBall, elemBall, 3);
m.topology.show(@(x)x(:,3)<0);
%
pause
% hexahedra
[nodes, elem] = Mesh.getTensorProductMesh({linspace(0,1,20), linspace(0,1,10), linspace(0,1,15)}, 0);
m = Mesh(nodes, elem, 3);
m.show(@(x)sum(x,2)<0.5);
%
pause
clf