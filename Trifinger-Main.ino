// LIBRARIES
#include <Coordinates.h>
#include <math.h>
#include <Servo.h>

// PIN SETUP
// Vertical Acuator
const int dirPin1 = 3;
const int stepPin1 = 4;

// Horizontal Acuator
const int dirPin2 = 5;
const int stepPin2 = 6;

// Finger Tip
const int servoPin = 7;
const int feedbackPin = A15;
Servo servo;

// Global Variables
double thetas[] = {0, 0, 0};
int steps[] = {0, 0, 0};
int count1 = 0;
int count2 = 0;
int count3 = 0;
bool done = false;
int dir1;
int dir2;
const int fullFoldA = 25;
double theta1prev = 0; 
double theta2prev = (90 - fullFoldA); //we want the min to be 25 degree , max =
double theta3prev = 120;

// Code Functions
// Global Conversion
void globalAxisConversion(double r, double alpha, double z, double armNum) {

}

// Inverse Kinematics Formula
void inverseKinematics(double xf, double yf, double zf) {

  xf = -xf;
  yf = -yf;
  zf = -zf;

  double df = sqrt(sq(xf)+sq(yf)+sq(zf));
    
  double diagLength = 16;
  double tipLength = 13;
  
  
  double y2D = -sqrt(sq(yf) + sq(zf));
  double x2D = xf;

  double thetaVer = atan(yf / zf);
  double thetaTip = acos((sq(diagLength) + sq(tipLength) - sq(x2D) - sq(y2D)) / (2 * diagLength * tipLength));
  double thetaHor = M_PI - (atan(y2D / x2D) + atan(tipLength * sin(thetaTip) / (diagLength + tipLength * cos(thetaTip))));
  thetas[0] = thetaVer;
  thetas[1] = thetaHor;
  thetas[2] = thetaTip;

  return;
}

//Angle Conversion Formula
void angleConversion(double thetaVer, double thetaHor, double thetaTip) {

  int stepVer = round((thetaVer - theta1prev) * 100 * 9 / (M_PI));
  int stepHor = round((thetaHor - theta2prev) * 100 * 9 / (M_PI));
  int stepTip = round((thetaTip - theta3prev) * RAD_TO_DEG / 0.2);

  steps[0] = stepVer;
  steps[1] = stepHor;
  steps[2] = stepTip;

  return;
}

//Run Motors
void motorRun(int stepVer, int stepHor,int stepTip){

  int maxStep = max(stepVer, stepHor);
  maxStep = max(maxStep, stepTip);

  //stepper 1
  if (thetas[0] >= theta1prev){
    dir1 = HIGH;
  }
  else {
    dir1 = LOW;
  }
  //stepper 2
  if (thetas[1] >= theta2prev){
    dir2 = HIGH;
  }
  else {
    dir2 = LOW;
  }
  //servo
  double dAngle =  thetas[3] - theta3prev;
  //setting up previous variables
  theta1prev = thetas[0];
  theta2prev = thetas[1];
  theta3prev = thetas[2];

  for (int i = 0; i < maxStep; i++) {
    digitalWrite(dirPin1, dir1);
    if (i < stepVer) {
      count1 = count1 + 1;
      for (int x = 0; x < 4; x++) {
        digitalWrite(stepPin1, HIGH);
        delayMicroseconds(500);
        digitalWrite(stepPin1, LOW);
        delayMicroseconds(500);
      }
    }
    digitalWrite(dirPin2, dir2);
    if (i < stepHor) {
      count2 = count2 + 1;
      for (int x = 0; x < 4; x++) {
        digitalWrite(stepPin2, HIGH);
        delayMicroseconds(500);
        digitalWrite(stepPin2, LOW);
        delayMicroseconds(500);
      }
    }
    if (i < stepTip) {
      count3 = count3 + 1;
      double angle = theta3prev + i * dAngle ;
      servo.write(angle);
    }
  }
  
}


void setup() {

  Serial.begin(9600);

  pinMode(stepPin1, OUTPUT);
  pinMode(dirPin1, OUTPUT);
  pinMode(stepPin2, OUTPUT);
  pinMode(dirPin2, OUTPUT);

  servo.attach(servoPin);
  pinMode(feedbackPin, OUTPUT);


}

void loop() {

  if(done == false){
    double xf = 10;
    double yf = 21;
    double zf = 10;
  
    inverseKinematics(xf, yf, zf);
    angleConversion(thetas[0], thetas[1], thetas[2]);
    motorRun(steps[0],steps[1],steps[2]);
    
    Serial.println(count1);
    Serial.println(count2);
    Serial.println(count3);
    Serial.println();
    Serial.println(steps[0]);
    Serial.println(steps[1]);
    Serial.println(steps[2]);
    Serial.println();
    
    done = true;
  }












}