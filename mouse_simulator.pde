struct {
    uint8_t buttons;  /* No use*/
    int8_t x;
    int8_t y;
    int8_t wheel;    /* Not yet implemented */
} mouseSimulator;

int x;
int y;
uint8_t erase[4] = { 0, 0, 0, 0 };

void setup()
{
    pinMode(A0,INPUT);
    pinMode(A1,INPUT);
    Serial.begin(9600);
    delay(200);
    mouseSimulator.buttons = 0;
    mouseSimulator.x = 0;
    mouseSimulator.y = 0;
    mouseSimulator.wheel = 0;
}


void loop() {
   read_joystick();
    
    if (x<-50) {
       left(x/40); 
    }else if(x>50){
       right(x/40);
    }

    if (y<-50) {
       up(y/40); 
    }else if(y>50) {
       down(y/40);
    }
}

void up(int speeddd) {
    mouseSimulator.x = 0;
    mouseSimulator.y = speeddd;
    
    Serial.write((uint8_t *)&mouseSimulator, 4);
    Serial.write((uint8_t *)&erase, 4);
}

void down(int speeddd){
    mouseSimulator.x = 0;
    mouseSimulator.y = speeddd;
    
    Serial.write((uint8_t *)&mouseSimulator, 4);
    Serial.write((uint8_t *)&erase, 4);
}

void right(int speeddd) {
    mouseSimulator.x = speeddd;
    mouseSimulator.y = 0;
    
    Serial.write((uint8_t *)&mouseSimulator, 4);
    Serial.write((uint8_t *)&erase, 4);
}

void left(int speeddd) {
    mouseSimulator.x = speeddd;
    mouseSimulator.y = 0;
    
    Serial.write((uint8_t *)&mouseSimulator, 4);
    Serial.write((uint8_t *)&erase, 4);
}

void read_joystick() {
     x = analogRead(A0)-512;
     y = analogRead(A1)-512;
}
