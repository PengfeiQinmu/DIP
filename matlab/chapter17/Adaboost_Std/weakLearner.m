function WL = weakLearner(w, TrainData, label)
% ����ֵ: w - Ȩ�طֲ�
%        TrainData - �����ֵ����ݼ�
%        label - ���ݼ��ı�ǩ
% ���ֵ: WL - �ṹ�壬���������������������Ϣ

%��ʼ����mΪ��������nΪÿ�������������Ŀ
[m n] = size(TrainData);

% search the best discriminative feature exhaustly
fInd = (label == 1); % ����������
mInd = (label == -1); % ����������

for iFeature = 1:n
    % �������ͷ�����iFeature������һά�ϵľ�ֵ��Ϊ������ֵ
    fMean = fInd' * TrainData(:, iFeature) / sum(fInd); % �����ľ�ֵ
    mMean = mInd' * TrainData(:, iFeature) / sum(mInd); % �����ľ�ֵ
    
    thres(iFeature) = (fMean + mMean) / 2; % ��iFeature��һά�����ϵķ�����ֵ
    %������ֵ��Ϊ���ˣ�С�ڵ���ΪŮ��
    mRes = TrainData(:, iFeature) > thres(iFeature);
    fRes = TrainData(:, iFeature) <= thres(iFeature);
    mRes = -1 * mRes;
    res = fRes + mRes;
    %ͨ����ǩ�������ĶԱȵó�������
    error(iFeature) = w * ( label ~=  res);
end
%ȡ�ô�������͵Ľ�����װ
[val, ind] = max(abs(error-0.5));
if error(ind) > 0.5
    % Ӧ���������������б�
    error(ind) = 1 - error(ind);
    WL.direction = -1;
else
    WL.direction = 1;
end
%��װ���
WL.iFeature = ind;
WL.error = error(ind);
WL.thres = thres(ind);

    
    
    
    
    
    
    
    
    
    
    
    
    
    


