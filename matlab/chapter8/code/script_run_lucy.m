% script_run_lucy
% L-R�㷨ͼ��ԭ

%%
clear,clc
close all

%%
% ���̸�ͼ��
I=checkerboard(8);

%����ɢ����
PSF=fspecial('gaussian',7,10);

% ����Ϊ0.0001
SD=0.01;
In=imnoise(imfilter(I,PSF),'gaussian',0,SD^2);

%%
% ʹ��Lucy-Richardson�㷨��ͼ��ԭ
Dampar=10*SD;
LIM=ceil(size(PSF,1)/2);
Weight=zeros(size(In));

% Ȩֵweight����Ĵ�С��64*64
% ������ֵΪ0��4���ؿ�ı߽磬�������ض���1
Weight(LIM+1:end-LIM,LIM+1:end-LIM)=1;

% ��������Ϊ5
NumIt=5;
% ����deconvlucy��ʵ�ָ�ԭ
J1=deconvlucy(In,PSF,NumIt,Dampar,Weight);

% ��������Ϊ10
NumIt=10;
J2=deconvlucy(In,PSF,NumIt,Dampar,Weight);

% ��������Ϊ20
NumIt=20;
J3=deconvlucy(In,PSF,NumIt,Dampar,Weight);

% ��������Ϊ100
NumIt=100;
J4=deconvlucy(In,PSF,NumIt,Dampar,Weight);

%% ��ͼ
subplot(231);
imshow(I);
title('ԭͼ')

subplot(232);
imshow(In);
title('�˻�ͼ��')

subplot(233);
imshow(J1);
title('����5��')

subplot(234)
imshow(J2);
title('����10��')

subplot(235);
imshow(J3);
title('����20��')

subplot(236);
imshow(J4);
title('����100��')
