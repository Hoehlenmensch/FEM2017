classdef Element < handle
  properties
    dimP
    nV, nB, order
    isSimplex
  end
  methods % constructor
    function obj = Element(dimP, nV, nB, order)
      obj.dimP = dimP;
      obj.nV = nV;
      obj.nB = nB;
      obj.order = order;
    end
  end
  methods % evaluation
    function B = evalBasis(obj, points, dOrder)
      switch dOrder
        case 0
          B = obj.evalD0Basis(points);
        case 1
          B = obj.evalD1Basis(points);
      end
    end
  end
end