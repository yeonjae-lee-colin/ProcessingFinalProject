/** 
*TIME IS ILLUSION
* created by yeonjae lee
* yjflore34@gmail.com
*/
TimeLine timeline;
Particle particle;
ArrayList<Particle> particles;
ArrayList<TimeLine> timelines; 
int index = 0 ;
PFont font; 
String fontArray [] = {"Orbitron-100.vlw"};

void setup(){  
  // size(900,600);  // mac display resolution : 1440 * 900
  size(displayWidth, displayHeight);
  smooth();
  noStroke();
  background(33, 38, 43); 
  particles = new ArrayList();
  timelines = new ArrayList();
}

void draw(){
  //background particles
  noStroke(); 
  fill(10,12);
  rect(0, 0, width, height);
  //create & draw particles
  particles.add(new Particle(new PVector(random(width),random(height))));
  for(int i = particles.size()-1; i >= 0; i--){
  	Particle p = particles.get(i);
  	p.run(); 
  	if(p.isDead()){
  		particles.remove(i);
  	}
  }  

  //background
  fill(33, 38, 43,2);
  noStroke();
  rect(0, 0, width, height);

  //draw timelines
  for(TimeLine l : timelines){
  	l.update();
  }

  
}

void mouseClicked(){
  //create TimeLine
  TimeLine l = new TimeLine(mouseX, mouseY);
  timelines.add(l);
}

void keyPressed(){
	reset();
}


void reset(){
	if(key == 'r')
		timelines.clear();
}

/**
* TimeLine 
*/
class TimeLine {
	float x1, x2, y1, y2;
	int radius;
	float modular; // diameter of timeline = timestamp(ms) % modular
	float speed ; 
	float ori_speed;
	float easing =0.002;
	float blur = 0.0;
	int direction = 1;
	color tempcolor ;
	String timeStamp = null;
	long timeMillis  = 0;
	float glow ;  // control the opacity
	PFont font;
	//blur effect to stopped timelines
	float frequency = 0.0;   
	float alpha = 170;      

/**
 * Constructor
 * @Param : x1, y2 - mouseX, mouseY
 */
 TimeLine(float x1, float y1){
 	this.x1 =x1; this.y1 =y1;
 	timeMillis = millis();
 	modular = width/30+2;  // default = 32 
 	radius = (int)timeMillis%(int)modular;
 	speed = (float)map(second(),0,60,0.8,2.4);
 	ori_speed = speed;
 	tempcolor = color(map(second(),0,60,0,255),timeMillis%255,random(0,255));
    //Convert timeStamp into String
    timeStamp = Integer.toString(month()) + "/"
        +Integer.toString(day()) +"-"  // "-" is a splitter 
        +Integer.toString(hour()) + ":"
        +Integer.toString(minute()) + ":" 
        +Integer.toString(second());
    glow = 15;
    }
    void setDirection(int direction){
    	this.direction = direction;
    }
    void invertColor(){
    // rgb = color(43, 249, 200,12); 
}

void update(){
    /**
     * draw timeline
     */
     noStroke();
  	//make blur 
  	if(mousePressed && speed<0.5){
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
void checkEvent(){
	if(mousePressed == true){
		if((pmouseX - mouseX >0)||(pmouseX - mouseX <0)){
        //change direction
        direction=-1*direction;
        showTimeLine();
    }
      //속력 감소 (linear interpolation)
      speed = lerp(speed, 0.0, 0.01);
      if(speed <=0.0){
      	 speed = 0 ; 
      }
     
     // println(speed);
      if(speed<0.5){
      	showTimeStamp();
      }
      if((pmouseY-mouseY>0 || pmouseY-mouseY<0)){
       	showTimeLine();
    }
}else if(mousePressed == false){
	//reset to its initial speed
	speed= ori_speed;
}
}

void showTimeLine(){
	 //blur 
     stroke(255,10);
     strokeWeight(1.8);
     stroke(255,20);
     strokeWeight(1.2);
     line(0,y1,width,y1);
     //stroke 
     stroke(tempcolor,150);
     strokeWeight(0.3);
     line(0,y1,width,y1);
}
void showTimeStamp(){

	String day;
	String time;
    font = loadFont(fontArray[0]);
    //set font size 
    if(radius/1.6 == 0){    
    	textFont(font, 0.5);
    }else{
    	textFont(font, radius/2.8);
    }
    String s [] = split(timeStamp, "-");  // split day, time 
    day = s[0];
    time = s[1];

    fill(lerp(0, 230, 1.4),180);  // easing movement
    text(day, x1+radius/1.5+2, y1-2);
    text(time, x1+radius/1.5+2, y1+radius/2-2);
}

void enableBlur(){
	alpha = (sin(frequency)*radius);
	fill(tempcolor*2,alpha/2);
	ellipse(x1,y1,radius+20,radius+20);
	fill(tempcolor*2,alpha);
	ellipse(x1,y1,radius+10,radius+10);
	frequency +=0.07;
}

}


/**
 * Particle 
 */
 class Particle {
 	PVector position;
 	PVector velocity;
 	PVector acceleration;
  	float lifespan; // opacity 
  	float posY;
  	float size = 1.2;
  	color[] colors = {
     color(131, 133, 135), //light gray
     color(57, 215, 123), // light green
     color(156, 230, 226)  // light blue -ish
 	};

 Particle(PVector l) {
 	acceleration = new PVector(0,random(255)/1000);
 	velocity = new PVector(random(-1, 1), random(-2, 0));
 	position = l.copy();
 	posY = position.y;
 	lifespan = 70.0;
 }

 void run() {
 	update();
 	display();
 }

  void update() {
  	velocity.add(acceleration);
  	position.add(velocity);
  	lifespan -= 0.3;
  }

  void display() {
  	noStroke();
  	fill(colors[(int)random(0,2)], lifespan);
  	rect(position.x, posY, size,size);
  }

  // check lifespan
  boolean isDead() {
  	if (lifespan < 0.0) {
  		return true;
  	} else {
  		return false;
  	}
  }
}
