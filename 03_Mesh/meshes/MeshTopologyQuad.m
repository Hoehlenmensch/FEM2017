classdef MeshTopologyQuad < MeshTopology
  
  methods % constructor % update
    function obj = MeshTopologyQuad(elem)
      obj = obj@MeshTopology(2);
      obj.update(elem);
    end
    function update(obj, elem)
      obj.connectivity = cell(obj.dimP+1);
      obj.connectivity{obj.dimP+1,1} = elem;
      obj.connectivity{2,1} = [elem(:,[1,3]); elem(:,[3,4]); elem(:,[1,3]); elem(:,[2,4])];
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