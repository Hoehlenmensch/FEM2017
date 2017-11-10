classdef QuadRule < SOFE
  properties
    order
  end
  
  methods %constructor
    function obj = QuadRule(order)
      obj.order = order;
    end
  end
end