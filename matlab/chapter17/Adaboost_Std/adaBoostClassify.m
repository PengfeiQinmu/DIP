
function [classLabel, sum] = adaBoostClassify( Data, CABoosted )
% ����ֵ:
%      Data - ���������ݾ���ÿ��һ������
%      CABoosted - CellArray ���ͣ���¼��ÿ�����������������Ϣ
%      nWL - ��������������
% ���ֵ:
%      classLabel - Data������

%��ʼ��m��n
[m n] = size(Data);
%��ʼ��sumΪ51��1�е�ȫ0����
sum = zeros(m, 1);

%�������������ؽ�����ε�ѭ����
nWL = length(CABoosted);
for iWL = 1:nWL
    %ȡ��Ȩ�غͽ����
    WL = CABoosted{iWL}.classifier;
    alfa = CABoosted{iWL}.alfa;
    mRes = Data(:, WL.iFeature) > WL.thres;
    fRes = Data(:, WL.iFeature) <= WL.thres;
    mRes = -1 * mRes;
    res = fRes + mRes;
    %�����Ϊ-1��Ϊ�����ȡ��
    if WL.direction == -1
        res = -1 * res;
    end
    %��ü�Ȩ�ۺϺ�Ľ����
    sum = sum + alfa * res;
end
%��sumת��Ϊ�ͱ�ǩͬ��״������
classLabel = -1* ones(m, 1);
ind = find(sum >= 0);
classLabel(ind) = 1;

