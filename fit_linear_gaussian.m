function [betas sigma] = fit_linear_gaussian(Y,X,P)
%
%  Input:
%     Y: vector Dx1 with the observations for the variable
%     X: matrix DxV with the observations for the parent variables
%               of X. V is the number of parent variables


b_tmp = [];
nb_par= size(X,2);

%NOT SURE IT IS CORRECT
for i=1:nb_par
    b_tmp(i,1) = sum((Y.*X(:,i)).*P)/sum(P);
end
b = [sum(Y.*P)/sum(P) ; b_tmp];

A_inner = ones(nb_par)-5;
A = zeros(nb_par+1)-5;

%building the matrix (Should be 4*4 !)
for i=1:nb_par%observations
    A(i,1)=sum((X(:,i).*P))/sum(P);
    A(1,i)=sum((X(:,i).*P))/sum(P);
    for j=1:nb_par%parents
       A_inner(i,j) = sum((X(:,i).*X(:,j)).*P)/sum(P);%-----
    end
end
size(A(1,1));
%Concatenate the inner part and the top
A(1,1)=1;
A(2:end,2:end) = A_inner(:,:);
betas = A\b;

%
% covYY=sum(Y.*Y.*P)/sum(P);
% covYY=covYY-sum(Y.*P)/sum(P)*sum(Y.*P)/sum(P);
% part=covYY;
% for i=1:nb_par
%     for j=1:nb_par
%         covXX=sum(X(:,i).*X(:,j).*P)/sum(P)-sum(X(:,i).*P)/sum(P)*sum(X(:,j).*P)/sum(P);
%         part =part+betas(i)*betas(j)*covXX;
%     end
% end
% sigma=covYY+part;
sigma = sum(P.*((Y-b(1)).^2)) / sum(P);
end
