load noiswom
[swa,swh,swv,swd]=swt2(X,3,'db1');

% ʹ��db1С����noiswomͼ��������㾲̬С���ֽ�
whos
% ���Կ�����swt2��С���ֽ�ͬ�����ı��źŵĳ��ȣ�ԭ����96��96��ͼ
% ����������ֽ��Ժ󣬷ֽ�ϵ����12��96��96��ͼ��
colormap(map)
kp=0;
for i=1:3
subplot(3,4,kp+1),image(wcodemat(swa(:,:,i),192));
title(['Approx,cfs,level',num2str(i)])
% ��ʾ��i�����ϵ��ͼ����192�ֽ�Ϊ��λ����  
subplot(3,4,kp+2),image(wcodemat(swh(:,:,i),192));
title(['Horiz.Det.cfs level',num2str(i)])
subplot(3,4,kp+3),image(wcodemat(swv(:,:,i),192));
 title(['Vert.Det.cfs level',num2str(i)])
subplot(3,4,kp+4),image(wcodemat(swd(:,:,i),192));
title(['Diag.Det.cfs level',num2str(i)])
kp=kp+4;
end %ͼ��ֽ����

%ͼ���ع�
load noiswom
[swa,swh,swv,swd]=swt2(X,3,'db1');

% ʹ��db1С����noiswomͼ���������С���ֽ�
mzero=zeros(size(swd));
A=mzero;
A(:,:,3)=iswt2(swa,mzero,mzero,mzero,'db1');

% ʹ��iswt2���˲������ܣ��ؽ���3��Ľ���ϵ����Ϊ�˱���iswt�ĺ�
% �����㣬ע�����ؽ������У�Ӧ��֤��������ϵ��Ϊ�㡣
H=mzero;V=mzero;D=mzero;
for i=1;3
swcfs=mzero;swcfs(:,:,i)=swh(:,:,i);
H(:,:,i)=iswt2(mzero,swcfs,mzero,mzero,'db1');
swcfs=mzero;swcfs(:,:,i)=swv(:,:,i);
V(:,:,i)=iswt2(mzero,mzero,swcfs,mzero,'db1');
swcfs=mzero;swcfs(:,:,i)=swh(:,:,i);
H(:,:,i)=iswt2(mzero,mzero,mzero,swcfs,'db1');
end

% �ֱ��ؽ�1~3���ĸ���ϸ��ϵ����ͬ�����ؽ�ĳһ���յ�ʱ��Ҫ������ϵ��Ϊ0
A(:,:,2)=A(:,:,3)+H(:,:,3)+V(:,:,3)+D(:,:,3);
A(:,:,1)=A(:,:,2)+H(:,:,2)+V(:,:,2)+D(:,:,2);

% ʹ�õ��Ƶķ���������1��͵�2�����ϵ��
colormap(map)
kp=0;
for i=1:3
subplot(3,4,kp+1),image(wcodemat(A(:,:,i),192));
title(['��',num2str(i),'�����ϵ��ͼ��'],'fontsize',6)
subplot(3,4,kp+2),image(wcodemat(H(:,:,i),192));
title(['��',num2str(i),'��ˮƽϸ��ϵ��ͼ��'],'fontsize',6)
subplot(3,4,kp+3),image(wcodemat(V(:,:,i),192));
title(['��',num2str(i),'����ֱϸ��ϵ��ͼ��'],'fontsize',6)
subplot(3,4,kp+4),image(wcodemat(D(:,:,i),192));
title(['��',num2str(i),'��Խ�ϸ��ϵ��ͼ��'],'fontsize',6)
kp=kp+4;
end