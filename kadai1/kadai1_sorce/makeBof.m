function bof = makeBof(images,codebook,featureSize)
    imageNum = size(images,2);
    codebookSize = size(codebook,1);
    features=[];
    %初期化 投票先
    bof=zeros(imageNum,codebookSize);
    for j=1:imageNum
        I=rgb2gray(imread(images{j}));
        p=createRandomPoints(I,featureSize);
        [f,p2]=extractFeatures(I,p);
        features=[features; f];
        for i=1:size(p2,1) 
        %一番近いcodebook中のベクトルを探してindexを求める．
          feature = features(i,:);
          index = euclid_codebook(codebook,feature);
          %bofヒストグラム行列のj番目の画像のindexに投票 
           bof(j,index)=bof(j,index)+1;
        end
    end
    
end