function model = learn_model(dataset, labels, Graph)
nb_joints = size(dataset,1);
nb_var = size(dataset,2); %3 for (x,y,z)

%defining the uniform initial probabilities matrix
nb_instances = size(dataset,3);
nb_classes = 4;
init_probs = 0.25*ones(nb_instances,nb_classes);

%size(init_probs(:,1))
%size(squeeze(dataset(10,1,:))) 

%Naive Bayes
if nargin < 3
    %Initialization of the resulting arrays.
    for i = 1:nb_joints
        model.jointparts(i).means =  zeros (nb_var, nb_classes);
        model.jointparts(i).sigma =  zeros (nb_var, nb_classes);
    end
    
    for i_cl=1:nb_classes        
         for i = 1:nb_joints        
            for i_var=1:nb_var                
                  [model.jointparts(i).means(i_var,i_cl) model.jointparts(i).sigma(i_var,i_cl)] = fit_gaussian(squeeze(dataset(i,i_var,:)), init_probs(:,i_cl));
                  
            end
        end
    end
    
end

%Linear Gaussian 
if nargin == 3
        %Initialization of the resulting arrays.
    for i = 1:nb_joints
        model.jointparts(i).betas =  zeros (12, nb_classes);
        model.jointparts(i).sigma =  zeros (3, nb_classes);
    end
   
    for i_cl=1:nb_classes
        %Get the Initial_probs for all instances corresponding to i_cl.
        P = init_probs(:,i_cl);
        
        for i=1:nb_joints-1%-1 car skeleton n'a que 19 rows pas 20
            %Get the parent coordinates (x,y,z) for all instances for the
            %joint parent of joint i
            joint_parent = nui_skeleton_conn(i,1);
            X = squeeze(dataset(joint_parent,:,:))';
            
            for coord = 1:nb_var
                Y = squeeze(dataset(i,coord,:));
                %Following not implemented yet
                %[beta,sigma] = fit_linear_gaussian(Y,X,P);
                %model.jointparts(i).sigma(coord,i_cl) = sigma;
                %model.jointparts(i).betas(coord:3:12,i_cl) = beta; 
        end
    end
end




end


%  Input:
%    dataset: The data as it is loaded from load_data
%    labels:  The labels as loaded from load_data
%    Graph:   (optional) If empty, this function should compute the naive 
%           bayes model. If it contains a skel description (pe 
%           nui_skeleton_conn, as obtained from skel_model) then it should
%           compute the model using the Linear Gausian Model
%
%  Output: the model
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

%fit_linear(dataset,probs(:,i_cl))
