////////////////////////    CONSTANTS    ////////////////////////

final float ROTATION_X = -35.26f;
final float ROTATION_Y = 45f;
float OFFSET_X;
float OFFSET_Y;
float OFFSET_Z;

PVector TILESET_POS = new PVector(-500,0,-500);
final int ROWS = 21;
final int COLS = 21;
final float TILE_SIZE = 50f;

final color BASE_COLOR = color(130,170,170);
final color BORDER_COLOR = color(60,80,80);

////////////////////////    Variables    ////////////////////////

Tileset tileset = new Tileset(TILESET_POS, ROWS, COLS, TILE_SIZE);

InterpolationCurve intCurve;
BezierCurve bezCurve;

final int pointNum = 4;
PVector[] p = new PVector[pointNum];
final int accuracy = 200;

////////////////////////    Game    ////////////////////////

void settings() {
  size(1920,1080,P3D);
}

void setup() {
  frameRate(60);
  OFFSET_X = width/2.8f;
  OFFSET_Y = height/1.8f;
  OFFSET_Z = width/2.86f;
}

void draw() {
  background(0,10,30);
  lights();
  
  tileset.Draw();
  
  DrawAxis();
}

void DrawAtCursor() {
  push();
  PVector mousePos;
  mousePos = new PVector(mouseX,mouseY);
  PVector mouseWorldPos;
  mouseWorldPos = mousePos.copy();
  //mouseWorldPos.sub(new PVector(960, 487));
  mouseWorldPos.sub(new PVector(960/2, 0));
  
  tileset.SelectTile(mouseWorldPos);
  
  pop();
}

void mousePressed() {
  DrawAtCursor();
}

void mouseDragged() {
  DrawAtCursor();
}
