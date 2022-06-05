class Tile {

  int id;
  int cutscene_id = -1;
  private PVector pos;
  private PVector size;
  private color color_f;
  private color color_c;

  private boolean selected = false;
  private boolean buildingDone = false;
  static final int MAX_BUILDING_HEIGHT = 350;
  static final int MIN_BUILDING_HEIGHT = 120;
  private final int MAX_ANIMATION_TIME = 20;
  private final int MIN_ANIMATION_TIME = 15;
  private int animationTime;

  private int buildingHeight;

  Tile(int id, PVector pos, PVector size) {
    this.id = id;
    this.pos = pos.copy();
    this.size = size;
    color_f = BASE_COLOR;
    color_c = color(100,230,150);
  }

  void Select() {
    selected = true;
    animationTime = int(random(MIN_ANIMATION_TIME, MAX_ANIMATION_TIME));

    //building init
    buildingHeight = int(random(MIN_BUILDING_HEIGHT, MAX_BUILDING_HEIGHT));
  }

  void Draw() {
    push();

    translate(pos.x, pos.y, pos.z);

    push();
    //base
    noStroke();
    fill(color_f);
    if (cutscene_id >= 0) {
      fill(color_c);
    }
    box(size.x, size.y, size.z);
    pop();

    //building
    if (selected) {

      DrawBuilding(animationTime);

      if (!buildingDone) {
        if (animationTime == 0) {
          buildingDone = true;
        } else {
          animationTime--;
        }
      }
    }

    pop();
  }

  private void DrawBuilding(int time) {
    push();

    float h = buildingHeight;
    if (time > 0) {
      h = float(buildingHeight) / (1f + time/8f);
    }

    translate(0, (h + size.y) / -2, 0);
    box(size.x, h, size.z);

    pop();
  }

  void SetColor(color newColor) {
    color_f = newColor;
  }

  boolean IsSelected() {
    return selected;
  }
  
  PVector GetPos() {
    return pos;
  }
}
