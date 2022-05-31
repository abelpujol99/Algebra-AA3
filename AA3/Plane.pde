class Plane {

  private PVector pos;
  private PVector posInit;
  private PVector posFinal;
  private float steps;
  private PVector points[];
  private int curveNum;
  private InterpolationCurve curve;
  private float time;
  private float size;

  Plane(float steps) {
    Spawn();
    this.steps = steps;
  }

  void Spawn() {
    time = 0;
    size = random(width/150, width/100);
    RandomPosInit();
    pos = posInit.copy();
    curveNum = int(random(2, 4));
    points = new PVector[4];
    points[3] = posInit.copy();
    CalculateNewCurve();
    curve = new InterpolationCurve(points);
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
          print(points[3]);
        }
        //update curve
        curve = new InterpolationCurve(points);
      }
      time += 100f / steps;
    }
    return ret;
  }

  void CalculateNewCurve() {
    points[0] = points[3].copy();
    points[1] = new PVector(random(-COLS * TILE_SIZE / 2, COLS * TILE_SIZE / 2), PLANE_Y, random(-ROWS * TILE_SIZE / 2, ROWS * TILE_SIZE / 2));
    points[2] = new PVector(random(-COLS * TILE_SIZE / 2, COLS * TILE_SIZE / 2), PLANE_Y, random(-ROWS * TILE_SIZE / 2, ROWS * TILE_SIZE / 2));
    points[3] = new PVector(random(-COLS * TILE_SIZE / 2, COLS * TILE_SIZE / 2), PLANE_Y, random(-ROWS * TILE_SIZE / 2, ROWS * TILE_SIZE / 2));
  }

  void RandomPosInit() {
    float angle = random(0, 360);
    posInit = new PVector(PLANE_START_OFFSET * cos(radians(angle)), PLANE_Y, PLANE_START_OFFSET * sin(radians(angle)));
    posFinal = new PVector(-posInit.x, PLANE_Y, -posInit.z);
    //dir = PVector.sub(new PVector(-posInit.x, posInit.y, -posInit.z), posInit);
  }

  void Draw() {
    push();
    translate(pos.x, pos.y, pos.z);
    sphere(size);
    pop();
  }
}
