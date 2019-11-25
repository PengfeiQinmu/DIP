function [errTrain, errTest] = main(nWL)
% ���룺nWL - ѵ������������
% �����errTrain - ѵ�����Ĵ�����
%        errTest - ���Լ��Ĵ�����

load('faces_small.mat');
if nargin == 0
    nWL = 500;
end
% ѵ������
CABoosted = adaBoost( faces_small, faces_label, nWL );

% ����ѵ������
classLabel = adaBoostClassify( faces_small, CABoosted );
errTrain = sum(classLabel ~= faces_label) / length(faces_label);

clear classLabel
% ���ڲ�������
classLabel = adaBoostClassify( new_faces_small, CABoosted );
errTest = sum(classLabel ~= new_label) / length(new_label);