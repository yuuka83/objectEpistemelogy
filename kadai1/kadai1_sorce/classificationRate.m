function valid = classificationRate(F,labels,model)
  %分類
  [plabel,score]=predict(model,F);
  %分類率
  valid = numel(find(labels==plabel))/numel(labels);
end