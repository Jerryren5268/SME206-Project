f_c=77*10^9;
c=3*10^8;
B=150*10^6;
chirp=8*10^(-6);
K=B/chirp;
T_s=chirp/1024;
N_fast=1024;
N_slow=128;
T_total=chirp*N_slow;
%change the dimension of x2 to 1024*128
x2 = reshape(x2, N_fast, N_slow);

%do the 2D fft
F=fft2(x2,N_fast,N_slow);
%do the fftshift
F_shifted = fftshift(fftshift(F, 1), 2);
%calculate the abs
range_doppler_map = abs(F_shifted);

f_fast=N_fast / chirp;%calculate the fast frequency axis
f_slow=1/chirp; %calculate the slow frequency axis

%resolution of distance
delta_R=c/(2*B);
%distance axis after fftshift
R_axis=(-N_fast/2:N_fast/2-1)*delta_R;

%calculation of the velocity axis
lambda = c/f_c;
%resolution of velocity
delta_v=lambda / (2*T_total);
%axis of velocity after fftshift
v_axis=(-N_slow/2:N_slow/2-1)*delta_v;

% ÕÒ×î´óÖµ
[max_val, idx] = max(range_doppler_map(:));
[r_idx, v_idx] = ind2sub(size(range_doppler_map), idx);

R_peak = R_axis(r_idx);
v_peak = v_axis(v_idx);

figure;
surf(v_axis, R_axis, range_doppler_map);
shading interp;
colormap jet;
colorbar;

xlabel('Velocity (m/s)');
ylabel('Range (m)');
zlabel('Amplitude');
title('3D Range-Doppler Map');

hold on;
plot3(v_peak, R_peak, max_val, 'wo', 'MarkerSize', 12, 'LineWidth', 2);
text(v_peak, R_peak, max_val, ...
     sprintf('  v=%.2f m/s, R=%.1f m', v_peak, R_peak), ...
     'Color','w','FontSize',12,'FontWeight','bold');

hold off;
view(45, 45);







