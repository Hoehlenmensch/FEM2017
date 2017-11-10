classdef MeshTopologyTri < MeshTopology
  
  methods % constructor % update
    function obj = MeshTopologyTri(elem)
      obj = obj@MeshTopology(2);
      obj.update(elem);
      obj.isSimplex = 1;
    end
    function update(obj, elem)
      obj.connectivity = cell(obj.dimP+1);
      obj.connectivity{obj.dimP+1,1} = elem;
      obj.connectivity{2,1} = [elem(:,[1,2]); elem(:,[2,3]); elem(:,[1,3])];
      [obj.connectivity{2,1}, ~, e2F] = ...
          unique(sort(obj.connectivity{2,1},2),'rows');      
      obj.connectivity{3,2} = reshape(e2F, size(elem,1), []);
      %
      obj.connectivity{1,1} = (1:max(obj.connectivity{2,1}(:)))';
      obj.connectivity{2,2} = (1:size(obj.connectivity{2,1},1))';
      obj.connectivity{3,3} = (1:size(obj.connectivity{3,1},1))';
    end
  end
end