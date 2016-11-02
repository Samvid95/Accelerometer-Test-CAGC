#include <Keyboard.h>

#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_LSM303_U.h>

/* Assign a unique ID to this sensor at the same time */
Adafruit_LSM303_Accel_Unified accel = Adafruit_LSM303_Accel_Unified(54321);

bool oldValues = false;
float yBegin;

void displaySensorDetails(void)
{
  sensor_t sensor;
  accel.getSensor(&sensor);
  Serial.println("------------------------------------");
  Serial.print  ("Sensor:       "); Serial.println(sensor.name);
  Serial.print  ("Driver Ver:   "); Serial.println(sensor.version);
  Serial.print  ("Unique ID:    "); Serial.println(sensor.sensor_id);
  Serial.print  ("Max Value:    "); Serial.print(sensor.max_value); Serial.println(" m/s^2");
  Serial.print  ("Min Value:    "); Serial.print(sensor.min_value); Serial.println(" m/s^2");
  Serial.print  ("Resolution:   "); Serial.print(sensor.resolution); Serial.println(" m/s^2");
  Serial.println("------------------------------------");
  Serial.println("");
  delay(500);
}

void setup(void)
{
#ifndef ESP8266
  while (!Serial);     // will pause Zero, Leonardo, etc until serial console opens
#endif
  Serial.begin(9600);
  Serial.println("Accelerometer Test"); Serial.println("");

  /* Initialise the sensor */
  if(!accel.begin())
  {
    /* There was a problem detecting the ADXL345 ... check your connections */
    Serial.println("Ooops, no LSM303 detected ... Check your wiring!");
    while(1);
  }

  /* Display some basic information on this sensor */
  displaySensorDetails();
}

void loop(void)
{
  /* Get a new sensor event */
  sensors_event_t event;
  accel.getEvent(&event);
  
  /* Display the results (acceleration is measured in m/s^2) */
  //Serial.print("X: "); Serial.print(event.acceleration.x); Serial.print("  ");
  Serial.print("Y: "); Serial.print(event.acceleration.y); Serial.println("  ");
  //Serial.print("Z: "); Serial.print(event.acceleration.z); Serial.print("  ");Serial.println("m/s^2 ");
  if(oldValues == false){
    if(event.acceleration.y < 0){
      yBegin = -event.acceleration.y;
    }
    else{
      yBegin = event.acceleration.y;
    } 
    oldValues = true;
  }
  Serial.print("Y old: "); Serial.println(yBegin);
  if(event.acceleration.y > 0){
    if(event.acceleration.y - yBegin > 5){
      Keyboard.press('a');
      Serial.print("Inside if condition!!");
      Keyboard.release('a');
    }    
  }
  else{
    if((-event.acceleration.y) - yBegin > 5){
      Keyboard.press('a');
      Serial.print("Inside if condition!!");
      Keyboard.release('a');
    }  
  }
 
  Serial.println("Outside if condition!!");
  /*
  if(event.acceleration.y < 0){
    event.acceleration.y = -event.acceleration.y;
      if(event.acceleration.y < yBegin){
        if(yBegin - event.acceleration.y > 5){
          Serial.println("1st if cond!!");
          Keyboard.press('a');
        }
      }
      else{
        if(event.acceleration.y - yBegin > 5){
          Serial.println("2nd if cond!!");
          Keyboard.press('a');
        }
      }   
   }
   else{
      if(event.acceleration.y < yBegin){
        if(yBegin - event.acceleration.y > 5){
          Serial.println("3rd if cond!!");
          Keyboard.press('a');
        }
    }
      else{
        if(event.acceleration.y - yBegin > 5){
          Serial.println("4th if cond!!");
          Keyboard.press('a');
        }
      }   
    
   }
   */
  /* Note: You can also get the raw (non unified values) for */
  /* the last data sample as follows. The .getEvent call populates */
  /* the raw values used below. */
  //Serial.print("X Raw: "); Serial.print(accel.raw.x); Serial.print("  ");
  //Serial.print("Y Raw: "); Serial.print(accel.raw.y); Serial.print("  ");
  //Serial.print("Z Raw: "); Serial.print(accel.raw.z); Serial.println("");

  /* Delay before the next sample */
  delay(500);
}
