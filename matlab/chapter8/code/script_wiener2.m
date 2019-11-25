% script_wiener2
%%
clear,clc

% �����˻�ͼ��
I1=imread('lena_wn.bmp');

[m,n]=size(I1); 
k=0.0025; 
u=1:m;
v=1:n;
[u,v]=meshgrid(u,v);

% �˻�����
H=exp((-k).*(((u-m/2).^2+(v-n/2).^2).^(5/6)));

% �˻�ͼ���Ӧ�ĵ���ɢ����
PSF=ifftshift(ifft2(H));

% ά���˲�
I2 = deconvwnr(I1,abs(PSF),0.08);
imshow(I2);
title('ʹ��deconvwnr�˲�')
