# Prática 6: Filtro FIR

## Introdução
O sexto projeto proposto foi fazer, em VHDL, a implementação de um filtro digital do tipo FIR (Finite Impulse Response), com 3 Taps (coeficientes).

![Esquemático do Filtro FIR Digital](figuras/Filtro_FIR.png)

## Referencial Teórico
Para a concepção deste projeto RTL, precisamos de alguns blocos operacionais para as operações a serem executadas, e também saber como funciona a lógica de um filtro FIR, como será discutido abaixo.

### Filtro FIR
Um filtro FIR recebe essa nomenclatura porque sua resposta ao impulso tem suporte temporal finito. O sinal filtrado $x[k]$ é dado pela convolução entre o sinal de entrada $y[k]$ e os coeficientes $c[k]$:

$$
x[k] = y[k] \ast c[k] = \sum_{n = 0}^{M} c[n] y[k-n]
$$

Para o caso com apenas três coeficientes ($M = 3$):

$$
x[k] = c_0 \cdot y[k] + c_1 \cdot y[k-1] + c_2 \cdot y[k-2]
$$



### Somador de n bits
Utilizando o componente somador completo de 1 bit, é possível cascatear $n$ somadores em série para fazer um somador de $n$ bits (neste caso $n = 10$).

![Esquemático do Somador de n Bits](figuras/Somador_n_bits.png)

### Multiplicador de 8 bits
O multiplicador de 4 bits resulta em uma saída de até 8 bits. Para garantir um intervalo de representação entre 0 e 1024, expandimos para um multiplicador de 5 bits.

#### Produtos Parciais (Multiplicação 5 bits)
| | | | | A4 | A3 | A2 | A1 | A0 |
|---|---|---|---|---|---|---|---|---|
| | | | $\times$ | B4 | B3 | B2 | B1 | B0 |
| | | | | B0A4 | B0A3 | B0A2 | B0A1 | B0A0 |
| | | | B1A4 | B1A3 | B1A2 | B1A1 | B1A0 | | |
| | | B2A4 | B2A3 | B2A2 | B2A1 | B2A0 | | | |
| | B3A4 | B3A3 | B3A2 | B3A1 | B3A0 | | | | |
| B4A4 | B4A3 | B4A2 | B4A1 | B4A0 | | | | | |

As somas devem ser feitas utilizando somadores completos para tratar corretamente o *carry-in* e *carry-out*.

### Codificador 2x4 com Enable
Utilizado para multiplexar as colunas da matriz, recebendo a chave SW e o enable.

#### Tabela Verdade: Decodificador 2x4
| e_n | s1 | s0 | d3 | d2 | d1 | d0 |
|:---:|:--:|:--:|:--:|:--:|:--:|:--:|
| 1 | 0 | 0 | 0 | 0 | 0 | 1 |
| 1 | 0 | 1 | 0 | 0 | 1 | 0 |
| 1 | 1 | 0 | 0 | 1 | 0 | 0 |
| 1 | 1 | 1 | 1 | 0 | 0 | 0 |

### Conversor BIN->BCD de 4 Dígitos
Converte os 10 bits de saída para exibição em display de 7 segmentos usando o algoritmo **Double Dabble**.

$$
10000 \ 00000_{bin} = 0101 \ 0001 \ 0010 _{BCD} = 512_{decimal}
$$

## Materiais e Métodos

### Materiais
| Componente | Quantidade |
|---|---|
| FPGA Cyclone II | 1 |

### Métodos
Foram utilizadas três configurações:
1.  **Média Móvel:** $c(k) = \frac{1}{3} [1,1,1]$. Útil para eliminar ruído.
2.  **Diferenciador:** $c(k) = [1,-1,0]$. Aproxima a derivada numérica.
3.  **Acumulador:** $c(k) = [1,1,1]$. Equação: $F(k) = y[k] + y[k-1] + y[k-2]$.

![Resultado do sinal filtrado com um filtro acumulador](figuras/acumulador.png)

## Simulação no ModelSIM
A simulação foi realizada via script `.do`. Com a entrada $y[k] = [0,1,2,2,2,2,2,...]$, o resultado estabilizou em $F[k] = 6$, condizente com a soma das últimas 3 amostras ($2+2+2$).

![Simulação no Modelsim: Saída Filtrada](figuras/sim_modelsim_1.png)

Os códigos VHDL estão disponíveis em:
[Projeto 6 - GitHub](https://github.com/PedroDS4/Laboratorio_de_Sistemas_Digitais/tree/main/Projeto6)

## Implementação Na FPGA
A implementação foi validada definindo os coeficientes via chaves (SW) e observando a saída estabilizada em 6 no display, conforme esperado para o filtro acumulador.

![Implementação na FPGA: Instante $k = 3$](figuras/sim_fpga_1.jpeg)
![Implementação na FPGA: Instante $k = 4$](figuras/sim_fpga_2.jpeg)

## Conclusão
O projeto foi testado com sucesso na simulação e na FPGA, confirmando o funcionamento do filtro FIR digital de 3 taps.
