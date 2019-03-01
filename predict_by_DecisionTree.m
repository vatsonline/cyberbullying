function [s] = predict_by_DecisionTree(testFile,cyber_file, non_cyber_file)
curves=textread(testFile,'%s');

inside=textread('cyberbullying.txt','%s');
filename1 = textread(testFile,'%s');
filename2 = textread(non_cyber_file,'%s');
inside1 = filename1;
cellinside1=cellstr(inside1); 

cellArrayOfStrings1 = filename2;

index1 = ismember(cellArrayOfStrings1, cellinside1);
fid1 = fopen('filename1.txt', 'wt');
for k = 1 : length(index1)
  if index1(k)
      fprintf(fid1, '%s\n', cellArrayOfStrings1{k});
  end
end
f1 = textread('filename1.txt','%s');
non_cyber = cellstr(f1);
non_cyber_length = length(non_cyber);
fclose(fid1);

filename2 = textread(testFile,'%s');
filename3 = textread(cyber_file,'%s');
inside2 = filename2;
cellinside2=cellstr(inside2); 

cellArrayOfStrings2 = filename3;
index = ismember(cellArrayOfStrings2, cellinside2);
fid = fopen('filename2.txt', 'wt');
for k = 1 : length(index)
  if index(k)
      fprintf(fid, '%s\n', cellArrayOfStrings2{k});
  end
end
f2 = textread('filename2.txt','%s');
cyber = cellstr(f2);
cyber_length = length(cyber);
fclose(fid);
if cyber_length>non_cyber_length
    s = 1;
else
    s = 0;
end
end