

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


float stiffness = 0.1;
float damping = 0.9;
float velocity = 0.0;
float targetY;
float targetX;
float x;
float k ;
void setup(){
	size(900,600);
	smooth();
	noStroke();
}

void draw(){
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
	//라인 x축 이동 sequence
	targetX++;

}
