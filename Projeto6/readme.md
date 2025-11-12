# Prática 5: Filtro FIR

## Introdução
O sexto projeto proposto foi fazer, em VHDL, a implementação de um filtro digital do tipo **FIR (Finite Impulse Response)**, com 3 Taps (coeficientes).

![Esquemático do Filtro FIR Digital](figuras/Filtro_FIR.png)

## Referencial Teórico

Para a concepção deste projeto RTL, precisamos de alguns blocos operacionais para as operações a serem executadas, e também saber como funciona a lógica de um filtro FIR, como será discutido abaixo.

### Filtro FIR
Um filtro FIR (Finite Impulse Response) recebe essa nomeclatura porque sua resposta ao impulso tem suporte temporal finito, podendo ser facilmente implementado digitalmente por uma operação de convolução. Seja `y[k]` o sinal a ser filtrado e `h[k]` a resposta ao impulso do filtro, o sinal filtrado `x[k]` será dado por:

$$
x[k] = y[k] * c[k] = \sum_{n = 0}^{M} c[n]y[k-n]
$$

Para o caso com apenas três coeficientes (M = 3), temos:

$$
x[k] = y[k] * c[k] = \sum_{n = 0}^{2} c[n]y[k-n] = c[0]y[k] + c[1]y[k-1] + c[2]y[k-2]
$$

Seja ainda o filtro dado na forma vetorial por:

$$
c[k] = [c_0, c_1, c_2]
$$

Finalmente obtemos:

$$
x[k] = y[k] * h[k] = c_0y[k] + c_1y[k-1] + c_2y[k-2]
$$

Os coeficientes do filtro serão previamente armazenados nos registradores e usados na operação de filtragem.

---

### Somador de n bits
Utilizando o componente somador completo de 1 bit, é possível, cascateando n somadores em série, fazer um somador de **n bits**. Nesse caso, `n = 10`, como mostrado abaixo:

![Esquemático do Somador de n Bits](figuras/Somador_n_bits.png)

---

### Multiplicador de 8 bits
O circuito multiplicador é obtido de forma parecida. Sua expressão lógica pode ser consultada no livro do **Vahid**, e é mostrado o esquemático abaixo:

![Esquemático do multiplicador de 4 bits](figuras/Multiplicador_vahid.png)

O multiplicador de 4 bits resulta em uma saída de até 8 bits. Podemos usá-lo no projeto, fazendo a multiplicação apenas entre os bits menos significativos. Para garantir um intervalo de representação entre 0 e 1024, podemos ainda expandir para um multiplicador de 5 bits. Os produtos parciais são:

| A₄ | A₃ | A₂ | A₁ | A₀ | × | B₄ | B₃ | B₂ | B₁ | B₀ |
|----|----|----|----|----|---|----|----|----|----|----|
| P₈ | P₇ | P₆ | P₅ | P₄ | P₃ | P₂ | P₁ | P₀ |

Cada bit de saída é dado por:

1. \( P_0 = A_0B_0 \)  
2. \( P_1 = A_1B_0 + A_0B_1 \)  
3. \( P_2 = A_2B_0 + A_1B_1 + A_0B_2 \)  
4. \( P_3 = A_3B_0 + A_2B_1 + A_1B_2 + A_0B_3 \)  
5. \( P_4 = A_0B_4 + A_3B_1 + A_2B_2 + A_1B_3 + A_4B_0 \)  
6. \( P_5 = A_3B_2 + A_2B_3 + A_4B_1 \)  
7. \( P_6 = A_4B_2 + A_3B_3 + A_2B_4 \)  
8. \( P_7 = A_4B_3 + A_3B_4 \)  
9. \( P_8 = B_4A_4 \)

As somas representadas nesses bits de saída precisam ser feitas utilizando **somadores completos**, e não portas OR.

---

### Registrador de Carga Paralela
Como discutido anteriormente, é possível fazer registradores de carga paralela utilizando **multiplexadores** e **flip-flops tipo D**, produzindo um componente essencial para projetos RTL.

![Registrador de Carga Paralela](figuras/reg.png)

---

### Codificador 2x4 com Enable
Para multiplexar as colunas da matriz, precisamos de um **decodificador 3x8**. A tabela verdade é mostrada abaixo:

| eₙ | s₁ | s₀ | d₃ | d₂ | d₁ | d₀ |
|----|----|----|----|----|----|----|
| 1 | 0 | 0 | 0 | 0 | 0 | 1 |
| 1 | 0 | 1 | 0 | 0 | 1 | 0 |
| 1 | 1 | 0 | 0 | 1 | 0 | 0 |
| 1 | 1 | 1 | 1 | 0 | 0 | 0 |

As expressões lógicas são:

$$
\begin{cases}
d_0 = e_n \cdot s_1' \cdot s_0' \\
d_1 = e_n \cdot s_1' \cdot s_0 \\
d_2 = e_n \cdot s_1 \cdot s_0' \\
d_3 = e_n \cdot s_1 \cdot s_0
\end{cases}
$$

