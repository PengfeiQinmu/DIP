% script_show_noise
x=-4:.1:4;
subplot(321)
Y1=show_noise_pdf('gaussian',x, 0, 1);
plot(x,Y1);
title('��˹');
subplot(322)
Y2=show_noise_pdf('uniform',x, -3, 3);
plot(x,Y2);
title('����');
subplot(323)
Y3=show_noise_pdf('salt & pepper',x);
plot(x,Y3);
title('����');
subplot(324)
Y4=show_noise_pdf('rayleigh',x,1);
plot(x,Y4);
title('����');
subplot(325)
Y5=show_noise_pdf('exp',x,1);
plot(x,Y5);
title('ָ��');
subplot(326)
Y6=show_noise_pdf('gamma',x,2,5);
plot(x,Y6);
title('٤��');
