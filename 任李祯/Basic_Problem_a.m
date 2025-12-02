load fmcw_basic_a.mat
fc=77e9; %Carrier frequency
B=150e6; %Bandwidth
Tchirp=8e-6; %Chirp period
K=B/Tchirp; %Chirp slope
Nr=1024; %num of samples per Tchirp
Nd=128; %num of chirps per sample
c=3e8; %speed of light
Fs=Nr/Tchirp; %sampling rate

%segment x1
x1_matrix=zeros(Nd,Nr);
for i=1:Nd
    x1_matrix(i,:)=x1(Nr*i-Nr+1:Nr*i);
end

f=(0:1023)*Fs/1024;
x1_ffted_matrix=zeros(Nd,Nr);
fm=zeros(Nd,1);

%find fm
for i=1:Nd
    x1_ffted_matrix(i,:)=abs(fft(x1_matrix(i,:)));
    [~,idx]=max(x1_ffted_matrix(i,1:513));
    fm(i,1)= f(idx);
end

%find distance
dis=zeros(Nd,1);
dis=c.*fm/(2*K);
dis