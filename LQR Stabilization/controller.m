
function u = controller(params, t, X)
  % You have full state feedback available
   K = [-0.0089   -1.0553   -0.0112   -0.1250];
  u=-K*X;

  % After doing the steps in simLinearization, you should be able to substitute the linear controller u = -K*x
  
end

