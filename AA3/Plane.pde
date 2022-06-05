class Plane {

  private PVector pos;
  private PVector posInit;
  private PVector posFinal;
  private float steps;
  private PVector rot;
  private PVector points[];
  private int curveNum;
  private BezierCurve curve;
  private float time;
  private float size;

  private color color_f;

  Plane(float steps) {
    Spawn();
    this.steps = steps;
  }

  void Spawn() {
    time = 0;
    size = random(width/150, width/100);
    rot = new PVector(0, 0, 0);
    RandomPosInit();
    pos = posInit.copy();
    curveNum = int(random(2, 4));
    points = new PVector[4];
    points[3] = posInit.copy();
    CalculateNewCurve();
    curve = new BezierCurve(points);
    color_f = PLANE_COLOR;
  }

  //Move:
  //  Moves plane according to randomly generated
  //  interpolation curves
  boolean Move() {
    boolean ret = false;
    if (time / 100 < curveNum) {
      ret = true;
      float t = time % 100 / 100f;

      PVector m = curve.CalculateCurvePoint(t);

      pos = m.copy();

      //Check if the end of the curve has been reached and it's not the last curve
      if (int(time / 100f) < int((time + (100f / steps)) / 100f) && int(time / 100f) <= curveNum - 1) {
        //Calculate new curve
        CalculateNewCurve();
        //If the calculated curve is last, set plane's last point
        if (int(time / 100f) == curveNum - 2) {
          points[3] = posFinal.copy();
        }
        //update curve
        curve = new BezierCurve(points);
      }
      time += 100f / steps;
    }
    return ret;
  }

  void CalculateNewCurve() {
    points[0] = points[3].copy();
    points[1] = new PVector(random(-COLS * TILE_SIZE / 2, COLS * TILE_SIZE / 2), random(3*PLANE_Y/4, 5*PLANE_Y/4), random(-ROWS * TILE_SIZE / 2, ROWS * TILE_SIZE / 2));
    points[2] = new PVector(random(-COLS * TILE_SIZE / 2, COLS * TILE_SIZE / 2), random(3*PLANE_Y/4, 5*PLANE_Y/4), random(-ROWS * TILE_SIZE / 2, ROWS * TILE_SIZE / 2));
    points[3] = new PVector(random(-COLS * TILE_SIZE / 2, COLS * TILE_SIZE / 2), random(3*PLANE_Y/4, 5*PLANE_Y/4), random(-ROWS * TILE_SIZE / 2, ROWS * TILE_SIZE / 2));
  }

  void RandomPosInit() {
    float angle = random(0, 360);
    posInit = new PVector(PLANE_START_OFFSET * cos(radians(angle)), random(3*PLANE_Y/4, 5*PLANE_Y/4), PLANE_START_OFFSET * sin(radians(angle)));
    posFinal = new PVector(-posInit.x, random(3*PLANE_Y/4, 5*PLANE_Y/4), -posInit.z);
    rot.x = PVector.angleBetween(new PVector(0, 0, 0), new PVector(posInit.x, 0, 0));
    rot.y = PVector.angleBetween(new PVector(0, 0, 0), new PVector(0, posInit.y, 0));
    rot.z = PVector.angleBetween(new PVector(0, 0, 0), new PVector(0, 0, posInit.z));
  }

  void Draw() {
    push();
    translate(pos.x, pos.y - size/10, pos.z);
    rotateX(rot.x);
    rotateY(rot.y);
    rotateZ(rot.z);

    fill(color_f);
    stroke(Darken(color_f, 50));
    DrawShip(size);

    pop();
  }

  void DrawShip(float size) {
    push();
    noStroke();
    fill(color_f);
    sphere(size);
    pop();
  }

  void Triangle(PVector p1, PVector p2, PVector p3) {
    beginShape();
    vertex(p1.x, p1.y, p1.z);
    vertex(p2.x, p2.y, p2.z);
    vertex(p3.x, p3.y, p3.z);
    endShape(CLOSE);
  }
}
