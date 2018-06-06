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

TimeLine timeline  ;
Particle particle ;


ArrayList<Particle> particles;
ArrayList<TimeLine> timelines; 
int BW = -1; // background color 
int index = 0 ;
PFont font; 
String fontArray [] = {"font-100.vlw","Thin-100.vlw"};

public void setup(){	
	
	noStroke();
	background(255);
	//객체 생성
	particles = new ArrayList();
	timelines = new ArrayList();
	
}

public void draw(){
	// background(0,100);
	//particle 백그라운드   
	particles.add(new Particle(new PVector(random(width),random(height))));
	for(int i = particles.size()-1; i >= 0; i--){
		Particle p = particles.get(i);
		p.run(); 
	if(p.isDead()){
		particles.remove(i);
	}
	}	
    
	//배경 
	if(BW == -1){
		fill(21, 16, 20,12);
	}
	noStroke();
	rect(0, 0, width, height);

	//타임라인 그리기
	for(TimeLine l : timelines){
		l.update();
	}

	
}

public void mouseClicked(){
	//타임라인 생성후 리스트에 저장 
	TimeLine l = new TimeLine(mouseX, mouseY);
	timelines.add(l);
}

public void mouseDragged(){
}

public void mouseReleased(){

}

public void keyPressed(){
		reset();
}
//모든 타임라인을 화면에서 지운다.
public void reset(){
	timelines.clear();
}

/**
* TimeLine OBJECT
*/
class TimeLine {
	//생성 시각의 timestamp 필요
	//color
	// float stiffness = 0.1;
	// float damping = 0.9;
	// float velocity = 0.0;
	// float targetY;
	// float targetX;
	// float x;
	// float k ;

	float x1, x2, y1, y2;
	//0.5~1.5
	float speed = 1.5f;
	float ori_speed ;
	float easing =0.002f;
	float blur = 0.0f;
	int direction = 1;
	int rgb = color(65, 72, 185);
	int radius = 20;
	String timeStamp = null;
	long timeMillis  = 0;
	PFont font;

/**
 * Constructor
 * @Param : x1, y2 : 마우스 클릭 위치  
 */

	TimeLine(float x1, float y1){
		this.x1 =x1; this.y1 =y1;
		timeMillis = millis();
		radius = (int)timeMillis%30;
		speed = (float)map(second(),0,60,0.5f,1.5f);
		ori_speed = speed;

		//생성시점의 timestamp를 String으로 저장 
		timeStamp = Integer.toString(month()) + "."
				+Integer.toString(day()) +" "
				+Integer.toString(hour()) + ":"
				+Integer.toString(minute()) + ":" 
				+Integer.toString(second());
		println(timeStamp);
	
	}
	public void setDirection(int direction){
		this.direction = direction;
	}
	public void invertColor(){
		rgb = color(43, 249, 200,12); 
	}

	public void update(){
		//spring effect : f = -kx
		// float force = stiffness * (targetX-x1);
		// velocity  = damping * (velocity+force) ;
		// x1+=velocity;
		// //draw TimeLine
		// strokeWeight(15);
		// stroke(255, 251, 249);
		// TimeLine(x1,y1,x1+100,y1);
		// //라인 x축 이동 sequence
		// targetX+=5;

		//draw TimeLine
		// strokeWeight(15);
		// stroke(255, 251, 249);
		// TimeLine(x1,y1,x1+100,y1);
		 
		noStroke();
		fill(43, 249, 200,50);
		ellipse(x1,y1,radius+5,radius+5);
		//draw timeline
		fill(255, 255, 255,100);
		// fill(43, 249, 200,200+blur);
		ellipse(x1,y1,radius,radius);
		x1 = x1 + speed*direction;	
		checkEvent();
		 
	}
	public void checkEvent(){
		if( mousePressed == true){
			if((pmouseX - mouseX >0)||(pmouseX - mouseX <0)){
				//방향 전환 
				direction=-1*direction;
			}
			//마우스 press 하는경우 속도 느려지게 (linear interpolation)
				speed = lerp(speed, 0.0f, 0.02f);
					println(speed);
				if(speed<0.3f){
					showFont();
				}
			//y축 마우스 이동 -> timeline의 흔적 보여주기 
			if((pmouseY-mouseY>0 || pmouseY-mouseY<0)){
				//blur 
				stroke(255,20);
				strokeWeight(1.2f);
				line(0,y1,width,y1);
				//stroke 
				stroke(43, 255, 200,150);
				strokeWeight(0.5f);
				line(0,y1,width,y1);
		}
	}else if(mousePressed == false){
		speed= ori_speed;
	}
	}

	public void showFont(){
		//폰트 설정 
		font = loadFont(fontArray[1]);
    textFont(font, radius);
    noStroke();
    textAlign(CENTER);
    fill(lerp(0, 255, 2));
    text(timeStamp, x1, y1+radius/2);
	}

}

//------------------------------------------------------------------------------------------
/**
 * 배경에 쓰일 Particle 
 */

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float posY;
  int c;
   int[] colors = {
	   color(92, 40, 217),
	   color(5, 38, 225),
	   color(255,255,255)
   };

  Particle(PVector l) {
    acceleration = new PVector(0,random(255)/1000);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    position = l.copy();
    posY = position.y;
    lifespan = 255.0f;
    // c = color(100+random(255),200+random(255),100+random(255));
	c = (int)random(0, 2);  
  }

  public void run() {
    update();
    display();
  }

  // Method to update position
  public void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 0.3f;
  }

  // Method to display
  public void display() {
  	noStroke();
    // fill(colors[(int)random(0,2)], lifespan);
      fill(200, lifespan);
    rect(position.x, posY, 1, 1);
  }

  // Is the particle still useful?
  public boolean isDead() {
    if (lifespan < 0.0f) {
      return true;
    } else {
      return false;
    }
  }
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
