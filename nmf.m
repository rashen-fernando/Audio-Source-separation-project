Fs=44100;
[s1,Fs]=audioread('E:\fyp\Audios\voice main1.wav');
[s2,Fs]=audioread('E:\fyp\Audios\pad.wav');
y=s1+s2;

% f1=figure('Name','voice');
% stft(s1(:,1)');
% f2=figure('Name','pad');
% stft(s2(:,1)');
% f3=figure('Name','mixure');
% stft(y(:,1));

[x,f,time]=stft(y(:,1));
theta=angle(x);
[W,H]=nnmf(abs(x),3);

%norm(x-W*H) ----> 1.4145e+05
mask1=[0*H(1,:) ; 0*H(2,:); 1*H(2,:)];
[s1_predict,t]=istft((W*mask1).*exp(j*theta) );

plot(t,s1_predict','r--');hold on;
plot(t,s1(:,1)','b');
legend('predicted source 1','source 1');