function WL = weakLearner(w, TrainData, label)
% input: w - Sample Weight
%        TrainData - data to be classified
%        label - the class label of TrainData
% output: WL - �ṹ�壬���������������������Ϣ
%               WL.


[m n] = size(TrainData);





% search the best discriminative feature exhaustly
pInd = (label == 1); % ����������
nInd = (label == -1); % ����������

for iFeature = 1:n
    % �������ͷ�����iFeature������һά�ϵľ�ֵ��Ϊ������ֵ
    pMean = pInd' * TrainData(:, iFeature) / sum(pInd); % �����ľ�ֵ
    nMean = nInd' * TrainData(:, iFeature) / sum(nInd); % �����ľ�ֵ
    
    thres(iFeature) = (pMean + nMean) / 2; % ��iFeature��һά�����ϵķ�����ֵ
    
    nRes = TrainData(:, iFeature) >= thres(iFeature);
    pRes = TrainData(:, iFeature) < thres(iFeature);
    nRes = -1 * nRes;
    res = pRes + nRes;
    
    error(iFeature) = w * ( label ~=  res);
end

[val, ind] = max(abs(error-0.5));
if error(ind) > 0.5
    % Ӧ���������������б�
    error(ind) = 1 - error(ind);
    WL.direction = -1;
else
    WL.direction = 1;
end

WL.iFeature = ind;
WL.error = error(ind);
WL.thres = thres(ind);

    
    
    
    
    
    
    
    
    
    
    
    
    
    

