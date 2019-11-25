%script_tuihua
% ����ԭʼͼ��
I = imread('lena.bmp');
figure(1);
subplot(121)
imshow(I)
title('ԭʼͼ��');
f=im2double(I);

% ����Ҷ�任
F = fft2(f);
F=fftshift(F);

% ִ���˻�
[M,N]=size(F);
[u,v]=meshgrid(1:M,1:N);
H=exp(-0.0025* ( (u-M/2).^2 + (v-N/2).^2 ) .^(5/6) );
F=F.*H;

% ����Ҷ���任
X=ifftshift(F);
x=ifft2(X);
subplot(122)
x=uint8(abs(x)*256);
imshow(x)
imwrite(x,'lena_t.bmp');
title('�˻�ͼ��')
