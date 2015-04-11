clear all;
clc;

a = load('data.mat');

dataset=a.data;
labels=a.labels;
individuals=a.individuals;

%init probs matrix
nb_instances = size(dataset,3);
nb_classes = 4;
%init_probs = (1/4)*ones(nb_instances,nb_classes);
init_probs =[];
for i = 1:nb_instances
    y = rand(1,nb_classes);
    s = sum(y);
    init_probs = [init_probs; y/s];
end

%graph
nui_skeleton_conn =[0,1;1,2;2,3;2,4;4,5;5,6;6,7;2,8;8,9;9,10;10,11;0,12;12,13;13,14;14,15;0,16;16,17;17,18;18,19];
nui_skeleton_conn = nui_skeleton_conn +1;

max_iter = 5;

[m,p] = em_pose_clustering(dataset,init_probs,max_iter); 


%find how much inside bucket from 1 to 4

% class idx
idx1 = find(labels==1);
idx2 = find(labels==2);
idx3 = find(labels==3);
idx4 = find(labels==8);


size(p(idx1,1))
sum(p(idx1,1))


% 
% l1 = [];
% l2=[];
% l3 = [];
% l4 = [];
% for k = 1:idx1
%    [maximu, id] = max(p(k,:));
%    l1 = [l1,id];    
% end
% [a1,b1]=hist(l1,unique(l1));
% a1
% b1
% ((idx1-max(a1))/idx1)*100
% find(b1==1)
% for k = idx1+1:idx2
%    [maximu, id] = max(p(k,:));
%    l2 = [l2,id];    
% end
% [a2,b2]=hist(l2,unique(l2));
% a2
% b2
% ((idx2-idx1)-max(a2))/(idx2-idx1)*100
% 
% for k = idx2+1:idx3
%    [maximu, id] = max(p(k,:));
%    l3 = [l3,id];    
% end
% [a3,b3]=hist(l3,unique(l3));
% a3;
% b3;
% ((idx3-idx2)-max(a3))/(idx3-idx2)*100
% 
% for k = idx3+1:idx4
%     [maximu, id] = max(p(k,:));
%     l4 = [l4,id];    
% end
% [a4,b4]=hist(l4,unique(l4));
% a4;
% b4;
    

