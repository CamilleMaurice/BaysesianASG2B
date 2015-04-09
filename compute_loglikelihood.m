function l = compute_loglikelihood(instance, model)
%
%  Input
%    instance: a 20x3 matrix defining body positions of one instance
%    model: as given by learn_model
%
%  Output
%    l: a vector of size #classes containing the loglikelihhod of the 
%       instance
%
%
numb_class=length(model.jointparts.sigma);
l=zeros(1,numb_class);
for i_cl=1:numb_class
	if isfield(model.jointparts,'means')
		l(1,i_cl)=
	end
end
	
