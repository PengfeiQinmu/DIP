function Y = show_noise_pdf(type, x, a, b)
% show_noise_pdf ��ʾ��ͬ�����ĸ����ܶȺ���.
% type:  �ַ�����ȡֵ�������������
% ��˹����:     gaussian������Ϊ(x,y)��Ĭ��ֵΪ(0,10)
% ��������:     rayleigh������Ϊx��Ĭ��ֵΪ30
% ٤������:     gamma������Ϊ(x,y),Ĭ��ֵΪ(2,10)
% ָ��������    exp������Ϊx,Ĭ��ֵΪ15
% ���ȷֲ���    uniform������Ϊ(x,y)��Ĭ��ֵΪ(-20,20)
% ����������    salt & pepper: ǿ��Ϊx��Ĭ��ֵΪ0.02
% example:
% x=0:.1:10;
% Y=show_noise_pdf('gamma',2,5,x);
% plot(x,Y)

% ����Ĭ����������
if  nargin == 1
    type='gaussian';
end

% ��ʼ����
switch lower(type)
     %��˹���������
    case 'gaussian'
        if nargin<4
            b=10;
        end
        if nargin <3
            a=0;
        end
        Y=normpdf(x,a,b);
        
        %�������������
    case 'uniform'
        if nargin<4
            b=3;
        end
        if nargin <3
            a=-3;
        end
        Y=unifpdf(x,a,b);
        
        %�������������
    case 'salt & pepper'
 
        % ����imnoise����
        Y=zeros(size(x));
        Y(1)=0.5;
        Y(end)=0.5;
        
        %�������������
    case 'rayleigh'
        if nargin < 3
            a = 30;
        end
        Y=raylpdf(x,a);
        
        %ָ�����������
    case 'exp'
        if nargin < 3
            a = 15;
        end
        Y=exppdf(x,a);
        
        %٤�����������
    case 'gamma'
        if nargin <4
            b=10;
        end
        if nargin<3
            a=2;
        end
        Y=gampdf(x,a,b);
    
    otherwise
        error('Unknown distribution type.')
end
