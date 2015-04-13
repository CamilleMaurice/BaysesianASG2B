close all;
clear all;
clc;

nb_iter=20

a = load('data.mat');
size(a.data)
dataset=a.data(:,1:2,:);
labels=a.labels;
individuals=a.individuals;

nb_instances = size(dataset,3);
nb_classes = length(unique(labels));

labels(labels==8)=4;%to smooth with classes

%compute #instances for each class
nb_inst=zeros(nb_classes,1);
for i=1:nb_classes
    nb_inst(i) = length(labels(labels==i));
end
nb_inst
% figure(1)
% skel_vis(dataset(:,:,1))
% figure(2)
% skel_vis(dataset(:,:,2))
% figure(3)
% skel_vis(dataset(:,:,3))
% figure(4)
% skel_vis(dataset(:,:,8))

init_probs =[];

% for i=1:nb_classes
%     for j=1:nb_instances
%         init_probs(j,i)=nb_inst(i)/nb_instances;
%     end
% end
%mean(init_probs)
%init probs matrix
for i = 1:nb_instances
    y = rand(1,nb_classes);
    s = sum(y);
    init_probs = [init_probs; y/s];
end

skel_model;
nui_skeleton_conn = nui_skeleton_conn +1;
a=sum(nui_skeleton_conn(:,1));

[m,p] = em_pose_clustering(dataset,init_probs,nb_iter); 
%[m,p] = em_pose_clustering(dataset,init_probs,nb_iter,nui_skeleton_conn); 

%checking there is no nan or complex in probs
assert(sum(sum(isnan(p)))==0 && isreal(p)==1);

%nb_inst'/2045

%compute the class = corresponding to max probability
% TO CHANGE
[prob, classes] =max(p,[],2); 

%plotting the results to have a visual of the clustering
%how to read? ideally all chunk points would be at the same height and a
%height would be attained by one chunk only 
l=linspace(1,2045,2045);
figure
plot(l,classes,'dr')

%matrix of confusion (kind of): rows stand for classes, columns for predicted
%groups
%TO NOTE: the classes are not the same for the rows and columns: we dont
%classify wrt class 1 2 3 4 but all A's together B's together etc
%ideally in a row we should have all the instances in one case and all
%other to 0
confusion = zeros(nb_classes,nb_classes)-1;
for i=1:nb_classes
    for j=1:nb_classes
        confusion(i,j) = sum(classes(labels==i)==j)/nb_inst(i);
    end
end
confusion

assert(a==sum(nui_skeleton_conn(:,1)));