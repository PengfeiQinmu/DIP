function CABoosted = adaBoost( TrainData, label, nIter )
% Training : boosting the weak classifiers
% Input: 
%       TrainData - 训练数据
%       label - 类标签
%       nIter - 弱分类器个数

pInd = find(label == 1);
nInd = find(label == -1);
nP = length(pInd);
nN = length(nInd);

% 初始化权重向量，让正例和反例各自计算权重可以保证每次分类时都考虑正例和反例的贡献
% 否则如果正例远远大于反例，反例w比例太小，数量又少，其作用（贡献、代价）的不到体现
w(pInd) = 1 / (2 * nP);
w(nInd) = 1 / (2 * nN);
%w = ones(1, (nP + nN));
%w = w/ sum(w);
eps = 0.001;
%eps = 0;

% 建立nIter个弱分类器分量，组成一个强分类器
for iIt = 1:nIter
    % 归一化 w
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
    
%    w = w .* exp( log(beta(iIt) + eps) * ( 1-(res~=label) ) )'; % 更新w ?????
    
   
   alfa(iIt) = (1/2) * log( (1-WL.error) / (WL.error + eps) ); 
   w = w .* exp( -alfa(iIt) * (label .* res) )';
   
    CABoosted{iIt}.alfa = alfa(iIt);    
    
    if WL.error < eps
        break;
    end
end

