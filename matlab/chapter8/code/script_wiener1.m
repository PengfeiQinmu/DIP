%script_wiener1
% ά���˲������˲�
clear; 
clc;

%%
I=imread('lena.bmp'); 

% ����Ҷ�任
[m,n]=size(I); 
FI=fft2(I);
FI=fftshift(FI);

% �˻�
k=0.0025; 
u=1:m;
v=1:n;
[u,v]=meshgrid(u,v);
H=exp((-k).*(((u-m/2).^2+(v-n/2).^2).^(5/6)));
G=FI.*H;

% �������
I0=real(ifft2(fftshift(G)));
I1=imnoise(uint8(I0),'gaussian',0,0.001);
figure(1)
imshow(I1);
imwrite(I1, 'lena_wn.bmp')


%% 
I1=imread('lena_wn.bmp');

%% ���˲�
I_new = rev_filter(I1, H, 48);
figure(2);
imshow(I_new)
title('���˲����');

%% ά���˲�
K=0.05;
I_new1 = wn_filter(I1, H, 48, K);
figure(3);
imshow(I_new1);
title('ά���˲����');
