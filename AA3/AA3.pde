//import camera3D.Camera3D;
import picking.*;

////////////////////////    CONSTANTS    ////////////////////////

final float DIVERGENCE = 1f;
final color BACKGROUND_COLOR = color(0, 10, 30);
final color BASE_COLOR = color(130, 170, 170);
final color BORDER_COLOR = color(60, 80, 80);
final color CUTSCENE_BUTTON_COLOR = color(20, 100, 110);
final color BUTTON_TEXT_COLOR = color(200, 210, 210);

final float ROTATION_X = -35.26f;
final float ROTATION_Y = 45f;
final float ROTATION_Z = 0f; 
float OFFSET_X;
float OFFSET_Y;
float OFFSET_Z;

final float PLANE_START_OFFSET = 2000;
final float PLANE_Y = -10;

PVector TILESET_POS = new PVector(-500, 0, -500);
final int ROWS = 21;
final int COLS = 21;
final float TILE_SIZE = 50f;

////////////////////////    Variables    ////////////////////////

Tileset tileset = new Tileset(TILESET_POS, ROWS, COLS, TILE_SIZE);
Plane plane;

Camera camera;
//Camera3D cam3d;
Picker picker;

Button cutsceneButton;
boolean cutscene = false;

////////////////////////    Game    ////////////////////////

void settings() {
  size(1920, 1050, P3D);
}

void setup() {
  frameRate(60);
  smooth();
  OFFSET_X = width/2.8f;
  OFFSET_Y = height/1.9f;
  OFFSET_Z = width/2.86f;

  ResetCamera();
  //cam3d = new Camera3D(this);
  //cam3d.setBackgroundColor(BACKGROUND_COLOR);
  //cam3d.renderDefaultAnaglyph().setDivergence(DIVERGENCE);

  cutsceneButton = new Button(1, new PVector(width/20, 19*height/20), width/20, CUTSCENE_BUTTON_COLOR);

  picker = new Picker(this);
  
  plane = new Plane(200);
}

void draw() {
  background(0, 10, 30);
  lights();

  //Draw
  //UI
  if (!cutscene) {
    picker.start(cutsceneButton.id);
    cutsceneButton.Draw();
    cutsceneButton.CameraIcon();
  }

  //Camera
  camera.Perspective();
  if (cutscene) {
    cutscene = camera.Move();
  }
  //Planes
  plane.Move();
  plane.Draw();
  //Terrain
  tileset.Draw();
  camera.DrawAxis();

  picker.stop();
}

void DrawAtCursor() {
  push();

  int id = picker.get(mouseX, mouseY);

  if (id >= 0) {
    tileset.SelectTile(id);
  }

  pop();
}

void PressButton() {
  int id = picker.get(mouseX, mouseY);
  if (id == cutsceneButton.id && !cutscene) {
    ResetCamera();
    cutscene = true;
  }
}

void ResetCamera() {
  camera = new Camera(new PVector(OFFSET_X, OFFSET_Y, OFFSET_Z), new PVector(ROTATION_X, ROTATION_Y, ROTATION_Z));
}

void mousePressed() {
  DrawAtCursor();
  PressButton();
}

void mouseDragged() {
  DrawAtCursor();
}
