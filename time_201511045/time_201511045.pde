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

TimeLine timeline  ;
Particle particle ;
ArrayList<TimeLine> timelines; 
int BW = -1; // background color 
int index = 0 ;

void setup(){
	size(900,600);
	smooth();
	noStroke();
	background(255);

	//객체 생성
	timeline = new TimeLine();
	timelines = new ArrayList();
	particle = new Particle(); 
}

void draw(){

	//배경 
	noStroke();
	if(BW == -1){
		fill(21, 16, 20,12);
	}
	rect(0, 0, width, height);
	//타임라인 그리기
	for(TimeLine l : timelines){
		l.update();
	}
}

void mouseClicked(){
	//타임라인 생성후 리스트에 저장 
	TimeLine l = new TimeLine();
	l.init(mouseX, mouseY);
	timelines.add(l);
}

void mouseDragged(){
}

void mouseReleased(){
	for(TimeLine l : timelines){
		l.setSpeed(1.5);
	}
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
	float speed = 1.5;
	float easing;
	float blur = 0.0;
	int direction = 1;
	color rgb = color(65, 72, 185);
	int radius = 20;

/**
 * Constructor
 * @Param : x1, y2 : 마우스 클릭 위치  
 */

TimeLine(float x1, float y1){

}


	void setSpeed(float speed){
		this.speed = speed;
	}
	void setDirection(int direction){
		this.direction = direction;
	}
	void invertColor(){
		rgb = color(43, 249, 200,12); 
	}
	void init(float x1, float y1){
		
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

		//draw timeline
		fill(246, 244, 247,100);
		ellipse(x1,y1,radius,radius);
		x1 = x1 + speed*direction;
		// blur
		if(blur >= 0.0&& blur <0.5){
			// strokeWeight(20 + blur);
			// stroke(65, 72, 185,200+blur);
			// stroke(rgb,200+blur);
			// TimeLine(x1,y1,x1+100,y1);
			// fill(43, 249, 200);
			stroke(43, 249, 200,200+blur);
			ellipse(x1,y1,radius,radius);
			blur +=0.1;

		}else if(blur == 0.5){
			// strokeWeight(24 + blur);
			// stroke(65, 72, 185,100+blur);
			// TimeLine(x1,y1,x1+100,y1);
			blur = 0.0;
		}

		checkEvent();
		
	}
	void checkEvent(){
		//드래그할때 감속
		if((pmouseX - mouseX >0 ||pmouseX - mouseX <0)&& mousePressed == true){
				setSpeed(0.9);
			// line(x1/2,y1,x1+random(10,25),y1);
					
				//TODO : x 속도에 따라 변하도록 변경하
		if((pmouseY-mouseY>0 || pmouseY-mouseY<0)){
				invertColor();
				line(0,y1,width,y1);
				direction*=-1;
		}
	}
	else if(pmouseX - mouseX ==0&& mousePressed == true){
	//정지 하는경우
		setSpeed(0);
	}
	}

}

class Particle{

	void display(){
		for(int i= 0; i<100; i++){

			fill(205, 116, 232);
			rect(width/2+i, width/2, 5, 3);
		}

	}
}

