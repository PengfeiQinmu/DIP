function II = adp_median(I, Smax)
%   ����Ӧ��ֵ�˲�����
%   example:
%   F = adpmedian(g, Smax) ��ͼ��gִ������Ӧ��ֵ�˲�
%   ��3*3ģ�忪ʼ��һֱ����ֵSmax*Smax,Smax�Ǳ�1�������

if (Smax <= 1) || (Smax/2 == round(Smax/2)) || (Smax ~= round(Smax))
   error('SMAX must be an odd integer > 1.')
end

% ��ʼ��.
II = I;
II(:) = 0;
alreadyProcessed = false(size(I));

% ����.
for k = 3:2:Smax
   zmin = ordfilt2(I, 1, ones(k, k), 'symmetric');
   zmax = ordfilt2(I, k * k, ones(k, k), 'symmetric');
   zmed = medfilt2(I, [k k], 'symmetric');
   
   processUsingLevelB = (zmed > zmin) & (zmax > zmed) & ...
       ~alreadyProcessed; 
   zB = (I > zmin) & (zmax > I);
   outputZxy  = processUsingLevelB & zB;
   outputZmed = processUsingLevelB & ~zB;
   II(outputZxy) = I(outputZxy);
   II(outputZmed) = zmed(outputZmed);
   
   alreadyProcessed = alreadyProcessed | processUsingLevelB;
   if all(alreadyProcessed(:))
      break;
   end
end

II(~alreadyProcessed) = zmed(~alreadyProcessed);
