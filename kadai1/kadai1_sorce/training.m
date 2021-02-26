%線形svmの場合 特徴量とラベルを渡す，非線形svmか線形svmかを選択する
function model = training(F,labels,svmType)
  %モデル(線形SVM)
  if svmType == "linear"
      model = fitcsvm(F, labels,'KernelFunction','linear'); 
  %モデル(非線形SVM)
  elseif svmType == "rbf"
      model=fitcsvm(F,labels,'KernelFunction','rbf','KernelScale','auto');
  end
end

