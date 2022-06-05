////////////////////////    CONSTANTS    ////////////////////////

final float DIVERGENCE = 1f;
final color BACKGROUND_COLOR = color(0, 10, 30);
final color BASE_COLOR = color(130, 170, 170);
final color BORDER_COLOR = color(60, 80, 80);
final color CUTSCENE_BUTTON_COLOR = color(20, 100, 110);
final color FILTER_BUTTON_COLOR = color(130, 80, 130);
final color BUTTON_TEXT_COLOR = color(200, 210, 210);

final float ROTATION_X = -35.26f;
final float ROTATION_Y = 45f;
final float ROTATION_Z = 0f; 
float OFFSET_X;
float OFFSET_Y;
float OFFSET_Z;

final float PLANE_START_OFFSET = 2000;
final float PLANE_Y = -250;
final int PLANE_STEPS = 200;
final color PLANE_COLOR = color(200, 240, 250);

final PVector TILESET_POS = new PVector(-500, 0, -500);
final int ROWS = 21;
final int COLS = 21;
final float TILE_SIZE = 50f;

final int POINT_NUM = 4;
final int CUTSCENE_CURVE_NUM = 2;

////////////////////////    Variables    ////////////////////////

Tileset tileset;

final int planeNum = 6;
Plane[] plane;

Camera camera;

Button cutsceneButton;
boolean cutscene = false;
Button filter1Button;
boolean filter1 = false;
Button filter2Button;
boolean filter2 = false;
Button filter3Button;
boolean filter3 = false;

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

  tileset = new Tileset(TILESET_POS, ROWS, COLS, TILE_SIZE);

  cutsceneButton = new Button(1, new PVector(width/20, 19*height/20), width/20, CUTSCENE_BUTTON_COLOR);
  cutsceneButton.SetInactive();
  filter1Button = new Button(2, new PVector(15*width/20, 19*height/20), width/20, FILTER_BUTTON_COLOR);
  filter2Button = new Button(3, new PVector(17*width/20, 19*height/20), width/20, FILTER_BUTTON_COLOR);
  filter3Button = new Button(4, new PVector(19*width/20, 19*height/20), width/20, FILTER_BUTTON_COLOR);


  plane = new Plane[planeNum];
  for (int i = 0; i < planeNum; i++) {
    plane[i] = new Plane(random(2*PLANE_STEPS/3, 4*PLANE_STEPS/3));
  }
}

void draw() {
  background(0, 10, 30);
  lights();

  //Draw

  //UI
  if (!cutscene) {
    cutsceneButton.Draw();
    cutsceneButton.CameraIcon();

    filter1Button.Draw();
    filter2Button.Draw();
    filter3Button.Draw();
  }

  //Camera
  camera.Perspective();
  if (cutscene) {
    cutscene = camera.Move();
  }

  //Planes
  for (int i = 0; i < planeNum; i++) {
    boolean succ = plane[i].Move();
    plane[i].Draw();
    if (!succ) {
      plane[i] = new Plane(random(2*PLANE_STEPS/3, 4*PLANE_STEPS/3));
    }
  }

  //Terrain
  tileset.Draw();
  camera.DrawAxis();

  //Filters
  FilterLoop();
}

void DrawAtCursor() {

  tileset.SelectTile(map(mouseY, 0, height, 0, ROWS * TILE_SIZE), map(mouseX, 0, width, 0, COLS * TILE_SIZE));
}

void PressRightButton() {

  tileset.SetCutscenePoint(map(mouseY, 0, height, 0, ROWS * TILE_SIZE), map(mouseX, 0, width, 0, COLS * TILE_SIZE));

  if (tileset.ValidCutscene()) {
    cutsceneButton.SetActive();
  } else {
    cutsceneButton.SetInactive();
  }
}

boolean PressLeftButton() {

  boolean ret = false;
  if (cutsceneButton.CheckPress(mouseX, mouseY)) {
    ret = true;
    if (tileset.ValidCutscene()) {
      ResetCamera();
      camera.SetCutscene();
      cutscene = true;
    }
  } else if (filter1Button.CheckPress(mouseX, mouseY)) {
    filter1 = !filter1;
    ret = true;
  } else if (filter2Button.CheckPress(mouseX, mouseY)) {
    filter2 = !filter2;
    ret = true;
  } else if (filter3Button.CheckPress(mouseX, mouseY)) {
    filter3 = !filter3;
    ret = true;
  }

  return ret;
}

void ResetCamera() {
  camera = new Camera(new PVector(OFFSET_X, OFFSET_Y, OFFSET_Z), new PVector(ROTATION_X, ROTATION_Y, ROTATION_Z));
}

void mousePressed() {
  if (mouseButton == LEFT) {
    if (!cutscene) {
      boolean pressedButton = PressLeftButton();
      if (!pressedButton) {
        DrawAtCursor();
      }
    }
  } else if (mouseButton == RIGHT) {
    PressRightButton();
  }
}

void mouseDragged() {
  if (mouseButton == LEFT) {
    if (!cutscene) {
      boolean pressedButton = PressLeftButton();
      if (!pressedButton) {
        DrawAtCursor();
      }
    }
  }
}
