% script_deconvreg.m
% Լ����С���˸�ԭ
%%
clear,clc
close all

%% �����˻�ͼ��
I=checkerboard(8);

% �˶�ģ���ĵ���ɢ����
PSF = fspecial('motion', 7, 45);

fprintf('����ɢ����:\n');
disp(PSF)

% ��ͼ������˶�ģ���˲�
Im1 = imfilter(I, PSF, 'circular');

% ��Ӹ�˹����
noise = imnoise(zeros(size(I)), 'gaussian', 0, 0.001);
Im = Im1 + noise;

%% ά���˲�
Iw = deconvwnr(Im,PSF,0.02);

%% Լ����С�����˲�
I=edgetaper(I,PSF);
Iz = deconvreg(Im, PSF, 0.2,[1e-7, 1e7]);

%% ��ͼ
subplot(221);
imshow(I,[])
title('ԭʼͼ��');

subplot(222);
imshow(Im, [])
title('�˻�ͼ��');

subplot(223)
imshow(Iw,[])
title('ά���˲�')

subplot(224)
imshow(Iz,[])
title('Լ����С�����˲�')
