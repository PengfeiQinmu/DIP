% script_inv_filter
%%
% ���˲�
I0=imread('lena_t.bmp');

% ��ֵΪ128
I_new1 = rev_filter(I0, H, 128);

% ��ֵΪ108
I_new2 = rev_filter(I0, H, 108);

% ��ֵΪ78
I_new3 = rev_filter(I0, H, 78);

% ��ֵΪ48
I_new4 = rev_filter(I0, H, 48);
si=zeros(M,N,1,4,'uint8');
si(:,:,1)=I_new1;
si(:,:,2)=I_new2;
si(:,:,3)=I_new3;
si(:,:,4)=I_new4;

% ��ͼ
figure
montage(si)
title('��ֵ�ֱ�Ϊ128,108,78,48')
