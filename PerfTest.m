close all;
clear all;
%%
dur = zeros(1,1000);
t1 = zeros(1,1000);
t2 = zeros(1,1000);
for a=1:1000
A = rand(1000,1000);
B = rand(1000,1000);
tic
A = A/32;
t1(a)=toc;
tic
B= B/34;
t2(a)=toc;
dur(a)=t1(a)/t2(a);
a
end
%%
figure; 

subplot(211);
plot(t1); hold on;
plot(t2,'g'); hold off;
legend('A/32','A/34');
ylabel('time [s]');
xlabel('trial');
title('Duration where A=rand(1000,1000)');

subplot(212); plot(dur);
hold on; plot(ones(1,1000)*mean(dur),'r'); hold off;
ylabel('time [s]');
title('% difference');
ylim([0 1]);
xlabel('trial');