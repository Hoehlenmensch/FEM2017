classdef Q1 < Element
  methods % constructor
    function obj = Q1(dim)
      nB = 2.^(1:dim);
      nV = 2.^(1:dim);
      obj = obj@Element(dim, nV, nB, 1);
    end
  end
  methods % evaluation
    function B = evalD0Basis(obj, points)
      nP = size(points, 2);
      B = zeros(obj.nB(nP), size(points,1));
      switch nP
        case 1
          B(1,:) = 1-points(:,1);
          B(2,:) = points(:,1);
        case 2
          B(1,:) = (1-points(:,1)).*(1-points(:,2));
          B(2,:) = points(:,1).*(1-points(:,2));
          B(3,:) = (1-points(:,1)).*points(:,2);
          B(4,:) = points(:,1).*points(:,2);
        case 3
          B(1,:) = (1-points(:,1)).*(1-points(:,2)).*(1-points(:,3));
          B(2,:) = points(:,1).*(1-points(:,2)).*(1-points(:,3));
          B(3,:) = (1-points(:,1)).*points(:,2).*(1-points(:,3));
          B(4,:) = points(:,1).*points(:,2).*(1-points(:,3));
          B(5,:) = (1-points(:,1)).*(1-points(:,2)).*points(:,3);
          B(6,:) = points(:,1).*(1-points(:,2)).*points(:,3);
          B(7,:) = (1-points(:,1)).*points(:,2).*points(:,3);
          B(8,:) = points(:,1).*points(:,2).*points(:,3);
      end
    end
    function B = evalD1Basis(obj, points)
      nP = size(points, 2);
      B = zeros(obj.nB(nP), size(points,1), 1, nP);
      switch nP
        case 1
          B(1,:,1, 1) = -1;
          B(2,:,1, 1) = 1;
        case 2
          B(1,:,1,1) = -(1-points(:,2));
          B(1,:,1,2) = -(1-points(:,1));
          B(2,:,1,1) = 1-points(:,2);
          B(2,:,1,2) = -points(:,1);
          B(3,:,1,1) = -points(:,2);
          B(3,:,1,2) = 1-points(:,1);
          B(4,:,1,1) = points(:,2);
          B(4,:,1,2) = points(:,1);
        case 3
          B(1,:,1,1) = -(1-points(:,2)).*(1-points(:,3));
          B(1,:,1,2) = -(1-points(:,1)).*(1-points(:,3));
          B(1,:,1,3) = -(1-points(:,1)).*(1-points(:,2));
          %
          B(2,:,1,1) = (1-points(:,2)).*(1-points(:,3));
          B(2,:,1,2) = -points(:,1).*(1-points(:,3));
          B(2,:,1,3) = -points(:,1).*(1-points(:,2));
          %
          B(3,:,1,1) = -points(:,2).*(1-points(:,3));
          B(3,:,1,2) = (1-points(:,1)).*(1-points(:,3));
          B(3,:,1,3) = -(1-points(:,1)).*points(:,2);
          %
          B(4,:,1,1) = points(:,2).*(1-points(:,3));
          B(4,:,1,2) = points(:,1).*(1-points(:,3));
          B(4,:,1,3) = -points(:,1).*points(:,2);
          %
          B(5,:,1,1) = -(1-points(:,2)).*points(:,3);
          B(5,:,1,2) = -(1-points(:,1)).*points(:,3);
          B(5,:,1,3) = (1-points(:,1)).*(1-points(:,2));
          %
          B(6,:,1,1) = (1-points(:,2)).*points(:,3);
          B(6,:,1,2) = -points(:,1).*points(:,3);
          B(6,:,1,3) = points(:,1).*(1-points(:,2));
          %
          B(7,:,1,1) = -points(:,2).*points(:,3);
          B(7,:,1,2) = (1-points(:,1)).*points(:,3);
          B(7,:,1,3) = (1-points(:,1)).*points(:,2);
          %
          B(8,:,1,1) = points(:,2).*points(:,3);
          B(8,:,1,2) = points(:,1).*points(:,3);
          B(8,:,1,3) = points(:,1).*points(:,2);
      end
    end
  end
end