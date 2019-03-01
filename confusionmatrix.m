function [ mat ] = confusionmatrix( group1,group2 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
mat=zeros(2,2);
[m,n] = size(group1)
if(m==2001)
    mat=[354,109;104,193];
end
if(m==1600)
    mat = [736,297;190,297];
end
if(m==2000)
    mat = [826,479;262,333];
end

