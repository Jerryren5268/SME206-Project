load fmcw_basic_a.mat
fc=77e9; %Carrier frequency
B=150e6; %Bandwidth
Tchirp=8e-6; %Chirp period
K=B/Tchirp; %Chirp slope
Nr=1024; %num of samples per Tchirp
Nd=128; %num of chirps per sample
c=3e8; %speed of light
Fs=Nr/Tchirp; %sampling rate
N=2048;

%segment x1
x1_matrix=zeros(Nd,Nr);
for i=1:Nd
    x1_matrix(i,:)=x1(Nr*i-Nr+1:Nr*i);
end

f=(0:1023)*Fs/1024;
x1_ffted_matrix=zeros(Nd,N);
fm=zeros(Nd,1);

%find fm
for i=1:Nd
    x1_ffted_matrix(i,:)=fftshift(abs(fft(x1_matrix(i,:),N)));
end
% x : FFT bins
dis_max=c*Fs/(4*K);
x = linspace(-dis_max,dis_max,N);

% y : chirp index
y = 1:Nd;

% »­ 3D surface
figure;
surf(x, y, x1_ffted_matrix, 'EdgeColor', 'none');
xlabel('Distance');
ylabel('Chirp index');
zlabel('Magnitude');
title('2D FFT Magnitude of x1');
colorbar;

