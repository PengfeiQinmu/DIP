% de_motion.m
clear, clc
close all

%% ����ͼƬ
I=imread('bicycle.bmp');
if ndims(I)>=3
    I=rgb2gray(I);
end
figure(1);
imshow(I,[])
title('�˶�ģ��ͼ��');

%% ȥ���˶�ģ��

% ˮƽ�������˶�20����
PSF=fspecial('motion', 20,0);

figure(2);
% ������������
noise_var = 0.0001;
estimated_nsr = noise_var / var(double(I(:)));

% ά���˲�
I2 = deconvwnr(I,PSF,0.00005);
imshow(I2,[]);
title('ά���˲���ԭ');
