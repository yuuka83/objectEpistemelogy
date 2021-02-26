function dcnnf = makeDcnnf(images,net,layer)
    net = net;
    imageNum = size(images,2);
    IM = [];
    for i=1:imageNum
        img = imread(images{i});
        reimg = imresize(img,net.Layers(1).InputSize(1:2)); 
        IM=cat(4,IM,reimg);
    end
    dcnnf = activations(net,IM,layer);  
    dcnnf = squeeze(dcnnf);
    dcnnf = dcnnf/norm(dcnnf);
    %n*dに整形
    dcnnf = dcnnf';
end