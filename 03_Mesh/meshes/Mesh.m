classdef Mesh < SOFE
  properties
    nodes
    element
    topology
    dimW
  end
  
  methods % constructor
    function obj = Mesh(nodes, elem, varargin) % [dimP]
      obj.dimW = size(nodes,2);
      obj.nodes = nodes;
      if nargin > 2, dimP = varargin{1}; else, dimP = size(nodes, 2); end
      obj.element = obj.getShapeElement(size(elem,2), dimP);
      obj.topology = obj.getTopology(nodes, elem, dimP);
    end
  end
  methods % show
    function show(obj)
      elem = obj.topology.getEntity('0');
      switch obj.topology.dimP
        case 1
          switch obj.dimW
            case 1
              plot(obj.nodes, zeros(obj.topology.getNumber(0),1), '*-');
            case 2
              plot(obj.nodes(:,1), obj.nodes(:,2), '*-'); view(2);
            case 3
              plot3(obj.nodes(:,1), obj.nodes(:,2), obj.nodes(:,3), '*-'); view(3);
          end
        case 2
          if obj.topology.isSimplex, I = [1 2 3]; else I = [1 2 4 3]; end
          switch obj.dimW
            case 2
              h = trisurf(elem(:,I), obj.nodes(:,1), obj.nodes(:,2), zeros(size(obj.nodes,1),1));
              set(h,'facecolor','g','edgecolor','k'); view(2);
            case 3
              h = trisurf(elem(:,I), obj.nodes(:,1), obj.nodes(:,2), obj.nodes(:,3));
              set(h,'facecolor','g','edgecolor','k'); view(3);
          end
        case 3
          if isempty(varargin)
            fc = obj.topology.getEntity(2);
            isB = obj.topology.isBoundary();
            if obj.topology.isSimplex, I = [1 2 3]; else, I = [1 2 4 3]; end
            h = trimesh(fc(isB,I), obj.nodes(:,1), obj.nodes(:,2), obj.nodes(:,3));
            set(h,'facecolor',[0.5 0.7 0.2],'edgecolor','k'); view(3);
          else
            
          end         
      end
      axis equal; axis tight;
    end
  end
  methods(Static = true)
    function R = getTopology(nodes, elem, dimP)
      switch size(elem, 2)
        case 2
          R = MeshTopologyInt(elem);
        case 3
          R = MeshTopologyTri(elem);
        case 4
          if dimP == 2
            R = MeshTopologyQuad(elem);
          else
            R = MeshTopologyTet(elem);
          end
        case 8
          R = MeshTopologyHex(elem);
      end
    end
    function R = getShapeElement(N, dimP)
      switch N
        case 2
          assert(dimP == 1);
          R = P1(dimP);
        case 3
          assert(dimP == 2);
          R = P1(dimP);
        case 4
          if dimP == 2
            assert(dimP == 2);
            R = Q1(dimP);
          else
            assert(dimP == 3);
            R = P1(dimP);
          end
        case 8
          assert(dimP == 3);
          R = Q1(dimP);
      end
    end
    function [nodes, elem] = getTensorProductMesh(grid, varargin) % [isSimplex]
      switch numel(grid)
        case 1
          nodes = grid{1};
          if size(nodes,1) == 1
            nodes = nodes';
          end
          m = numel(nodes);
          elem = [1:(m-1); 2:m]';
        case 2
          m = numel(grid{1});
          n = numel(grid{2});
          nodes = [kron(ones(1,n),grid{1}); ...
                   kron(grid{2}, ones(1,m))]';
          elem = [1:m*(n-1)-1; 2:m*(n-1)];
          elem = [elem; elem+m]';
          elem(m:m:end,:) = [];
          if nargin > 1 && varargin{1}
            elem = [elem(:,[1 2 3]); elem(:,[4 3 2])];
          end
        case 3
          m = numel(grid{1});
          n = numel(grid{2});
          p = numel(grid{3});
          nodes = [kron(ones(1,p),kron(ones(1,n),grid{1}))', ...
                   kron(ones(1,p),kron(grid{2}, ones(1,m)))', ...
                   kron(grid{3},kron(ones(1,n), ones(1,m)))'];
          elem = [1:m*n*(p-1)-m-1; 2:m*n*(p-1)-m]';
          elem = [elem elem+m];
          elem = [elem, elem+m*n];
          delete = bsxfun(@(x,y)x+y,m*(n-1)+1:m*n-1,((0:(p-3))*m*n)');
          elem([m:m:m*n*(p-1)-m-1 delete(:)'],:) = [];
          if nargin > 1 && varargin{1}
            elem = [elem(:,[5 6 1 8]); elem(:,[5 1 7 8]); elem(:,[2 1 6 8]); ...
                    elem(:,[3 7 1 8]); elem(:,[4 2 8 1]); elem(:,[3 1 4 8])];
          end
      end
    end
  end
end