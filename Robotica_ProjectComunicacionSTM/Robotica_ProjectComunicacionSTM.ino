#include <Servo.h>

Servo g1;
Servo g2;
Servo g3;
Servo pinza;

int aChar; // Or whatever size you need
int i = 0;
int q[4];

double x1;
double x2;
double x3;
double x4;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(38400);
  g1.attach(3);
  g2.attach(4);
  g3.attach(5);
  pinza.attach(6); 

}

void loop() {
  // put your main code here, to run repeatedly:
  while(Serial.available() > 0)
  {
     aChar = Serial.read();
     q[i] = aChar; // Add the character to the array
     i++;   // Point to the next position   
  }

  i=0;
    
  x1=(0.00003*q[0]*q[0])+(0.696*q[0])+0.3691;  
  x2=(0.7061*q[1])-0.1662; 
  //x2=-0.000003*q[1]*q[1] + 0.7069*q[1] - 0.3615;
  x3=0.00002*q[2]*q[2] + 0.6993*q[2] + 0.1036;
  x4=q[3];
  g1.write(x1);
  g2.write(x2);
  g3.write(x3);
  pinza.write(x4);
  delay(100);

}

