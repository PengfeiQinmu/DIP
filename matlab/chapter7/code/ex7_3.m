f=imread('D:\1.jpg');%����һ��ͼ
imshow(f);%��ʾ����ĻҶ�ͼ

[c,s]=wavefast(f,1,'sym4');%���á�sym4��С��������С���任
figure;wave2gray(c,s,-6);%����С��������ĺ�����ʾ�任��Ҷ�ͼ

[nc,y]=wavecut('a',c,s);%����С��������ĺ���������ϵ����0
figure; wave2gray(nc,s,-6);
edges=abs(waveback(nc,s,'sym4'));%��Եͼ����ع�
figure; imshow(mat2gray(edges));
