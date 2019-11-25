%�źź�������
	%  1.���Ҳ�����
	f1=50;  		%  Ƶ��1
	f2=100; 		%  Ƶ��2
	fs=2*(f1+f2);  	%  ����Ƶ��
	Ts=1/fs;  		%  �������
	N=120;    		%  ��������
	n=1:N;
	y=sin(2*pi*f1*n*Ts)+sin(2*pi*f2*n*Ts);  %  �źź���

% 2С���˲����׷���
	h=wfilters('db30','l');  %  ��ͨ
	g=wfilters('db30','h');  %  ��ͨ

	h=[h,zeros(1,N-length(h))];  %  ���㣨Բ�ܾ����������ֱ��ʱ��ڹ۲죩
	g=[g,zeros(1,N-length(g))];  	%  ���㣨Բ�ܾ����������ֱ��ʱ��ڹ۲죩

% 3 MALLAT�ֽ��㷨(Բ�ܾ���Ŀ��ٸ���Ҷ�任ʵ��)
	sig1=ifft(fft(y).*fft(h));  	%  ��ͨ(��Ƶ����)
	sig2=ifft(fft(y).*fft(g));  	%  ��ͨ(��Ƶ����)

%4 MALLAT�ع��㷨
	sig1=dyaddown(sig1); 		%  2��ȡ
	sig2=dyaddown(sig2); 		%  2��ȡ

	sig1=dyadup(sig1);   		%  2��ֵ
	sig2=dyadup(sig2);   		%  2��ֵ

	sig1=sig1(1,[1:N]);  		%  ȥ�����һ����
	sig2=sig2(1,[1:N]);  		%  ȥ�����һ����

	hr=h(end:-1:1);         		%  �ع���ͨ
	gr=g(end:-1:1);         		%  �ع���ͨ

	hr=circshift(hr',1)';   		%  λ�õ���Բ������һλ
	gr=circshift(gr',1)';   		%  λ�õ���Բ������һλ

	sig1=ifft(fft(hr).*fft(sig1));  	%  ��Ƶ
	sig2=ifft(fft(gr).*fft(sig2));  	%  ��Ƶ

	sig=sig1+sig2; 		%  Դ�ź�
