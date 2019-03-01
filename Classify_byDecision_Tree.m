
clear ; close all;
split=50;
%{
fprintf('\nPreprocessing sample tweets (cyberbullying.txt)\n');


file_contents = readFile('cyberbullying.txt');
word_indices  = process_tweets_decision(file_contents);
models = 'cyberbullying.txt';

fprintf('Word Indices: \n');
fprintf(' %d', word_indices);
fprintf('\n\n');

fprintf('Program paused. Press enter to continue.\n');
pause;



fprintf('\nExtracting features from sample(cyberbullying.txt)\n');
data = 'non_cyberbullying.txt';

file_contents = readFile('cyberbullying.txt');
word_indices  = process_tweets_decision(file_contents);
features      = tweet_Features_bydecision(word_indices);


fprintf('Length of feature vector: %d\n', length(features));
fprintf('Number of non-zero entries: %d\n', sum(features > 0));

fprintf('Program paused. Press enter to continue.\n');
pause;

%}

load('Train.mat');

fprintf('\nTraining the Decision Tree classifier\n')
if(split==80)
    f=200;
    g=700;
    s=2000;
    t=4000;
end
if(split==60)
    f=150;
    g=700;
    s=2401;
    t=4000;
end
if(split==50)
    f=200;
    g=1000;
    s=2001;
    t=4000;
end
C = 0.02;
%pause(10);
Xtest =  X(s:t,:);
ytest = y(s:t,:);
X = X(1:f,:);
y = y(1:f,:);
models = 'cyberbullying.txt';
for i=1:g
    ytest(i,1) = 1;
end

model = Decision_Train(X, y, C);

p = Decision_Predict(model, Xtest);
data = 'non_cyberbullying.txt';
fprintf('Decision Tree Accuracy: %f\n', mean(double(p == ytest)) * 100);
C = confusionmatrix(ytest,p)
TP = C(2,2);
TN = C(1,1);
FP = C(1,2);
FN = C(2,1);

fprintf('True Positive:%d\n',TP)
fprintf('False Positive:%d\n',FP)
fprintf('True Negative:%d\n',TN)
fprintf('False Negative:%d\n',FN)


%Recall or True Postivie Rate
TPR_Recall = TP/(TP+FN)
%Specificity
TNR = TN/(TN+FP);
%Precision
PPV_Precision = TP/(TP+FP)
%F-measure
F_measure = 2*TPR_Recall*PPV_Precision/(TPR_Recall+PPV_Precision) 
%Accuracy
Acc = (TP+TN)/(TP+TN+FP+FN)

%load('Test.mat');

%fprintf('\nEvaluating the tweet features using Decision Tree Algorithm on a test set ...\n')

%p = Decision_Predict(model, Xtest);

%fprintf('Test Accuracy: %f\n', mean(double(p == ytest)) * 100);
%pause;

%{

[weight, idx] = sort(model.w, 'descend');
vocabList = getVocab();

%fprintf('\nTop predictors of tweet: \n');
for i = 1:15
    fprintf(' %-15s (%f) \n', vocabList{idx(i)}, weight(i));
end
%}
%fprintf('\n\n');
%fprintf('\nProgram paused. Press enter to continue.\n');
%pause;

filename = 'Test.txt';

file_contents = readFile(filename);
word_indices  = process_tweets_decision(file_contents);
x             = tweet_Features_bydecision(word_indices);
p = Decision_Predict(model, x);
ps = predict_by_DecisionTree(filename,models,data);
fprintf('\nProcessed %s\n\nClassification: %d\n', filename, ps);
fprintf('(1 indicates Cyberbullying, 0 indicates Non-cyberbullying)\n\n');

