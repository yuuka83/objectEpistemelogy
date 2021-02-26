%５クロスバリデーション
%1周目について
%   データを
%       1.ポジティブ8割+ネガティブ8割 → training （5で割った数が0ではない）
%       2.ポジティブ2割+ネガティブ2割 → eval（5で割った数が0）
%   に分ける，ラベルを作成
%   trainingで学習 ← ここが変化する
%                   (1)ヒストグラム+svm (2)bof+非線形svm (3)dcnnf+線形svm
%                   学習用のmファイルと分類用のmファイルをそれぞれ変えればいい
%   evalで分類の評価 accuracy（認識精度）を出す


%data_pos:ポジティブ画像の特徴量 data_neg:ネガティブ画像の特徴量
%ここが変更 特徴量の抽出 dcnnf
%net = alexnet;
%layer = 'fc7';
%data_pos = makeDcnnf(posList,net,layer);
%data_neg = makeDcnnf(negList,net,layer);
%カラーヒストグラムの場合
%colorhists = makeColorHists(traininglist);%200*64
%bof行列の場合

function accuracy = five_crossvalidation(data_pos,data_neg,svmType)
    cv=5;
    n_pos = size(data_pos,1);
    n_neg = size(data_neg,1);
    idx_pos=[1:n_pos];
    idx_neg=[1:n_neg];
    accuracy=[];

    % idx番目(idxはcvで割った時の余りがi-1)が評価データ
    % それ以外は学習データ
    for i=1:cv 
      %80枚ずつ 画像の特徴行列 n*d
      train_pos=data_pos(find(mod(idx_pos,cv)~=(i-1)),:);
      eval_pos =data_pos(find(mod(idx_pos,cv)==(i-1)),:);
      %20枚ずつ
      train_neg=data_neg(find(mod(idx_neg,cv)~=(i-1)),:);
      eval_neg =data_neg(find(mod(idx_neg,cv)==(i-1)),:);
    
      train=[train_pos;train_neg];
      eval=[eval_pos;eval_neg];

      train_label=[ones(size(train_pos,1),1); ones(size(train_neg,1),1)*(-1)];
      eval_label =[ones(size(eval_pos,1),1); ones(size(eval_neg,1),1)*(-1)];
      
      
      %学習 (学習用のmファイルを作りましょう)
      model = training(train,train_label,svmType);
      %分類 (分類用のmファイルを作りましょう)
      ac = classificationRate(eval,eval_label,model);
      accuracy = [accuracy ac];
    end
    fprintf('accuracy: %f\n',mean(accuracy));
end