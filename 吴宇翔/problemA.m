syms t
f_c=77*10^9;
c=3*10^8;
B=150*10^6;
chirp=8*10^(-6);
K=B/chirp;
T_s=chirp/1024;
f_m=f_c+K*t;
F=fftshift(fft(x1));
f_s=1/T_s;
N=length(x1);
f=[-N/2:N/2-1]*(f_s/N);
F_pos = abs(F(N/2+1:end));

f_pos = (0:N/2)*(f_s/N);%ªÒ»°’˝∞Î÷·
plot(f,abs(F))
[~, idx] = max(F_pos);
peak_freq = f_pos(idx);

d=peak_freq/K*c/2;
disp(d)