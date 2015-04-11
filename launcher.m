clear all;
clc;

nb_iter=10

a = load('data.mat');

dataset=a.data;
labels=a.labels;
individuals=a.individuals;

%init probs matrix
nb_instances = size(dataset,3);
nb_classes = 4;
%init_probs = 0.1*ones(nb_instances,nb_classes);
%init_probs(:,2)=init_probs(:,2)*7;
%assert(unique(sum(init_probs,2))==1); 
init_probs =[];
for i = 1:nb_instances
    y = rand(1,nb_classes);
    s = sum(y);
    init_probs = [init_probs; y/s];
end
sum(init_probs)
%graph
nui_skeleton_conn =[0,1;1,2;2,3;2,4;4,5;5,6;6,7;2,8;8,9;9,10;10,11;0,12;12,13;13,14;14,15;0,16;16,17;17,18;18,19];
nui_skeleton_conn = nui_skeleton_conn +1;

[m,p] = em_pose_clustering(dataset,init_probs,nb_iter); 

labels(labels==8)=4;%to smooth with classes

%compute #instances for each class
nb_inst=zeros(nb_classes,1);
for i=1:nb_classes
    nb_inst(i) = length(labels(labels==i));
end
nb_inst'

%compute the class = corresponding to max probability
[prob, classes] =max(p,[],2); 

%matrix of confusion: rows stand for actual classes, columns for predicted
%ones+2 columns for precision and recall
confusion = zeros(nb_classes,nb_classes+2)-1;
for i=1:nb_classes%actual
    for j=1:nb_classes%predicted
        confusion(i,j) = sum(classes(labels==i)==j);
    end
    %precision
    confusion(i,nb_classes+1)=confusion(i,i)/sum(classes(classes==i));
    %recall
    confusion(i,nb_classes+2)=confusion(i,i)/nb_inst(i);
end
confusion

%hist
% %size(p)
% l1 = [];
% l2=[];
% l3 = [];
% l4 = [];
% for k = 1:idx1
%    [maximu, id] = max(p(k,:));
%    l1 = [l1,id];      
% end
% %size(l1)
% [a,b]=hist(l1,unique(l1));
% 
% %(idx1-max(a))/idx1*100
% a(b==1)/idx1*100
% 
% for k = idx1+1:idx2
%    [maximu, id] = max(p(k,:));
%    l2 = [l2,id];    
% end
% [a,b]=hist(l2,unique(l2));
% 
% 
% a(b==2)/(idx2-idx1)*100
% 
% for k = idx2+1:idx3
%    [maximu, id] = max(p(k,:));
%    l3 = [l3,id];    
% end
% [a,b]=hist(l3,unique(l3));
% 
% 
% a(b==3)/(idx3-idx2)*100
% 
% for k = idx3+1:idx4
%    [maximu, id] = max(p(k,:));
%    l4 = [l4,id];    
% end
% [a,b]=hist(l4,unique(l4));
% 
% % a(b==4)/(idx4-idx3)*100
