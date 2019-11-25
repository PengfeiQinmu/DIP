function CABoosted = adaBoost( TrainData, label, nIter )
% ѵ�� :������������
% ����ֵ: 
%       TrainData - ѵ������
%       label - ���ǩ
%       nIter - ������������

fInd  = find(label == 1);
mInd = find(label == -1);
fP = length(fInd);
nP = length(mInd);

% ��ʼ��Ȩ���������������ͷ������Լ���Ȩ�ؿ��Ա�֤ÿ�η���ʱ�����������ͷ����Ĺ���
% �����������ԶԶ���ڷ���������w����̫С���������٣������ã����ס����ۣ��Ĳ�������
w(fInd) = 1 / (2 * fP);
w(mInd) = 1 / (2 * nP);

%��ʼ��һ����С�Ĵ����ʣ�������һ��������������С�ڸ�ֵ��
%��÷���������������Խ��ܳ�Ϊ���ս��
eps = 0.001;


% ����nIter�������������������һ��ǿ������
for iIt = 1:nIter
    % ��һ�� w
    w = w / sum(w);
    %����һ����������������ֲ���ѵ��������ǩ����
	WL = weakLearner(w,TrainData,label);
    
    CABoosted{iIt}.classifier = WL;
       
    
    mRes = TrainData(:, WL.iFeature) > WL.thres;
    fRes = TrainData(:, WL.iFeature) <= WL.thres;
    mRes = -1 * mRes;
    res = fRes + mRes;
    %�����Ϊ-1��Ϊ�����ȡ��
    if WL.direction == -1
        res = -1 * res;
    end
   %����a�����������������ؽ�����¹���ֲ�����С��ȷ�����Ȩ��ͬʱ���Ӵ�����Ȩ��
   alfa(iIt) = (1/2) * log( (1-WL.error) / (WL.error + eps) ); 
   w = w .* exp( -alfa(iIt) * (label .* res) )';
   %Ϊ���������ôν����Ȩ��
    CABoosted{iIt}.alfa = alfa(iIt);    
    %����ô����������Ĵ�����С��eps�������Ϊ���������ȷ�����Խ���
    if WL.error < eps
        break;
    end
end

