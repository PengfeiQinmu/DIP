% script_run_blind
% äȥ�����ԭ
%%
clear,clc
close all

%% �������̸�ͼ�񲢽����˻�
I = checkerboard(8);
PSF = fspecial('gaussian',7,10);
V = .0001;

% �˻�
BlurredNoisy = imnoise(imfilter(I,PSF),'gaussian',0,V);

%% ��ԭ
% Ȩֵ
Weight = zeros(size(I));
Weight(5:end-4,5:end-4) = 1;

% ����չ�����Ĺ���ֵ
InitPSF = ones(size(PSF));
[J P] = deconvblind(BlurredNoisy,InitPSF,20,10*sqrt(V),Weight);
subplot(221);
imshow(BlurredNoisy);
title('�˻�ͼ��');
subplot(222);
imshow(PSF,[]);
title('����չ����');
subplot(223);
imshow(J);
title('äȥ�����ԭ���');
subplot(224);
imshow(P,[]);
title('����Ĺ��Ƶ���չ����');
