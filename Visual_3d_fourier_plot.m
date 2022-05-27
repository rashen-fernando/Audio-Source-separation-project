
[y1,Fs] = audioread('voice main1.wav');
[y2,Fs] = audioread('shakerl left new.wav');
[y3,Fs] = audioread('rythm guitar 1.wav');
[y4,Fs] = audioread('piano.wav');
[y5,Fs] = audioread('pad.wav');
signal = y1+0.5*y2+0.25*y3+0.2+y4+0.24*y5;

Window_size=Fs/4;
no_of_windows=floor(size(signal(:,1))/Window_size);
no_of_windows=no_of_windows(1,1);

%Signal_broken_into_time_frames 
A_Right  =  reshape(signal(1:no_of_windows*Window_size,1),[no_of_windows,Window_size]);
A_Left  =  reshape(signal(1:no_of_windows*Window_size,2),[no_of_windows,Window_size]);
% b=abs(A_Right-A_Left);
% b=sum(b,'All')
Y=abs(fft(A_Right,[],2));
% j=1:Window_size;
% t=1:no_of_windows;
grid on();
for i=100:110
    for j=1:Window_size
        plot3(i,j,Y(i,j));
        
    end
end
hold off;
grid on;
