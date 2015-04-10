function model = Mstep(dataset, probs, Graph)

nb_joints = size(dataset,1);
nb_var = size(dataset,2); %3 for (x,y,z)
nb_classes = 3;


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
                  [model.jointparts(i).means(i_var,i_cl) model.jointparts(i).sigma(i_var,i_cl)] = fit_gaussian(squeeze(dataset(i,i_var,:)), probs(:,i_cl));
                  
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
        %Get the probs for all instances corresponding to i_cl.
        P = probs(:,i_cl);
        
        for i=1:nb_joints-1%-1 car skeleton n'a que 19 rows pas 20
            %Get the parent coordinates (x,y,z) for all instances for the
            %joint parent of joint i
            joint_parent = Graph(i,1);
            X = squeeze(dataset(joint_parent,:,:))';
            
            for coord = 1:nb_var
                Y = squeeze(dataset(i,coord,:));
                %Following not tested yet
                [beta,sigma] = fit_linear_gaussian(Y,X,P);
                model.jointparts(i).sigma(coord,i_cl) = sigma;
                model.jointparts(i).betas(coord:3:12,i_cl) = beta; 
        end
        end
    
        model.connectivity = Graph;
end




end