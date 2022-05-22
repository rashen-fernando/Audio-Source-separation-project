% Rock.=1
% Jazz.=2
% Electronic Dance Music.=3
% Dubstep.=4
% Techno.=5
% Rhythm and Blues (R&B)=6
% Country.=7
% Pop.=8
% indie rock=9
% electro=10

%tyoe string
%data = [ instrumental mean ,instrumental variance ,vocal mean,vocal
%variance,male = 1/female = 0, genre] 

data = [string(instrumental_mean),string(instrumental_variance),string(vocal_mean),string(vocal_variance),"1","9","0"];
d = [d ;data];
writematrix(d,'mean_variance_dataset');
