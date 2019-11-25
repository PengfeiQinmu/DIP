function CABoosted = adaBoost( TrainData, label, nIter )
% Training : boosting the weak classifiers
% Input: 
%       TrainData - ѵ������
%       label - ���ǩ
%       nIter - ������������

pInd = find(label == 1);
nInd = find(label == -1);
nP = length(pInd);
nN = length(nInd);

% ��ʼ��Ȩ���������������ͷ������Լ���Ȩ�ؿ��Ա�֤ÿ�η���ʱ�����������ͷ����Ĺ���
% �����������ԶԶ���ڷ���������w����̫С���������٣������ã����ס����ۣ��Ĳ�������
w(pInd) = 1 / (2 * nP);
w(nInd) = 1 / (2 * nN);
%w = ones(1, (nP + nN));
%w = w/ sum(w);
eps = 0.001;
%eps = 0;

% ����nIter�������������������һ��ǿ������
for iIt = 1:nIter
    % ��һ�� w
    w = w / sum(w);
    
%     if(mod(iIt,10)==0)
%         disp([iIt,nIter]);
%     end
  
	WL = weakLearner(w,TrainData,label);
    CABoosted{iIt}.classifier = WL;
       
    
    
%     beta(iIt) = WL.error / (1 - WL.error);
%     alfa(iIt) = log( 1 / (beta(iIt) + eps) );

    
    
    nRes = TrainData(:, WL.iFeature) >= WL.thres;
    pRes = TrainData(:, WL.iFeature) < WL.thres;
    nRes = -1 * nRes;
    res = pRes + nRes;
    
    if WL.direction == -1
        res = -1 * res;
    end
    
%    w = w .* exp( log(beta(iIt) + eps) * ( 1-(res~=label) ) )'; % ����w ?????
    
   
   alfa(iIt) = (1/2) * log( (1-WL.error) / (WL.error + eps) ); 
   w = w .* exp( -alfa(iIt) * (label .* res) )';
   
    CABoosted{iIt}.alfa = alfa(iIt);    
    
    if WL.error < eps
        break;
    end
end
