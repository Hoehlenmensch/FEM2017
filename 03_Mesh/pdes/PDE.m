classdef PDE < SOFE
  properties
    data
    fes
    solution
  end
  
  methods %constructor
    function obj = PDE(data, fes)
      obj.data = data;
      obj.fes = fes;
    end
  end
  methods
    function compute(obj)
      obj.solution = [];
    end
  end
end