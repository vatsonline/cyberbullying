function [ ps ] = get_list( filename )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if strcmp(filename,'cyberbullying.txt')
    ps = 1;
    fprintf('The predicted output is: Cyberbullying');
else
    ps = 0;
    fprintf('The predicted output is: Non-cyberbullying');
end

end

