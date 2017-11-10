classdef MeshTopologyHex < MeshTopology
  methods % constructor
    function obj = MeshTopologyHex(elem)
      obj = obj@MeshTopology(3);
      obj.update(elem);
    end
    function update(obj, elem)
      obj.connectivity = cell(obj.dimP+1);
      obj.connectivity{obj.dimP+1,1} = elem;
      obj.connectivity{3,1} = [elem(:,[1,2,3,4]); elem(:,[5,6,7,8]); ...
                               elem(:,[1,3,5,7]); elem(:,[2,4,6,8]); ...
                               elem(:,[1,2,5,6]); elem(:,[3,4,7,8])];
      [~,I] = min(obj.connectivity{3,1},[],2);
      obj.connectivity{3,1}(I==1,:) = obj.connectivity{3,1}(I==1,[1 2 3 4]);
      obj.connectivity{3,1}(I==2,:) = obj.connectivity{3,1}(I==2,[2 1 4 3]);
      obj.connectivity{3,1}(I==3,:) = obj.connectivity{3,1}(I==3,[3 1 4 2]);
      obj.connectivity{3,1}(I==4,:) = obj.connectivity{3,1}(I==4,[4 2 3 1]);
      obj.connectivity{3,1}(:,2:3) = sort(obj.connectivity{3,1}(:,2:3),2);
      [obj.connectivity{3,1}, ~, e2F] = unique(obj.connectivity{3,1}, 'rows');    
      obj.connectivity{2,1} = [elem(:,[1,2]); elem(:,[3,4]); elem(:,[5,6]); elem(:,[7,8]); ...
                               elem(:,[1,3]); elem(:,[5,7]); elem(:,[2,4]); elem(:,[6,8]); ...
                               elem(:,[1,5]); elem(:,[2,6]); elem(:,[3,7]); elem(:,[4,8])];
      [obj.connectivity{2,1}, ~, e2Ed] = unique(sort(obj.connectivity{2,1},2),'rows');    
      obj.connectivity{4,3} = reshape(e2F, [], 6);
      obj.connectivity{4,2} = reshape(e2Ed, [], 12);
      %
      obj.connectivity{1,1} = (1:max(obj.connectivity{3,1}(:)))';
      obj.connectivity{2,2} = (1:size(obj.connectivity{2,1},1))';
      obj.connectivity{3,3} = (1:size(obj.connectivity{3,1},1))';
      obj.connectivity{4,4} = (1:size(obj.connectivity{4,1},1))';
    end
  end
end