//Second LED
// Definição dos pinos de entrada e saída
#define IN0_PIN 2
#define IN1_PIN 3
#define IN2_PIN 4
#define IN3_PIN 5

#define SEG_A  6
#define SEG_B  7
#define SEG_C  8
#define SEG_D  9
#define SEG_E  10
#define SEG_F  11
#define SEG_G  12

bool a, b, c, d, e, f, g;
bool in0, in1, in2, in3;
bool x[18];

void setup() {
  pinMode(IN0_PIN, INPUT);
  pinMode(IN1_PIN, INPUT);
  pinMode(IN2_PIN, INPUT);
  pinMode(IN3_PIN, INPUT);

  pinMode(SEG_A, OUTPUT);
  pinMode(SEG_B, OUTPUT);
  pinMode(SEG_C, OUTPUT);
  pinMode(SEG_D, OUTPUT);
  pinMode(SEG_E, OUTPUT);
  pinMode(SEG_F, OUTPUT);
  pinMode(SEG_G, OUTPUT);
}

void loop() {
  // Lendo entradas
  in0 = digitalRead(IN0_PIN);
  in1 = digitalRead(IN1_PIN);  
  in2 = digitalRead(IN2_PIN);
  in3 = digitalRead(IN3_PIN);
  
  // Expressões intermediárias e lógica booleana usando operadores da linguagem
  x[0] = in0;
  x[1] = !in1 && in2;
  x[2] = in2;
  x[3] = (!in0 && in2);
  x[4] = (!in1 && !in3);
  x[5] = (in1 && in3);
  x[6] = (!in2 && !in3);
  x[7] = (in2 && in3);
  x[8] = (!in0 && !in1);
  x[9] = (in1 && !in3);
  x[10] = !in2;
  x[11] = (!in1 && !in2 && !in3);
  x[12] = (in2 && !in3);
  x[13] = (!in0 && !in1 && in2);  
  x[14] = (in1 && !in2 && in3);
  x[15] = (in0 && in2);
  x[16] = (in0 && in1);
  x[17] = (in1 && !in2);

  // Saídas para cada led em função de soma de produtos
  a = (x[0] || x[3] || x[4] || x[5]); 
  b = (x[0] || x[6] || x[7] || x[8]);
  c = (x[0] || x[9] || x[7] || x[10]);
  d = (x[0] || x[11] || x[12] || x[13] || x[14]);
  e = (x[11] || x[15] || x[16] || x[12]);
  f = (x[0] || x[6] || x[9] || x[17]);
  g = (x[0] || x[17] || x[12] || x[1]);
  
  // Mandando a informação para a saída
  digitalWrite(SEG_A, a);
  digitalWrite(SEG_B, b);
  digitalWrite(SEG_C, c);
  digitalWrite(SEG_D, d);
  digitalWrite(SEG_E, e);
  digitalWrite(SEG_F, f);
  digitalWrite(SEG_G, g);
}
