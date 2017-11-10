classdef P1 < Element
  methods % constructor
    function obj = P1(dim)
      nB = 2:(dim+1);
      nV = 2:(dim+1);
      obj = obj@Element(dim, nV, nB, 1);
      obj.isSimplex = 1;
    end
  end
  methods % evaluation
    function B = evalD0Basis(obj, points)
      nP = size(points, 2);
      B = zeros(obj.nB(nP), size(points,1));
      B(1,:) = 1-sum(points,2);
      for i = 1:nP
        B(i+1,:) = points(:,i);
      end
    end
    function B = evalD1Basis(obj, points)
      [nP, nD] = size(points);
      B = zeros(obj.nB(nD), nP, 1, nD);
      B(1,:,:) = -1;
      for i = 1:nD
        B(i+1,:,1,i) = 1;
      end
    end
  end
end