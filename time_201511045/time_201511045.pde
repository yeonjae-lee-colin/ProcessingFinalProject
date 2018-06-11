TimeLine timeline  ;
Particle particle ;


ArrayList<Particle> particles;
ArrayList<TimeLine> timelines; 
int BW = -1; // background color 
int index = 0 ;
PFont font; 
String fontArray [] = {"font-100.vlw","Thin-100.vlw"};

void setup(){	
	size(900,600);
	smooth();
	noStroke();
	background(33, 38, 43,100); // 처음 처럼 흔적남는 배경  
	//객체 생성
	particles = new ArrayList();
	timelines = new ArrayList();
	
}

void draw(){
	// background(33, 38, 43,100); // ver . star dust 
	//particle 백그라운드   
	fill(0);
	rect(0, 0, width, height);
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
		fill(33, 38, 43,100);
	}
	noStroke();
	rect(0, 0, width, height);

	//타임라인 그리기
	for(TimeLine l : timelines){
		l.update();
	}

	
}

void mouseClicked(){
	//타임라인 생성후 리스트에 저장 
	TimeLine l = new TimeLine(mouseX, mouseY);
	timelines.add(l);
}

void mouseDragged(){
}

void mouseReleased(){

}

void keyPressed(){
		reset();
}
//모든 타임라인을 화면에서 지운다.
void reset(){
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
	float speed = 1.5;
	float ori_speed ;
	float easing =0.002;
	float blur = 0.0;
	int direction = 1;
	color colors[] = 
	 {color(65, 72, 185),
	 	color(96, 177, 173)};
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
		speed = (float)map(second(),0,60,0.5,1.5);
		ori_speed = speed;

		//생성시점의 timestamp를 String으로 저장 
		timeStamp = Integer.toString(month()) + "."
				+Integer.toString(day()) +" "
				+Integer.toString(hour()) + ":"
				+Integer.toString(minute()) + ":" 
				+Integer.toString(second());
		println(timeStamp);
	
	}
	void setDirection(int direction){
		this.direction = direction;
	}
	void invertColor(){
		// rgb = color(43, 249, 200,12); 
	}

	void update(){
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
		fill(colors[1],50);
		ellipse(x1,y1,radius+5,radius+5);
		//draw timeline
		fill(255, 255, 255,100);
		// fill(43, 249, 200,200+blur);
		ellipse(x1,y1,radius,radius);
		x1 = x1 + speed*direction;	
		checkEvent();
		 
	}
	void checkEvent(){
		if( mousePressed == true){
			if((pmouseX - mouseX >0)||(pmouseX - mouseX <0)){
				//방향 전환 
				direction=-1*direction;
			}
			//마우스 press 하는경우 속도 느려지게 (linear interpolation)
				speed = lerp(speed, 0.0, 0.02);
					println(speed);
				if(speed<0.3){
					showFont();
				}
			//y축 마우스 이동 -> timeline의 흔적 보여주기 
			if((pmouseY-mouseY>0 || pmouseY-mouseY<0)){
				//blur 
				stroke(255,20);
				strokeWeight(1.2);
				line(0,y1,width,y1);
				//stroke 
				stroke(colors[1],150);
				strokeWeight(0.5);
				line(0,y1,width,y1);
		}
	}else if(mousePressed == false){
		speed= ori_speed;
	}
	}

	void showFont(){
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
  color c;
   color[] colors = {
	   color(92, 40, 217),
	   color(5, 38, 225),
	   color(255,255,255),
	   color(131, 133, 135), //light gray
	   color(60, 61, 62)  // gray

   };

  Particle(PVector l) {
    acceleration = new PVector(0,random(255)/1000);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    position = l.copy();
    posY = position.y;
    lifespan = 255.0;
    // c = color(100+random(255),200+random(255),100+random(255));
	c = (int)random(0, 2);  
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 0.3;
  }

  // Method to display
  void display() {
  	noStroke();
    fill(colors[3], lifespan);
    rect(position.x, posY, 1, 1);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}


