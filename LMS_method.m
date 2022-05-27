[S1,Fs]=audioread('E:\fyp\Audios\pad.wav');
%source_1 = S1(:,1)/norm(S1(:,1));  %normalizing
%source_1 = (S1(:,1) - mean(S1(:,1)) )/std(S1(:,1));
source_1 = S1(:,1);

[S2,Fs]=audioread('E:\fyp\Audios\voice main1.wav');
%source_2 = S2(:,1)/norm(S2(:,1));  %normalizing
%source_2 = (S2(:,1) - mean(S2(:,1)) )/std(S2(:,1));
source_2 = S2(:,1);

[S3,Fs]=audioread('E:\fyp\Audios\rythm guitar 1.wav');
%source_2 = S2(:,1)/norm(S2(:,1));  %normalizing
%source_3 = (S3(:,1) - mean(S3(:,1)) )/std(S3(:,1));
source_3 = S3(:,1);

mixture = (S1+S2);    %/norm(S1+S2);
%mixture = (mixture - mean(mixture) )/std(mixture);
%---------------------------------------------------------------------------
%source 1 matrix

H=[]; % mixture = x , source = y , H = [x(n) x(n-1) x(n-2) .... -y(n-1) -y(n-2) .....]
H_estimate = [];
mix_row=[];
source_row=[];
T = 10000;   
start_time = 44100*10;
N = 10;
for i=start_time:start_time+T-1
   for j=1:N
       if(i-j<0)
           mix_element = 0;
       else
           mix_element = mixture(i-j+1,1);
       end
       
       if(i-j-1<0)
           source_element = 0;
       else
           source_element = -source_1(i-j,1);
       end
       mix_row = [mix_row  mix_element];
       source_row = [source_row  source_element];
   end
   H = [H ; mix_row source_row];
   H_estimate = [H_estimate; mix_row  zeros(1,length(source_row)) ];%we need this at the end section of the code
   mix_row = [];
   source_row = [];
end

y = S1(start_time:start_time+T-1 ,1);

%LMS method mixing matrixx

A = inv(H'*H)*H'*y; %filter coefficients

%--------------------------------------------------------------------------
estimate_source = zeros(1,T);
temporary_vector = zeros(1,N);
for k=1:T
   estimate_source_elemant = H_estimate(k,:)*A;
   estimate_source(1,k) = estimate_source_elemant;
   %estimate_source = (estimate_source - mean(estimate_source))/std(estimate_source);
   temporary_vector(1,1) = estimate_source_elemant;
   
   if(k<T-N)
       H_estimate(k+1,N+1:2*N)= -temporary_vector;
   else
       H_estimate(k,N+1:2*N)=zeros(1,N);
   end 
   temporary_vector = circshift(temporary_vector,1);
end

plot(1:T,estimate_source','r');hold on;
plot(1:T, source_1(start_time:start_time+T-1,1)' ,'b');legend('estimated source 1','source 1');
mse = sum((estimate_source.^2)'-source_1(start_time:start_time+T-1,1).^2)/T
    