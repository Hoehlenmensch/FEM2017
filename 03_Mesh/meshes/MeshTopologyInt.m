classdef MeshTopologyInt < MeshTopology
  
  methods % constructor % update
    function obj = MeshTopologyInt(elem)
      obj = obj@MeshTopology(1);
      obj.update(elem);
    end
    function update(obj, elem)
      obj.connectivity = cell(obj.dimP+1);
      obj.connectivity{obj.dimP+1,1} = elem;
      obj.connectivity{1,1} = (1:max(obj.connectivity{2,1}(:)))';
      obj.connectivity{2,2} = (1:size(obj.connectivity{2,1},1))';
    end
  end
end