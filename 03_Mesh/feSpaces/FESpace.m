classdef FESpace < SOFE
  properties
    mesh
    element
    quadRule
  end
  
  methods %constructor
    function obj = FESpace(m, e)
      obj.mesh = m;
      obj.element = e;
      obj.quadRule = QuadRule(e.order);
    end
  end
end