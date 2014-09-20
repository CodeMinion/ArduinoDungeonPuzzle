/*
Dungeon Project: Puzzle Room
If the pushbuttons are pressed in the right sequence the pin 
connected to pin 9 is activate. If a mistake is made in the 
order in which the switches are activated the puzzle is reset.

The circuit:
* LEDs connected from digital pins 13, 12, 8, 
7 to ground

* Pushbuton attached to pin 0 from +5V
* 10K resistor attached to pin 0 from ground

* Pushbuton attached to pin 1 from +5V
* 10K resistor attached to pin 1 from ground

* Pushbuton attached to pin 2 from +5V
* 10K resistor attached to pin 2 from ground

* Pushbuton attached to pin 4 from +5V
* 10K resistor attached to pin 4 from ground

Personal Breadboard Mapping:
Power To C5
Power To C14
Power To C19
Power To C26

Ground To B11
Ground To B18
Ground To B23
Ground To B30

10KOhm Resistor From C6 To C10
10KOhm Resistor From C15 To C18
10KOhm Resistor From C20 To C23
10KOhm Resistor From C27 To C30

Arduino Digital Pin 4 To I6 
Arduino Digital Pin 2 To I15 
Arduino Digital Pin 9 To I20 
Arduino Digital Pin 6 To I27 

Arduino Digital Pin 13 To I21
Arduino Digital Pin 12 To G7
Arduino Digital Pin 8 To G16
Arduino Digital Pin 7 To I28

FIRE: 
OUT Pin - 13 
IN Pin - 9
Switch Blue To J20
Switch Brown To J19
LED Orange To J23
LED Green To J21

WIND:
OUT Pin - 7
IN Pin - 6
Switch Blue To J26
Switch Brown To J27
LED Orange To J30
LED Green To J28

WATER:
OUT Pin - 8
IN Pin - 2
Switch Blue To J15
Switch Brown To J14
LED Orange To J18
LED Green To J16

EARTH:
OUT Pin - 12
IN Pin - 4
Switch Blue To J6
Switch Brown To J5
LED Orange To J11
LED Green To J7

HEART:
Yeah... no heart on this one.

Created 2010
by CodeMinion
*/

int maxCounter = 4;

// This represents the LED to be turned on at
// a given puzzle stage.
int ledToLight[] = {8, 12, 13, 7};
// Reversed
//int ledToLight[] = {7, 13, 12, 8};

// Expected pin to be activated at each puzzle 
// stage
int puzzleSwitch[] = {2, 4, 9, 6};
// Reversed
//int puzzleSwitch[] = {6, 9, 4, 2};

int puzzleStage = -1;

void setup()   
{                
  // initialize the digital pins as an output:
  for(int i = 0; i < maxCounter; i = i + 1)
  {
    pinMode(ledToLight[i], OUTPUT);
  }
  
   // initialize the pushbutton pin as an input:
  for(int i = 0; i < maxCounter; i = i + 1)
  {
    pinMode(puzzleSwitch[i], INPUT);
  }
}

void loop()                     
{
  int activeSwitch = -1;
  boolean puzzleFailed = false;
  // Find activated switch if any.
  for(int i = 0; i < maxCounter; i = i + 1)
  {
    int switchState = digitalRead(puzzleSwitch[i]);
    if(switchState == HIGH)
    {
       activeSwitch =  puzzleSwitch[i];
       digitalWrite(ledToLight[i], HIGH);
       
       break;
    }
  }
  
  // If a switch was activated, check if it was the
  // correct switch.
  if(activeSwitch >=0 )
  {
    int newStage = puzzleStage + 1; 
    // If the switch presses is the same 
    // as last time, do not move the puzzle
    // forward.
    if(puzzleStage >=0 
      && puzzleSwitch[puzzleStage] == activeSwitch )
    {
      newStage = newStage - 1;
    }
    // If the switch pressed is not the expected 
    // one then reset.
    else if(activeSwitch != puzzleSwitch[newStage]) 
    {
       puzzleStage = puzzleStage - 1;
       puzzleFailed = true;
    }
    else
    {
       //puzzleFailed = true;
    }
    // Update puzzle stage.
    puzzleStage = newStage;
     
  }
  
  if(puzzleFailed)
  {
     puzzleStage = -1; 
     for(int i = 0; i < maxCounter; i = i + 1)
     {
       digitalWrite(ledToLight[i], LOW);
     }
  }
  else
  {
     for(int i = 0; i <= puzzleStage && i < maxCounter; i = i + 1)
     {
       digitalWrite(ledToLight[i], HIGH);
     } 
  }
 
  
}
