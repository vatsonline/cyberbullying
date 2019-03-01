function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

C_trial = [0.01 0.03 0.1 0.3 1 3 10 30];
sigma_trial = C_trial;

m = size(C_trial,2);

% the error is defined as the fraction of the cross validation examples
% that were classified incorrectly. Initialise it to 1.
initial_error = 1;

for i=1:m
    for j=1:m
        model = svmTrain(X, y, C_trial(i), @(x1, x2) gaussianKernel(x1, x2, sigma_trial(j)));
        predictions = svmPredict(model, Xval);
        
        error = mean(double(predictions ~= yval));
        
        if error < initial_error
            initial_error = error;
            C_temp = C_trial(i);
            sigma_temp = sigma_trial(j);
        end
    end
end

C = C_temp;
sigma = sigma_temp;

% =========================================================================

end
