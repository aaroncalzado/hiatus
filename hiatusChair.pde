/*
PROJECT TITLE: Anti-Office Injury Chair
CODE NAME: [Frank]enstein (Tentative)
DESIGNERS: Aaron Calzado, Kelly Graham
CLASS: ART 387 Physical Interaction Design Sping 2012
ADVISOR: Dominic Muren


*/


//Define the sensors
const int seat = 12;
const int fwdStop = 2;
const int revStop = 4;

//Define the motors
const int fwd = 7;
const int rev = 8;


//Define the stages in the process
int seatButton = 0;
int stopButton = 0;
int finishButton = 0;


//This activates the moter and keeps it on
boolean movingBackwards = false;
boolean movingForwards = false;

//seatButton "holding" stuff
int seatFirstTime = 1;
unsigned long seatStartTime;
unsigned long seatPressTime;


//stopButton "holding" stuff
int stopFirstTime = 1;
unsigned long stopStartTime;
unsigned long stopPressTime;

//===============================================

void setup() {

//Set pin modes

pinMode(seat, INPUT);
pinMode(fwdStop, INPUT);
pinMode(revStop, INPUT);
pinMode(fwd, OUTPUT);
pinMode(rev, OUTPUT);
Serial.begin(9600);


}


//===============================================


void loop(){

seatButton = digitalRead(seat);
stopButton = digitalRead(fwdStop);
finishButton = digitalRead(revStop);


/*
stopButton and finishButton: LOW == IN and HIGH == OUT
seatButton: HIGH == IN and LOW == OUT
*/


//Start and waiting process
if (movingForwards){
motorOnFwd();
} else {
motorOff();
}
//seatButton IN, finishButton IN
if (seatButton == HIGH && finishButton == LOW) {
if (seatFirstTime == 1) {
seatStartTime = millis();
seatFirstTime = 0;
}
seatPressTime = millis() - seatStartTime;
if (seatPressTime >= 1) {
}
seatPressTime = millis() - seatStartTime;
if(seatPressTime >= 1){
Serial.print("Time: ");
Serial.print(seatPressTime);
Serial.print(" milliseconds ");
Serial.print(int(seatPressTime/1000));
Serial.println(" seconds");
}
if (seatPressTime > 10000) {
movingForwards = true;
}
} else if (seatFirstTime == 0) {
seatFirstTime = 1;
movingForwards = true;
}

//Forward and stop process
//Wait and reverse process
if (movingBackwards){
motorOnRev();
} else {
motorOff();
}
//stopButton IN
if (seatButton == LOW && stopButton == LOW && finishButton == HIGH || stopButton == LOW) {
if (stopFirstTime == 1) {
stopStartTime = millis();
stopFirstTime = 0;
}
stopPressTime = millis() - stopStartTime;
if (stopPressTime >= 1) {
}
stopPressTime = millis() - stopStartTime;
if(stopPressTime >= 1){
Serial.print("Time: ");
Serial.print(stopPressTime);
Serial.print(" milliseconds ");
Serial.print(int(stopPressTime/1000));
Serial.println(" seconds");
}
if (stopPressTime > 10000) {
movingBackwards = true;
}
} else if (stopFirstTime == 0) {
stopFirstTime = 1;
movingBackwards = true;
}
/* IMPORTANT! DO NOT DELETE THIS SECTION
seatButton and finishButton act as killswitches so
the motor and battery does not commit suicide */
if (seatButton == HIGH && movingBackwards == true || finishButton == LOW) {
movingBackwards = false;
}
if (stopButton == LOW) {
movingForwards = false;
}
/* End of important section */
}

//===============================================

void motorOff() {
digitalWrite(fwd, HIGH);
digitalWrite(rev, HIGH);
}
void motorOnFwd() {
digitalWrite(fwd, LOW);
digitalWrite(rev, HIGH);
}
void motorOnRev() {
digitalWrite(fwd, HIGH);
digitalWrite(rev, LOW);
}
/*
Much mahalos: Dae, John, Sara Jo, Tom C.
Holding code taken from: Jeremy1998 via
http://www.arduino.cc/cgi-bin/yabb2/YaBB.pl?num=1280511595/all
*/
