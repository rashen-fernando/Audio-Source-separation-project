%mat lab audio data visualization
[ins1,Fs1] = audioread(); 
[ins2,Fs2] = audioread();    
[ins3,Fs3] = audioread(); 
[ins4,Fs4] = audioread(); 
ins1 = ins1(:,1);
ins2 = ins2(:,1);
ins3 = ins3(:,1);
ins4 = ins4(:,1);
%ins5 = ins5(:,1);
range = (1:44100*60);
mix = ins1(range,:)+ins2(range,:)+ins3(range,:);%ins5(range,:);
S1=stft(mix,Fs1,'Window',kaiser(256,5),'OverlapLength',220,'FFTLength',512);
S2=stft(ins4(range,:),Fs1,'Window',kaiser(256,5),'OverlapLength',220,'FFTLength',512);

dist = (1:256);
%maximum frequency
M1 = [];
for i=1:size(S1,2)
    [maximum,ind] = max(abs(S1(257:512,i)));
    M1 = [M1 ind];
end

%spectrum centeroid
C1 = [];


for i=1:size(S1,2)
    v = ceil(  (abs(S1(257:512,i))'*dist')/sum(abs(S1(257:512,i)))  );
    if(isnan(v))
        v=0;
    end
    C1 =[C1 v];
end





%maximum frequency
M2 = [];
for i=1:size(S2,2)
    [maximum,ind] = max(abs(S2(257:512,i)));
    M2 = [M2 ind];
end

%spectrum centeroid
C2 = [];


for i=1:size(S2,2)
    v = ceil(  (abs(S2(257:512,i))'*dist')/sum(abs(S2(257:512,i)))  );
    if(isnan(v))
        v=0;
    end
    C2 =[C2 v];
end
Distance_vactor_1 = C1-M1;
Distance_vactor_2 = C2-M2;
t = 1:size(Distance_vactor_1,2);
f1 = figure;
plot(t,Distance_vactor_1);hold on;
plot(t,Distance_vactor_2);
title(sprintf('distance between centroid and dominant freq '));
xlabel('frame no');
ylabel( 'frequency bins');
legend('instrumental','vocal (male)');

% histogram(Distance_vactor_2)
% xlabel('distances')
% ylabel( 'number of occurrence')
% title('Vocal')

% histogram(Distance_vactor_1)
% xlabel('distances')
% ylabel( 'number of occurrence')
% title('mix')

instrumental_mean = mean(Distance_vactor_1);
instrumental_variance = std(Distance_vactor_1);
vocal_mean = mean(Distance_vactor_2);
vocal_variance = std(Distance_vactor_2);