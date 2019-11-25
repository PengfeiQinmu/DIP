function I_new = rev_filter(I, H, threshold)
% ���˲���ԭ����
% I_new = rev_filter(I, H, threshold)
% I��ԭʼͼ��
% H�����ݺ���
% threshold:���˲��İ뾶
% I_new����ԭͼ��


% ��Ϊ��ɫͼ��תΪΪ�Ҷ�ͼ��
if ndims(I)>=3
    I=rgb2gray(I);
end

Id=im2double(I);

% ����Ҷ�任
f_Id=fft2(Id);
f_Id=fftshift(f_Id);
fH_Id=f_Id;

[M,N]=size(fH_Id);
% ���˲�
if threshold>M/2
    % ȫ�˲�
    fH_Id=fH_Id./(H+eps);
else
    %��һ���뾶��Χ�ڽ����˲�
    for i=1:M
        for j=1:N
            if sqrt((i-M/2).^2+(j-N/2).^2)<threshold
                fH_Id(i,j)=fH_Id(i,j)./(H(i,j)+eps);
            end
        end
    end
end


% ִ�и���Ҷ��任
fH_Id1=ifftshift(fH_Id);
I_new=ifft2(fH_Id1);
I_new=uint8(abs(I_new)*255);
