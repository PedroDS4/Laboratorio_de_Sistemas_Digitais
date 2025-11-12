

c = [1, 1, 1]/3;  % Vetor de coeficientes (FIR de Média Móvel de 3 taps)
N = 100;
n = (0:N);

dt = 1;

x = zeros(N,1);
x(1:N/4) = 1;
x(N/4+1:N/2) = 2;
x(N/2+1:N+1) = 3;


ruido = 0.05*randn(length(n), 1);  % Ruído AWGN para experimentos com


y = x + ruido; 

% 3. Convolução/Filtragem do sinal de entrada y(k) pelo filtro c(k)
F = conv(y, c, 'same'); % O 'same' garante que F tenha o mesmo tamanho de y

figure;
plot(n, y, 'linewidth', 3, 'color', 'black'); 
hold on;
plot(n, F, 'linewidth', 4, 'color', 'cyan');
title('Simulação de Filtro FIR de Média Móvel(3 Taps)');
ylabel('Amplitude');
xlabel('Ciclos de Clock (k)');
legend('Sinal de Entrada y(k)', 'Sinal Filtrado F(k)');
grid on;