---

### Conversor BIN → BCD de 4 Dígitos
Para exibir os valores no display, convertemos 10 bits em 4 dígitos BCD (milhar, centena, dezena e unidade) utilizando o **algoritmo Double Dabble**.

$$
10000\ 00000_{bin} = 0101\ 0001\ 0010_{BCD} = 512_{decimal}
$$

O algoritmo realiza deslocamentos à esquerda e soma 3 aos nibbles maiores que 4 a cada passo.

---

### Display de 7 Segmentos
Para mostrar o número, convertemos cada dígito BCD em sinais para os LEDs do display.

| Decimal | A | B | C | D | a | b | c | d | e | f | g |
|----------|---|---|---|---|---|---|---|---|---|---|---|
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

Expressões lógicas simplificadas:

1. \( a = A + A'C + B'D' + BD \)  
2. \( b = A + C'D' + CD + A'B' \)  
3. \( c = A + BD' + CD + C' \)  
4. \( d = A + B'C'D' + CD' + A'B'C + BC'D \)  
5. \( e = B'C'D' + AC + AB + CD' \)  
6. \( f = A + C'D' + BD' + BC' \)  
7. \( g = A + B + C \)

---

## Materiais e Métodos

### Materiais
| Componente | Quantidade |
|-------------|-------------|
| FPGA Cyclone II | 1 |

### Métodos
Foram testadas três configurações de filtro FIR:

#### Filtro de Média Móvel
$$
c(k) = \frac{1}{3}[1, 1, 1]
$$

![Filtro de média móvel](figuras/media_movel.png)

#### Filtro Diferenciador
$$
c(k) = [1, -1, 0]
$$

![Filtro diferenciador](figuras/diferenciador.png)

#### Filtro Acumulador
$$
c(k) = [1, 1, 1]
$$

$$
F(k) = y[k] + y[k-1] + y[k-2]
$$

![Filtro acumulador](figuras/acumulador.png)

---

## Simulação no ModelSIM

Foram aplicados estímulos conforme a tabela:

| Tempo (ns) | Sinal | Valor |
|-------------|--------|-------|
| 0.00 | clk | Pulso periódico (0 → 1 a cada 0.125 ns) |
| 0.00 | clr_r | 1 |
| 0.00 | en_cod | 1 |
| 0.10 | s_cod | "00" |
| 0.30 | s_cod | "01" |
| 0.50 | s_cod | "10" |
| 0.80 | y | "0001" |
| 1.10 | y | "0010" |

A simulação confirma que para `y[k] = [0,1,2,2,2,2,...]` o resultado converge para `F[k] = 6`.

![Simulação no ModelSim](figuras/sim_modelsim_1.png)

**Código-fonte:**  
[GitHub - Projeto 6](https://github.com/PedroDS4/Laboratorio_de_Sistemas_Digitais/tree/main/Projeto6)



##**Implementação Na FPGA**
Foi então realizada a simulação na FPGA, onde os pinos foram mapeados de acordo com a imagem 
\ref{fig:Filtro_FIR}, e começamos definindo os coeficientes do filtro, com os seguintes comandos:


\begin{cases}
    c_{0,1,2} = SW[11:8]  \rightarrow 0001 \\
    s_{cod} = SW[17:16] \rightarrow 00 \\
    en_{cod} = SW[12] \rightarrow 1 \\
    c_{0,1,2} = SW[11:8] \rightarrow 0001 \\
    s_{cod} = SW[17:16] \rightarrow 01 \\
    en_{cod} = SW[12] \rightarrow 1 \\
    c_{0,1,2} = SW[11:8] \rightarrow 0001 \\
    s_{cod} = SW[17:16] \rightarrow 10 \\
    en_{cod} = SW[12] \rightarrow 1 \\
\end{cases}

depois de definir todos os coeficientes como sendo $c[k] = 1$, finalmente colocamos a entrada $y[k]$ e a carregamos, por fim carregando a saída

\begin{cases}
    y  = SW[7:4] \rightarrow 0001 \\
    ld_r SW[13] \rightarrow 1 \\
    ld_{out} = SW[14] \rightarrow 1 \\
    y  = SW[7:4] \rightarrow 0010 \\
\end{cases}

então $y$ ficou

$$
y[k] = [0,0,0,1,2,2,2,2,2,2]
$$

por fim foi possível ver que a saída seguiu o padrão crescente esperado, se estabilizando em $6$, de modo que 

$$
F[k] = [0,1,3,5,6,6,6,6,6,6]
$$

essa implementação é mostrada abaixo


![simulacao_fpgal](figuras/sim_fpga_1.jpeg)


![simulacao_fpga2](figuras/sim_fpga_2.jpeg)



e a implementação  foi validada com o professor

##**Conclusão**
O quinto projeto foi testado com sucesso, tanto na simulação temporal no modelsim tanto na FPGA, com o funcionamento confirmado pelo professor, e assim foi implementado o filtro FIR digital.

