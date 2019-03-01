function x = tweet_Features_bydecision(word_indices)

n = 1899;

x = zeros(n, 1);


m = length(word_indices);

for i=1:m
    x(word_indices(i)) = 1;
end    

end
