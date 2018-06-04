import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class time_201511045 extends PApplet {



// void setup(){
// 	size(100,100);
// 	noStroke();
// }

// void draw(){
// 	fill(0,12);
// 	rect(0, 0, width, height);
// 	fill(255);
// 	float force = stiffness * (targetY - y);
// 	velocity  = damping * (velocity+force) ;
// 	y+=velocity;
// 	rect(10, y, width-20, 12);
// 	targetY = mouseY;
// }


float stiffness = 0.1f;
float damping = 0.9f;
float velocity = 0.0f;
float targetY;
float targetX;
float x;
float k ;
public void setup(){
	
	
	noStroke();
}

public void draw(){
	//background rect
	noStroke();
	fill(21, 16, 20,12);
	rect(0, 0, width, height);

	//spring effect : f = -kx
	float force = stiffness * (targetX-x);
	velocity  = damping * (velocity+force) ;
	x+=velocity;
	//draw line
	strokeWeight(15);
	stroke(255, 251, 249);
	line(x,mouseY,x+50,mouseY);
	targetX = k;
	k++;
}
  public void settings() { 	size(900,600); 	smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "time_201511045" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
