init_probs = [];

function [model probs] = em_pose_clustering(data,init_probs,max_iters,graph)%20*3*N,N*K inst*classes we can init with random
%each rowm add up to 1

    %defining the uniform initial probabilities matrix
    nb_instances = size(data,3);
    nb_classes = 4;
    init_probs = 0.25*ones(nb_instances,nb_classes);
    
    probs=init_probs;
    
    for i=1:max_iters
        if nargin==4
            model=Mstep(data,probs,graph);
        elseif nargin==3
            model=Mstep(data,probs)
        %E-step to get probs of missing values
    %    randomising probs of missing values its the other way around
        for i=1:N
            %1*K logprob
            logprob=compute_log_likeklihood(data(:,:,i),model);
            probs(i,:)=exp(logprobs-min(logprobs)-log(min(exp(logprobs-min(logprobs)))));
            %            normalize logprob;
        end
    end
    
end

%have to redo the 2 fit_ to take weight into account
%weight is percentage of class in dataset
%play around can delete some variables etc
%-1000 -1100 -3100 sum(exp(logprob))
