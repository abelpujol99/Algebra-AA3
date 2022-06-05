class Camera {

  PVector pos;
  PVector posInit;
  PVector dir;
  PVector dirInit;
  PVector dirChange;

  final int curveNum = CUTSCENE_CURVE_NUM;
  InterpolationCurve[] curve = new InterpolationCurve[curveNum];
  final int pointNum = POINT_NUM;
  PVector[][] points = new PVector[curveNum][pointNum];
  final int steps = 500;
  float time = 0;

  Camera(PVector pos, PVector dir) {
    this.pos = pos.copy();
    this.posInit = pos.copy();
    this.dir = dir.copy();
    this.dirInit = dir.copy();
    dirChange = new PVector(0, 0, 0);
  }


  void Perspective() {
    rotateX(radians(dir.x));
    rotateY(radians(dir.y));
    rotateZ(radians(dir.z));
    translate(pos.x, pos.y, pos.z);
    rotateX(radians(dirChange.x));
    rotateY(radians(dirChange.y));
    rotateZ(radians(dirChange.z));
  }

  boolean Move() {
    boolean ret = false;
    if (time / 100 < curveNum) {
      ret = true;
      float t = time % 100 / 100f;

      PVector m = curve[int(time/100)].CalculateCurvePoint(t);
      m.y = OFFSET_Y;

      pos = m.copy();

      time += 100f / steps;
    }
    return ret;
  }

  void ResetPos() {
    pos = posInit.copy();
    dir = dirInit.copy();
    dirChange = new PVector(0, 0, 0);
  }

  void SetCutscene() {
    if (tileset.ValidCutscene()) {
      for (int i = 0; i < curveNum; i++) {
        for (int j = 0; j < pointNum; j++) {

          //First point is starting pos
          if (i == 0 && j == 0) {
            points[i][j] = posInit.copy();
          }
          //Final point is starting pos
          else if (i == curveNum - 1 && j == pointNum - 1) {
            points[i][j] = posInit.copy();
          }
          //First point of each curve is final point of the previous
          else if (j == 0) {
            points[i][j] = tileset.GetCutscenePoint((pointNum-1) * i - 1);
          } else {
            points[i][j] = tileset.GetCutscenePoint((pointNum-1) * i + (j-1));
          }
        }
      }
    }
    curve[0] = new InterpolationCurve(points[0]);
    curve[1] = new InterpolationCurve(points[1]);
  }

  void DrawAxis() {
    push();
    strokeWeight(1);
    stroke(50, 35, 20);
    fill(50, 35, 20);
    textSize(50);
    line(1000, 0, 0, -1000, 0, 0);
    line(0, 1000, 0, 0, -1000, 0);
    line(0, 0, 1000, 0, 0, -1000); 
    pop();
  }
}
