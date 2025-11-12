

c = [1, 1, 1];  % Vetor de coeficientes (FIR Acumulador de 3 taps)
N = 6;
n = (0:N-1);

dt = 1;

x = zeros(N,1);

x(1:round(N/4)) = 0;
x(round(N/4)+1 : round(N/2)) = 1;
x(round(N/2)+1 : end) = 2;



y = x;


% 3. Convolução/Filtragem do sinal de entrada y(k) pelo filtro c(k)
% F = conv(y, c, 'same'); % O 'same' garante que F tenha o mesmo tamanho de y
F = filter(c, 1, y);
figure;

% Sinal de entrada (y)
plot(n, y, '-o', 'LineWidth', 3, 'Color', 'black', ...
    'MarkerSize', 14, 'MarkerFaceColor', 'white');
hold on;

% Sinal filtrado (F)
plot(n, F, '-^', 'LineWidth', 3, 'Color', 'cyan', ...
    'MarkerSize', 8, 'MarkerFaceColor', 'cyan');

title('Simulação de Filtro FIR Acumulador (3 Taps)');
ylabel('Amplitude');
xlabel('Ciclos de Clock (k)');
legend('Sinal de Entrada y(k)', 'Sinal Filtrado F(k)');
grid on;