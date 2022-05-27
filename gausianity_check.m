Fs=44100;
t=linspace(0,5,Fs*7);
% s1=sin(10*t);
% s2=square(2*t);
% s3=sin(3*t);
% s4=sin(16*t);
%plot(t,s2);hold on;plot(t,s1)


[s1,Fs]=audioread('E:\fyp\Audios\piano.wav');
[s2,Fs]=audioread('E:\fyp\Audios\pad.wav');
[s3,Fs]=audioread('E:\fyp\Audios\voice main1.wav');
[s4,Fs]=audioread('E:\fyp\Audios\rythm guitar 1.wav');

S=s1(:,1)/max(s1(:,1))+s2(:,1)/max(s2(:,1))+s3(:,1)/max(s3(:,1))+s4(:,1)/max(s4(:,1));
pd = fitdist(S,'Normal');
y=pdf(pd,t);
figure;
histogram(S,'Normalization','pdf');
legend('Source 4');