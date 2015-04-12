function l = compute_loglikelihood(instance,model)
%  Input
%    instance: a 20x3 matrix defining body positions of one instance
%    model: as given by learn_model
%
%  Output
%    l: a vector of size #classes containing the loglikelihhod of the 
%       instance
%
%

sum1 = 0;
Njoints = size(instance,1); %20
Nclass = 4 ;
Nvar = size(instance,2); %x, y, z
l =  [];
%Test if the model is naive or gaussian
if isfield(model.jointparts,'means')
%%NAIVE BAYES MODEL
    for c = 1:Nclass
        for i = 1:Njoints
            for j = 1:Nvar
                inlog = 2*pi*model.jointparts(i).sigma(j,c);
                
                sum1 = sum1 + (-1/2*log(inlog) - ((instance(i,j) - model.jointparts(i).means(j,c)).^2)/(2*model.jointparts(i).sigma(j,c)));
            end
        end
        l = [l,sum1];
        sum1 = 0;
    end
else if isfield(model.jointparts,'betas')
    %LINEAR GAUSSIAN MODEL
   % nui_skeleton_conn=model.connectivity +1;
    for c = 1:Nclass
        for i = 1:Njoints-1
            for j = 1:Nvar
                X = instance(nui_skeleton_conn(i,1),:);
                y = instance(i,j);
                betas=model.jointparts(i).betas(j:3:12,c)';
                s=model.jointparts(i).sigma(j,c);
                %this is what implements loglikelihood and im not very sure
                %of...
                sum1 = sum1 + (-1/2*log(2*pi*s))-1/(2*s)*(sum(X.*betas(2:end))+betas(1)-y)^2;%Y[j], ?????? 
            end
        end
        l = [l,sum1];
        sum1 = 0;
    end
   
else %if true
    error('champs manquants dans model: betas ou means')
    end
end
end