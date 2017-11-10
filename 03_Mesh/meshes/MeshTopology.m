classdef MeshTopology < handle
  properties
    dimP
    connectivity
    isSimplex
  end
  
  methods % constructor
    function obj = MeshTopology(dimP)
      obj.dimP = dimP;
    end
  end
  methods % mesh information
    function R = getEntity(obj, dim, varargin) % [I]
      I = ':'; if nargin > 2, I = varargin{1}; end
      if ischar(dim), dim  = obj.dimP - str2double(dim); end % dim to codim
      R = obj.connectivity{dim+1,1}(I,:);
    end
    function R = getNumber(obj, dim)
      if ischar(dim), dim  = obj.dimP - str2double(dim); end % dim to codim
      R = numel(obj.connectivity{dim+1, dim+1});
    end
    function R = isBoundary(obj)
      e2F = obj.connectivity{obj.dimP+1,obj.dimP}; % nExnF
      R = accumarray(e2F(e2F>0),1, [obj.getNumber('1') 1])==1; % nFx1
    end
  end
end