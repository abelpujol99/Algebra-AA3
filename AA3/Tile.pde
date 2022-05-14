class Tile {

  private PVector pos;
  private PVector size;
  private color color_f;

  private boolean selected = false;
  private boolean buildingDone = false;
  static final int MAX_BUILDING_HEIGHT = 350;
  static final int MIN_BUILDING_HEIGHT = 120;
  private final int MAX_ANIMATION_TIME = 20;
  private final int MIN_ANIMATION_TIME = 15;
  private int animationTime;

  private int buildingHeight;

  Tile(PVector pos, PVector size) {
    this.pos = pos.copy();
    this.size = size;
    color_f = BASE_COLOR;
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
    fill(color_f);
    noStroke();
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
}
