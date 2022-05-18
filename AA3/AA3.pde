import camera3D.Camera3D;

////////////////////////    CONSTANTS    ////////////////////////

final float ROTATION_X = -35.26f;
final float ROTATION_Y = 45f;
final float ROTATION_Z = 0f; 
float OFFSET_X;
float OFFSET_Y;
float OFFSET_Z;

PVector TILESET_POS = new PVector(-500, 0, -500);
final int ROWS = 21;
final int COLS = 21;
final float TILE_SIZE = 50f;

final float DIVERGENCE = 1f;
final color BACKGROUND_COLOR = color(0, 10, 30);
final color BASE_COLOR = color(130, 170, 170);
final color BORDER_COLOR = color(60, 80, 80);

////////////////////////    Variables    ////////////////////////

Tileset tileset = new Tileset(TILESET_POS, ROWS, COLS, TILE_SIZE);
Plane plane = new Plane(500, new PVector(0, -350, 0));

Camera camera;
Camera3D cam3d;

////////////////////////    Game    ////////////////////////

void settings() {
  size(1920, 1050, P3D);
}

void setup() {
  frameRate(60);
  OFFSET_X = width/2.8f;
  OFFSET_Y = height/1.8f;
  OFFSET_Z = width/2.86f;

  camera = new Camera(new PVector(OFFSET_X,OFFSET_Y,OFFSET_Z), new PVector(ROTATION_X,ROTATION_Y,ROTATION_Z));
  cam3d = new Camera3D(this);
  cam3d.setBackgroundColor(BACKGROUND_COLOR);
  //cam3d.renderDefaultAnaglyph().setDivergence(DIVERGENCE);
}

void draw() {
  background(0, 10, 30);
  lights();

  //Draw
  push();

  camera.Perspective();
  //camera.Move();
  plane.Move();
  plane.Draw();

  tileset.Draw();
  camera.DrawAxis();

  pop();
}

void DrawAtCursor() {
  push();
  PVector mousePos;
  mousePos = new PVector(mouseX, mouseY);
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
