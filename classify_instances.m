function probs = classify_instances(instances, model)
%
%  Input
%    instance: a 20x3x#instances matrix defining body positions of
%              instances
%	 model:
%    a (tentative) structure for the output model is:
%       model.connectivity: the input Graph variable should be stored here 
%                           for later use.
%       model.class_priors: containing a vector with the prior estimations
%                           for each class
%       model.jointparts(i) contains the estimated parameters for the i-th joint
%
%          For joints that only depend on the class model.jointparts(i) has:
%            model.jointparts(i).means: a matrix of 3 x #classes with the
%                   estimated means for each of the x,y,z variables of the 
%                   i-th joint and for each class.
%            model.jointparts(i).sigma: a matrix of 3 x #classes with the
%                   estimated stadar deviations for each of the x,y,z 
%                   variables of the i-th joint and for each class.
%
%          For joints that follow a gausian linear model model.jointparts(i) has:
%            model.jointparts(i).betas: a matrix of 12 x #classes with the
%                   estimated betas for each x,y,z variables (12 in total) 
%                   of the i-th joint and for each class label.
%            model.jointparts(i).sigma: as above
%
%
%  Output
%    probs: a matrix of #instances x #classes with the probability of each
%           instance of belonging to each of the classes
%
%  Important: to avoid underflow numerical issues this computations should
%  be performed in log space
%
numb_inst=length(instances);
numb_class=length(model.jointparts.sigma);
probs=zeros(numb_inst,numb_class);
for i_inst=1:numb_inst
	probs(i_inst,:)=compute_loglikelihood(instances(:,:,i_inst), model);

end
