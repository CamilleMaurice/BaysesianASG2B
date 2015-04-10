clear all;
clc;

a = load('data.mat');

dataset=a.data;
labels=a.labels;
individuals=a.individuals;

%init probs matrix
nb_instances = size(dataset,3);
nb_classes = 4;
%init_probs = (1/3)*ones(nb_instances,nb_classes);
init_probs =[];
for i = 1:nb_instances
    y = rand(1,nb_classes);
    s = sum(y);
    init_probs = [init_probs; y/s];
end
size(init_probs)
%graph
nui_skeleton_conn =[0,1;1,2;2,3;2,4;4,5;5,6;6,7;2,8;8,9;9,10;10,11;0,12;12,13;13,14;14,15;0,16;16,17;17,18;18,19];
nui_skeleton_conn = nui_skeleton_conn +1;

[m,p] = em_pose_clustering(dataset,init_probs,5); 
% class idx
idx1 = max(find(labels==1));
idx2 = max(find(labels==2));
idx3 = max(find(labels==3));
idx4 = max(find(labels==8));

l1 = [];
l2=[];
l3 = [];
l4 = [];
for k = 1:idx1
   [maximu, id] = max(p(k,:));
   l1 = [l1,id];    
end
[a,b]=hist(l1,unique(l1));
a
b
((idx1-max(a))/idx1)*100

for k = idx1+1:idx2
   [maximu, id] = max(p(k,:));
   l2 = [l2,id];    
end
[a,b]=hist(l2,unique(l2));
a
b
((idx2-idx1)-max(a))/(idx2-idx1)*100

for k = idx2+1:idx3
   [maximu, id] = max(p(k,:));
   l3 = [l3,id];    
end
[a,b]=hist(l3,unique(l3));
a
b
((idx3-idx2)-max(a))/(idx3-idx2)*100

for k = idx3+1:idx4
   [maximu, id] = max(p(k,:));
   l4 = [l4,id];    
end
[a,b]=hist(l4,unique(l4));
a
b
((idx4-idx3)-max(a))/(idx4-idx3)*100


