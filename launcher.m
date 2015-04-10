clear all;
clc;

a = load('data.mat');

dataset=a.data;
labels=a.labels;
individuals=a.individuals;

%init probs matrix
nb_instances = size(dataset,3);
nb_classes = 3;
init_probs = (1/3)*ones(nb_instances,nb_classes);

%graph
nui_skeleton_conn =[0,1;1,2;2,3;2,4;4,5;5,6;6,7;2,8;8,9;9,10;10,11;0,12;12,13;13,14;14,15;0,16;16,17;17,18;18,19];
nui_skeleton_conn = nui_skeleton_conn +1;

[m,p] = em_pose_clustering(dataset,init_probs,5,nui_skeleton_conn); 