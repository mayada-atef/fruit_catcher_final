import java.util.Random;
Random rand = new Random();
PImage basket ;
PShape tree , sun , cloud , grass;
int i;
int x=800;
int x1=800;
int x2=800;
int x3=800;
int basketX =width/2, basketY=570;;
int score,level,gameState;


int distance = 4;
int new_fruit = 1 ;
String[] fruits = {"greenApple.svg","RedApple.svg", "Banana.svg", "rotten_apple.svg"};
PShape[] fruit = new PShape[fruits.length] ;
int max_level = 10;


int[] fruitY = {0,0,0,0,0,0,0,0,0,0} ;
float[] fruitX = {0,0,0,0,0,0,0,0,0,0} ;
int[] fruit_idx ={0,0,0,0,0,0,0,0,0,0} ;
float[] fdistance = new float[10];


void setup() {
  size(1000, 680);
  smooth();
  score=0;
  level=1;
  gameState=0;
  tree = loadShape("tree.svg");
  sun = loadShape("sun.svg");
  grass = loadShape("Grass.svg");
  cloud = loadShape("cloud.svg");
  basket = loadImage("basket.png");
  for(int i = 0 ; i < fruits.length ; i++){
    fruit[i] = loadShape(fruits[i]);
  }
  
}

void startScreen () {
  background (0);
  textSize(105);
  textAlign(CENTER);
  fill(255, 0, 0);
  text("Catch The Fruits", width/2, 170);

  //start instruction
  textSize(30);
  fill(255);
  text("Press Spacebar to begin!", width/2, 280);
  
  //Instruction Apples
  textSize(20);

  //Red Apples
  fill (255, 0, 0);
  text("Red Apples,banana,grapes and strawberry give 1 point when catched", width/2, 370);
 

  //Green Apples
  fill (130, 255, 0);
  text("Green Apples give 2 point but becarefull they are faster than the other apples", width/2, 400);
 

  //Rotten Apples
  fill (61, 80, 0);
  text("Rotten Apples give a negative point when you catch them.", width/2, 430);
 

  //Gameplay instructions
  textSize (13);
  fill (255);
  text ("Gather Fruits using the basket, that is controlled with the mouse.", width/2, 480);
  text ("When gathering fruits or rather points you gain levels.", width/2, 500);
  text ("Each level makes the game faster. Becareful not to go below 0 or it is GAME OVER!", width/2, 520);
}


void endScreen () {
  background (0);
  textSize(105);
  textAlign(CENTER);
  fill(255, 0, 0);
  text("Game Over", width/2, height/2);
    
  }

void draw() {
  
    if (gameState != 0){
      if (score < 0){
        gameState = 2 ;
        endScreen ();
      }
      if (score >= 10 && score < 20 ){
        distance = 4 ;
        level = 2 ;
      }
      else if (score >= 20 && score < 30 ){
        distance = 5 ;
        level = 3;
      }
      else if (score >= 30 && score < 40 ){
        distance = 6 ;
        level = 4;
      }
      else if (score >= 40 && score < 50 ){
        distance = 8 ;
        level = 5;
      }
      else if (score >= 50 && score < 60 ){
        distance = 10 ;
        level = 6;
      }
      else if (score >= 40 && score < 50 ){
        distance = 12 ;
        level = 5;
      }
      
        
        
    }
    else{
      startScreen ();
      if (keyPressed && key == ' ') //set start button
        gameState = 1;
    }
     
     
  if (gameState==1){
    
    background(135,206,235);
    
    shape(sun, -25, -35, 150, 150);
    
    shape(grass, 50 ,500, width*2 , height/4);    
    shape(tree, 170, 220, 250, 450);
    shape(tree, 550, 220, 250, 450);
    
    shape(tree, -80, 100, 250, 550);
    shape(tree, 800, 100, 250, 550);
    shape(grass, 0 ,550, width*2 , height/4);
    shape(grass, 0 ,520, width*2 , height/4);
    
    
    /////// game score
    fill(255, 0, 0);
    textSize (30);
    textAlign (LEFT);
    text("Score: " +score, 5, 30);
    
      //text level
    if (level == 11) {
      text("Level:10(MAX)", 5, 60); //level 10 is the max level that can be reached.
    } 
    else {
      text("Level: " +level, 5, 60);
    }
    /////// end of game score
    
    shape(cloud, x-200, 150, 100, 70);
    shape(cloud, x1-50, 80, 100, 70);    
    shape(cloud, x2+150, 30, 100, 70);
    shape(cloud, x3+100, 30, 100, 70);
    
    x -= 2;
    x1 -=2;
    x2 -=1;
    x3 -=3;
    
    if (x<=50){x=800;}
    if (x1<=20){x1=800;}
    if (x2<=30){x2=800;}
    if (x3<=200){x3=800;}
    
    
    if(new_fruit == 1){
      for (int i= 0 ; i < level ; i++){
        fruit_idx[i] = rand.nextInt(fruits.length);
        fruitX[i] = rand.nextInt(750)+10 ;
        fdistance[i] = random(0.7,1.5);
        println(fruit_idx[i] );
      }
      println("gen fr");
      new_fruit = 0;
    }
    
    
    for (int i = 0 ; i < level; i++){
      fruitY[i] += distance;
      shape(fruit[fruit_idx[i]], fruitX[i] , fruitY[i] , width / 11 , height / 9 );
      if(abs(fruitY[i]-basketY) < 5 ){
        
        if (fruitY[level-1] <= basketY){
          println("working");
          new_fruit = 1 ;
        }
        
        if(abs(fruitX[i] - mouseX)< 70){
          if(fruit_idx[i] == 0){
            score +=2;
          }
          else if(fruit_idx[i] == fruits.length-1){
            score -=1;
          }
          else{
            score +=1;
          }
        }
        fruitY[i] = 0 ;
        println(fruitX[i], fruitY[i] , i);
        
      }
    }
    image(basket, mouseX-70 ,basketY, width/5 , height/5);
    
}
    
}
