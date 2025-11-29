load fmcw_basic_a.mat
fc=77e9; %Carrier frequency
B=150e6; %Bandwidth
Tchirp=8e-6; %Chirp period
K=B/Tchirp; %Chirp slope
Nr=1024; %num of samples per Tchirp
Nd=128; %num of chirps per sample

t_resolution=Tchirp/(Nr-1);
t=(0:Nr-1)*t_resolution;
d=zeros(1,Nd);

s=cos(2*pi*(fc*t+0.5*K*(t.^2)));

%segment x1
x1_matrix=zeros(Nd,Nr);
for i=1:Nd
    x1_matrix(i,:)=x1(Nr*i-Nr+1:Nr*i);
end

%mixer then fft
mix=zeros(Nd,Nr);
mix_ffted=zeros(Nd,40960);
for i=1:Nd
    mix(i,:)=s.*x1_matrix(i,:);
    mix_ffted(i,:)=fftshift(abs(fft(mix(i,:),4096)));
end

plot(mix_ffted(4,:));
