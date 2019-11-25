function [classLabel, sum] = adaBoostClassify( Data, CABoosted )
% Input:
%      Data - ���������ݾ���ÿ��һ������
%      CABoosted - CellArray ���ͣ���¼��ÿ�����������������Ϣ

% Output:
%      classLabel - Data������
%      sum - ������Ϊ�������Ŷ���Ϣ

[m n] = size(Data);

sum = zeros(m, 1);

nWL = length(CABoosted);

for iWL = 1:nWL
    WL = CABoosted{iWL}.classifier;
    alfa = CABoosted{iWL}.alfa;
    pRes = Data(:, WL.iFeature) >= WL.thres;
    nRes = Data(:, WL.iFeature) < WL.thres;
    nRes = -1 * nRes;
    res = pRes + nRes;
    
    if WL.direction == -1
        res = -1 * res;
    end

    sum = sum + alfa * res;
end

classLabel =  ones(m, 1);
ind = find(sum >= 0);

classLabel(ind) = -1;


