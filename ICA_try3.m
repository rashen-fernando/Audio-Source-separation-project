[s1,Fs1]=audioread("D:\The Largest Multitrack Music Collection Ever! (2013) PACK 11\Kaiser Chiefs\26 Kaiser Chiefs - Never Miss A Beat\song.ogg");
[s2,Fs1]=audioread("D:\The Largest Multitrack Music Collection Ever! (2013) PACK 11\Lacuna Coil\61 Lacuna Coil - Closer\song.ogg");

range = (1:44100*60);
t=linspace(0,1,length(range));

Fs=44100;
t=linspace(0,20,0.1*Fs);
s1=sin(10*t);
s2=square(2*t);

%s1 = s1(range,1);
%s2 = s2(range,1);
S = [s1' s2'];
A = [0.5 0.77;0.4 0.2]; %mixing matrix

x1 = A(1,:)*S';
x2 = A(2,:)*S';

X=[x1 ; x2]; %size(X) = 2*26400..

m=mean(X');
X=X'-m;
[E,D] = eigs(cov(X));
X_white = E * sqrt(inv(D)) * E' * X';
X=abs(X_white);

pd = makedist('Normal');
W1 = rand(1,2) %size 1 2
W2 = rand(1,2)

lr = 2;

estimate1 = W1*X;
kurt1 =abs( kurtosis(estimate1) );

dkurt_w1_1 = rand; %random initialization
dkurt_w1_2 = rand;
dkurt_w2_1 = rand;
dkurt_w2_2 = rand;
dW1 = [dkurt_w1_1 dkurt_w1_2];
dW2 = [dkurt_w2_1 dkurt_w2_2];
for i = 1:50
    prev_kurt1 = kurt1;
    prev_W1 = W1;
    W1 = W1+lr*dW1;
    estimate1 = W1*X;
    kurt1 =abs( kurtosis(estimate1) );
    dkurt_w1_1  = (kurt1-prev_kurt1)/(W1(1,1)-prev_W1(1,1));
    dkurt_w1_2  = (kurt1-prev_kurt1)/(W1(1,2)-prev_W1(1,2));
    dW1 = [dkurt_w1_1 dkurt_w1_2];
    scatter(i,kurt1,'r');hold on;xlabel('iteration');ylabel('kurtosis');
end

X=X-rand(2,1)*estimate1;
m=mean(X');
X=X'-m;
[E,D] = eigs(cov(X));
X_white = E * sqrt(inv(D)) * E' * X';
X=abs(X_white);
estimate2 = W2*(X);
kurt2 =abs( kurtosis(estimate2) );

for i = 1:50
    prev_kurt2 = kurt2;
    prev_W2 = W2;
    W2 = W2+lr*dW2;
    estimate2 = W2*X;
    kurt2 =abs( kurtosis(estimate2) );
    
    
    dkurt_w2_1  = (kurt2-prev_kurt2)/(W2(1,1)-prev_W2(1,1));
    dkurt_w2_2  = (kurt2-prev_kurt2)/(W2(1,2)-prev_W2(1,2));
    
    dW2 = [dkurt_w2_1 dkurt_w2_2];
    scatter(i,kurt2,'b');hold on;xlabel('iteration');ylabel('kurtosis2');
end

subplot(4,1,1)
plot(t,s1,'b');
ylabel('source 1');xlabel('time');


subplot(4,1,2)
plot(t,s2,'b');
ylabel('source 2');xlabel('time');


subplot(4,1,3)
plot(t,estimate1,'r');
ylabel('estimate1');xlabel('time');

subplot(4,1,4)
plot(t,estimate2,'r');
ylabel('estimate2');xlabel('time');


%scatter(estimate1,s1);xlabel('estimated signal 1');ylabel('source signal 1')
%scatter(estimate2,s2,'r');hold on;scatter(estimate2,s1,'b');xlabel('estimated signal 2');ylabel('source signal');legend('source2','source1')
%ob1= scatter(estimate2,s1,'r');hold on;ob2=scatter(estimate2,s2,'b');xlabel('estimated signal 2');ylabel('source signal');legend('source1','source2');hold off;alpha(ob2,.01);
%scatter(estimate1,s1,'r');hold on;scatter(estimate1,s2,'b');xlabel('estimated signal 1');ylabel('source signal');legend('source1','source2')