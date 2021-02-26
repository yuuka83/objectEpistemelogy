%問4_4バージョン CODEBOOK(500x64)とfeatures(42527x64)

function id = euclid_codebook(CODEBOOK,feature)
    row = size(CODEBOOK,1);%たて
    colomn = size(CODEBOOK,2);%横
    %初期化 
    X = zeros(row,row);
    %1つ目の行列
    f = repmat(feature,row,1);
    %2つめの行列
    CB = CODEBOOK;
    %要素ごとの差の二乗
    b = (f-CB).^2;
    %行ごとに足してルートをとって距離を計算 row*1行列
    kyori = sqrt(sum(b,2));
    %最小距離のインデックス
    [m,id] = min(kyori);
end