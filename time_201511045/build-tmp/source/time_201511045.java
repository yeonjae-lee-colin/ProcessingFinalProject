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
int index = 0 ;
PFont font; 
String fontArray [] = {"Orbitron-100.vlw"};

public void setup(){  
  // size(900,600);  // mac display resolution : 1440 * 900
  
  
  noStroke();
  background(33, 38, 43); 
  //객체 생성
  particles = new ArrayList();
  timelines = new ArrayList();
}

public void draw(){
  //particle 백그라운드  
  noStroke(); 
  fill(10,12);
  rect(0, 0, width, height);
  //particle 생성 및 그리기 
  particles.add(new Particle(new PVector(random(width),random(height))));
  for(int i = particles.size()-1; i >= 0; i--){
  	Particle p = particles.get(i);
  	p.run(); 
  	if(p.isDead()){
  		particles.remove(i);
  	}
  }  

  //배경 
  fill(33, 38, 43,2);
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

public void keyPressed(){
	reset();
}

//모든 타임라인을 삭제
public void reset(){
	if(key == 'r')
		timelines.clear();
}

/**
* TimeLine 
*/
class TimeLine {
	float x1, x2, y1, y2;
	int radius;
	float modular; // 원 사이즈 = 타임라인 생성시각(ms) % modular
	float speed ; 
	float ori_speed;
	float easing =0.002f;
	float blur = 0.0f;
	int direction = 1;
	int tempcolor ;
	String timeStamp = null;
	long timeMillis  = 0;
	float glow ;  // 투명도 컨트롤 
	PFont font;
	//멈췄을 때 blur 효과
	float frequency = 0.0f;   
	float alpha = 170;      

/**
 * Constructor
 * @Param : x1, y2 - 마우스 클릭 좌표 
 */
 TimeLine(float x1, float y1){
 	this.x1 =x1; this.y1 =y1;
 	timeMillis = millis();
 	modular = width/30+2;  // default = 32 
 	radius = (int)timeMillis%(int)modular;
 	speed = (float)map(second(),0,60,0.8f,2.4f);
 	ori_speed = speed;
 	tempcolor = color(map(second(),0,60,0,255),timeMillis%255,random(0,255));
    //생성시점의 timestamp를 String으로 저장 
    timeStamp = Integer.toString(month()) + "/"
        +Integer.toString(day()) +"-"  // "-"가 splitter 
        +Integer.toString(hour()) + ":"
        +Integer.toString(minute()) + ":" 
        +Integer.toString(second());
    glow = 15;
    }
    public void setDirection(int direction){
    	this.direction = direction;
    }
    public void invertColor(){
    // rgb = color(43, 249, 200,12); 
}

public void update(){
    /**
     * draw timeline
     */
     noStroke();
  	//make blur 
  	if(mousePressed && speed<0.5f){
  		enableBlur();
  	}
  	fill(tempcolor,40);
  	ellipse(x1,y1,radius+5,radius+5);
    //core
    for(int i = 0; i <radius; i+=5){
    	fill(255, 255, 255,glow+i*2);
    	ellipse(x1,y1,radius-i,radius-i);
    }
    x1 = x1 + speed*direction;  
    checkEvent();

}
public void checkEvent(){
	if(mousePressed == true){
		if((pmouseX - mouseX >0)||(pmouseX - mouseX <0)){
        //방향 전환 
        direction=-1*direction;
        showTimeLine();
    }
      //속력 감소 (linear interpolation)
      speed = lerp(speed, 0.0f, 0.02f);
      if(speed <=0.0f){
      	 speed = 0 ; 
      }
     
     // println(speed);
      if(speed<0.5f){
      	showTimeStamp();
      }
      //y축 마우스 이동 -> timeline 흔적 보여주기 
      if((pmouseY-mouseY>0 || pmouseY-mouseY<0)){
       	showTimeLine();
    }
}else if(mousePressed == false){
	//원래 속도로 복원 
	speed= ori_speed;
}
}

public void showTimeLine(){
	 //blur 
     stroke(255,10);
     strokeWeight(1.8f);
     stroke(255,20);
     strokeWeight(1.2f);
     line(0,y1,width,y1);
     //stroke 
     stroke(tempcolor,150);
     strokeWeight(0.3f);
     line(0,y1,width,y1);
}
public void showTimeStamp(){

	String day;
	String time;
    //폰트 설정 
    font = loadFont(fontArray[0]);
    //폰트 사이즈 
    if(radius/1.6f == 0){    
    	textFont(font, 0.5f);
    }else{
    	textFont(font, radius/2.8f);
    }
    String s [] = split(timeStamp, "-");  // day, time 분리 
    day = s[0];
    time = s[1];

    fill(lerp(0, 230, 1.4f),180);  //감소하는 속도에 따라 서서히 보이도록 설정 
    text(day, x1+radius/1.5f+2, y1-2);
    text(time, x1+radius/1.5f+2, y1+radius/2-2);
}

public void enableBlur(){
	alpha = (sin(frequency)*radius);
	fill(tempcolor*2,alpha/2);
	ellipse(x1,y1,radius+20,radius+20);
	fill(tempcolor*2,alpha);
	ellipse(x1,y1,radius+10,radius+10);
	frequency +=0.07f;
}

}


/**
 * 배경에 쓰일 Particle 
 */
 class Particle {
 	PVector position;
 	PVector velocity;
 	PVector acceleration;
  	float lifespan; // 투명도를 이용 
  	float posY;
  	float size = 1.2f;
  	int[] colors = {
     color(131, 133, 135), //light gray
     color(57, 215, 123), // light green
     color(156, 230, 226)  // light blue -ish
 	};

 Particle(PVector l) {
 	acceleration = new PVector(0,random(255)/1000);
 	velocity = new PVector(random(-1, 1), random(-2, 0));
 	position = l.copy();
 	posY = position.y;
 	lifespan = 70.0f;
 }

 public void run() {
 	update();
 	display();
 }

  // 위치 업데이트
  public void update() {
  	velocity.add(acceleration);
  	position.add(velocity);
  	lifespan -= 0.3f;
  }

  // 화면에 그리기 
  public void display() {
  	noStroke();
  	fill(colors[(int)random(0,2)], lifespan);
  	rect(position.x, posY, size,size);
  }

  // 파티클 lifespan 체크 
  public boolean isDead() {
  	if (lifespan < 0.0f) {
  		return true;
  	} else {
  		return false;
  	}
  }
}
  public void settings() {  size(displayWidth, displayHeight);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "time_201511045" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
