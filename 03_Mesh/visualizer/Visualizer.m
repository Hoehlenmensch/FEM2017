classdef Visualizer < SOFE
  properties
    fes
  end
  
  methods %constructor
    function obj = Visualizer(fes)
      obj.fes = fes;
    end
  end
  methods % public
    function show(obj, U)
      fprintf('Der DoFVektor sieht so aus:\n');
      disp(U);
    end
  end
  methods(Static = true)
    function showData2D(f, N, isTri)
      % on [0,1]x[0,1]
      grid = linspace(0,1,N);
      [X,Y] = meshgrid(grid);
      P = [X(:) Y(:)];
      if isTri
        I = P(:,1)+P(:,2) > 1;
      else
        I = [];
      end
      P(I) = nan;
      Z = f(P);
      Z(I) = nan;
      Z = reshape(Z, size(X));
      surf(X,Y,Z);
      shading interp;
    end
  end
end