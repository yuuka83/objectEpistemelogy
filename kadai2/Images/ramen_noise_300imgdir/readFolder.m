%フォルダ内の画像の読み込み
function list = readFolder(folderName)
    list = {};
    DIR = folderName + "/";
    W = dir(DIR{:})
    for i = 3:size(W)
        imgName = DIR + W(i).name;
        list = {list{:} imgName};
    end
end