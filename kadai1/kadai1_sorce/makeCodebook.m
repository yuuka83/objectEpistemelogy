%画像リスト,コードブックの名前，特徴量のサイズ，コードブックのサイズ
function codebook = makeCodebook(images,featureSize,codebookSize)
  %画像の枚数
  n = size(images,2);
  %特徴点抽出
  features=[];
  for i=1:n
    I=rgb2gray(imread(images{i}));
    p=createRandomPoints(I,featureSize);
    [f,p2]=extractFeatures(I,p);
    features=[features; f];
  end
  %kmeansでコードブックを作成(コードブックは，各クラスタの中心ベクトルの集合)
  [idx,codebook]=kmeans(features,codebookSize);

end