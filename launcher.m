clear all;
clc;


max_iters=50;

skel_model;
graph=nui_skeleton_conn;
dataload =load('data.mat');
NB_CLASSES=length(unique(dataload.labels))
data=dataload.data(:,:,1:20);
%random initialisation of probs
init_probs = ones(size(data,3),NB_CLASSES)*1/NB_CLASSES;
[model probs] = em_pose_clustering(data,init_probs,max_iters,graph);
% classify_instances(probs)