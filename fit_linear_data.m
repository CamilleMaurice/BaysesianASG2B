function [betas sigma] = fit_linear_gaussian(Y,X)
%
%  Input:
%     Y: vector Dx1 with the observations for the variable
%     X: matrix DxV with the observations for the parent variables
%               of X. V is the number of parent variables
%

