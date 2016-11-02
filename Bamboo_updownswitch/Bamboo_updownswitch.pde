
float threshold = 300;

boolean growing = true;
//A variable to sense that we pressed the "UP" key
boolean key1 = false;

ArrayList<Bamboo> bamboos;

PImage img1;
PImage img3;

void setup() {
  size(500,500);
  //fullScreen();
  img1 = loadImage("totoro_crouching.png");
  img3 = loadImage("totoro_standing.png");
  
  bamboos = new ArrayList<Bamboo>();
  
}

void draw() {
  background(255);
    
    for (int i = 0; i < bamboos.size(); i++) {
    // bamboos[i]
    Bamboo b = bamboos.get(i);
    
    // update values first
    b.update();
    
    // check them with if statements
    b.createBranch();
    
    // and then display
    b.display();
    
    // draw (fake) fog
    //background(255,15);
    
  }
  /*
  This will just check the value the button is pressed; if yes than we can grow the tree. And in the else part we will just kill the key1 variable and go into elseif part.
  */
  if (mouseY > threshold || key1 == true) {
    growing = false;
     
     key1=false;
  } else if (mouseY < threshold && !growing) {
    //println("new bamboo");
    bamboos.add( new Bamboo(mouseX) );
    growing = true;
    key1= false;
     
  }
  
  /*
  This code is for player animation. Just changing the images.
  */
  if(mouseY > threshold) {
    //cursor(img1);
    image(img1, mouseX-50, height-100, 100, 100);
  } else if (mouseY < threshold) {
    image(img3, mouseX-50, height-100, 100, 100);
    //cursor(img2);
}
  
  //fill(0);
  //textSize(32);
  //text(""+growing,30, 40);
  
 
  
  //stroke(0);
  //line(0,threshold,width,threshold);
  
}

/*
It will check that whether we had pressed the UP key than it will change the value of boolean to True.
*/
void keyPressed(){
   if(key == CODED){
       if(keyCode == UP){
         key1 = true;
         
       }
   }
   else{
    key1 = false; 
   }
}