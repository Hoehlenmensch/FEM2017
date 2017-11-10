classdef MeshTopologyTet < MeshTopology
  methods % constructor
    function obj = MeshTopologyTet(elem)
      obj = obj@MeshTopology(3);
      obj.update(elem);
      obj.isSimplex = 1;
    end
    function update(obj, elem)
      obj.connectivity = cell(obj.dimP+1);
      obj.connectivity{obj.dimP+1,1} = elem;
      obj.connectivity{3,1} = [elem(:,[1,2,3]); elem(:,[1,2,4]); ...
                               elem(:,[2,3,4]); elem(:,[1 3 4])];
      [obj.connectivity{3,1}, ~, e2F] = unique(sort(obj.connectivity{3,1},2),'rows');    
      obj.connectivity{2,1} = [elem(:,[1,2]); elem(:,[2,3]); elem(:,[1,3]); ...
                               elem(:,[1 4]); elem(:,[2,4]); elem(:,[3 4])];
      [obj.connectivity{2,1}, ~, e2Ed] = unique(sort(obj.connectivity{2,1},2),'rows');    
      obj.connectivity{4,3} = reshape(e2F,[], 4);
      obj.connectivity{4,2} = reshape(e2Ed,[], 6);
      %
      obj.connectivity{1,1} = (1:max(obj.connectivity{3,1}(:)))';
      obj.connectivity{2,2} = (1:size(obj.connectivity{2,1},1))';
      obj.connectivity{3,3} = (1:size(obj.connectivity{3,1},1))';
      obj.connectivity{4,4} = (1:size(obj.connectivity{4,1},1))';
    end
  end
end