InterpolationCurve intCurve;
BezierCurve bezCurve;

final int pointNum = 4;
PVector[] p = new PVector[pointNum];
final int accuracy = 200;

void settings() {
  size(1920,1080);
}

void setup() {
  background(255);
  
  p[0] = new PVector(200, 300);
  p[1] = new PVector(300, 200);
  p[2] = new PVector(500, 300);
  p[3] = new PVector(600, 150);
  
  intCurve = new InterpolationCurve(p, accuracy);
  
  
  p[0] = new PVector(200, 800);
  p[1] = new PVector(250, 500);
  p[2] = new PVector(650, 500);
  p[3] = new PVector(500, 700);
  
  bezCurve = new BezierCurve(p, accuracy);
  
  intCurve.Draw();
  bezCurve.Draw();
}

void draw() {
  
}
