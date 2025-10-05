Link da implementação virtual: https://www.tinkercad.com/things/laWzrBB5k3X-projeto2sdlabmdetinkercadshared


# Prática 3: Máquina de Estados Finitos

## Introdução

Para o terceiro projeto da disciplina, foi proposto a elaboração do projeto de uma FSM em protoboard, utilizando os CI's comerciais de flip-flops JK ou D. A FSM é mostrada abaixo:

![Esquemático da FSM proposta](figuras/fsm.png)

## Referencial Teórico

### Flip-Flop JK

O flip-flop J-K tem a prioridade de aprimorar o funcionamento circuito flip-flop R-S interpretando a condição \( S = R = 1 \) como um comando de inversão [tocci]. Especificamente:

- \( J = 1, K = 0 \): comando para ativar (*set*) a saída
- \( J = 0, K = 1 \): comando para desativar (*reset*) a saída
- \( J = K = 1 \): comando para inverter

A equação característica do Flip-Flop JK é:

\[
Q^{i+1} = J\ \overline{Q^i} + \overline{K}\ Q^{i}
\]

Outra característica interessante do Flip-Flop JK é que ele pode dividir a frequência do sinal digital da entrada, funcionando como divisor de frequência.

![Flip-Flop JK](figuras/FFJK.png)

### Flip-Flop D

O flip-flop D é um circuito utilizado em registradores, com a função de armazenar bits seletivamente [tocci]. A equação característica do flip-flop D é:

\[
Q^{i+1} = D \cdot clk^{\uparrow}
\]

Ou seja, a saída é igual à entrada nas bordas de subida do clock.

![Flip-Flop D](figuras/FFD.png)

### Conversor para 7 segmentos

Para mostrar o número no display de 7 segmentos, é necessário converter de BCD para decimal. Abaixo está a tabela verdade:

| Decimal | A | B | C | D | a | b | c | d | e | f | g |
|---------|---|---|---|---|---|---|---|---|---|---|---|
| 0 | 0 | 0 | 0 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 0 |
| 1 | 0 | 0 | 0 | 1 | 0 | 1 | 1 | 0 | 0 | 0 | 0 |
| 2 | 0 | 0 | 1 | 0 | 1 | 1 | 0 | 1 | 1 | 0 | 1 |
| 3 | 0 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 0 | 0 | 1 |
| 4 | 0 | 1 | 0 | 0 | 0 | 1 | 1 | 0 | 0 | 1 | 1 |
| 5 | 0 | 1 | 0 | 1 | 1 | 0 | 1 | 1 | 0 | 1 | 1 |
| 6 | 0 | 1 | 1 | 0 | 1 | 0 | 1 | 1 | 1 | 1 | 1 |
| 7 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 0 |
| 8 | 1 | 0 | 0 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
| 9 | 1 | 0 | 0 | 1 | 1 | 1 | 1 | 1 | 0 | 1 | 1 |

**Tabela:** Tabela verdade para display de 7 segmentos (0 a 9)

A lógica pode ser obtida e simplificada usando mapas de Karnaugh, resultando nas expressões:

- \( a = A + A'C +B'D' + BD \)
- \( b = A + C'D' + CD + A'B' \)
- \( c = A + BD' + CD + C' \)
- \( d = A + B'C'D' + CD' + A'B'C + BC'D \)
- \( e = B'C'D' + AC + AB + CD' \)
- \( f = A + C'D' + BD' + BC' \)
- \( g = A + BC' + CD' + B'C \)

O CI 74HC48 faz essa conversão para display catódico, porém no Tinkercad utilizou-se um Arduino UNO.

### Tabela de Implicação

Foi feita a tabela de implicação para a FSM, de forma a observar se existem estados iguais para reduzir complexidade.

![Tabela de Implicação](figuras/Tabela.png)

Pela tabela, as únicas células verdadeiras são B x D e E x F.

- Célula B x D: D = D; A = A; E = E; F = E.
- Célula E x F: B = B; F = E; D = D; F = E.

Conclusão: **E e F são equivalentes / B e D são equivalentes**.

A MDE simplificada é mostrada abaixo:

![Máquina de Estados Reduzida](figuras/MDE_Reduzida.png)

## Materiais e Métodos

### Materiais

| Componente | Quantidade |
|---|---|
| CI 74HC08 (Porta AND) | 2 |
| CI 74HC04 (Porta NOT) | 1 |
| CI 74HC32 (Porta OR) | 1 |
| CI 74HC48 (Decodificador BCD–7 segmentos) | 1 |
| CI 74HC74 (Flip-Flop tipo D) | 1 |
| Display de 7 segmentos catódico | 1 |
| Fonte de tensão | 1 |
| Gerador de sinais | 1 |
| Resistores Pull Down (10 kΩ) | 4 |
| Resistores (330 Ω) | 7 |

### Métodos

A implementação do circuito utilizou a seguinte codificação de estados:

\[
\begin{cases}
A = 00 \\
D = 01 \\
E = 10 \\
C = 11
\end{cases}
\]

A lógica de sequência é feita por sinais intermediários dos produtos entre os sinais de entrada \(u, y\) e os do estado atual \(S_1, S_0\):

\[
\begin{cases}
z = S_0 \\
T_1 = uS_0 + yS_1 \\
T_2 = uS_1'S_0' + u'y'S_0 + y'S_1 \\
S_0 = f_D(T_0) \\
S_1 = f_D(T_1)
\end{cases}
\]

Onde \(f_D\) é a função interna do flip-flop D. O circuito final está abaixo:

![Circuito Final](figuras/circuito_final.png)

## Implementação em Protoboard

A montagem foi feita em protoboard, conectando o CI 7483 para soma binária e o CI 7447 para conversão BCD para display de 7 segmentos, com resistores de limitação. A alimentação foi realizada via fonte 5V.

O circuito foi montado de acordo com o diagrama do somador BCD, conectando as entradas de soma ao CI 74HC283 e, caso o valor excedesse 6, utilizou-se um CI 74HC283 auxiliar para somar 6. O valor era corrigido de acordo com um circuito auxiliar com portas OR e AND, mostrado na figura 2. Assim, o resultado do somador auxiliar era convertido para ser exibido no display a partir do CI 7448.

Originalmente era necessário um segundo LED para exibir "1" ou "0" ao exceder 9, mas só foi preciso um LED para validação.

A Figura 2 mostra a implementação em protoboard:

![Implementação - Vista 1](figuras/bcd_proto1.png)
![Implementação - Vista 2](figuras/bcd_proto2.png)

## Implementação no Tinkercad

A montagem seguiu a mesma lógica no Tinkercad. Como o CI 74HC48 não existe na plataforma, utilizou-se um Arduino para a conversão BCD para display de 7 segmentos.

O sinal de clock foi uma onda quadrada com amplitude \(A = 5~V\), deslocamento \(V_{dc} = 2.5~V\) e frequência \(f = 1~Hz\), servindo apenas níveis lógicos de \(5~V\) ou \(0~V\).

Ao ligar, o circuito vai para o estado inicial A; para avançar para o próximo estado, a entrada \(u\) é colocada em 1, indo para \(D = 01\).

![Estado A](figuras/estado_A.png)
![Estado D](figuras/estado_D.png)

O código Arduino e a cópia do projeto Tinkercad estão disponíveis em:

https://github.com/PedroDS4/Laboratorio_Sistemas_Digitais/Projeto1

## Conclusão

Todas as transições de estados foram testadas em ambas implementações, e foi verificado que o circuito seguiu corretamente a lógica da máquina de estados proposta.
