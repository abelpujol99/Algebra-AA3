class Camera {

  PVector pos;
  PVector posInit;
  PVector dir;
  PVector dirInit;
  PVector dirChange;

  final int curveNum = 2;
  BezierCurve[] curve = new BezierCurve[curveNum];
  final int pointNum = 4;
  PVector[] points1 = new PVector[pointNum];
  PVector[] points2 = new PVector[pointNum];
  final int steps = 500;
  float time = 0;

  Camera(PVector pos, PVector dir) {
    this.pos = pos.copy();
    this.posInit = pos.copy();
    this.dir = dir.copy();
    this.dirInit = dir.copy();
    dirChange = new PVector(0, 0, 0);

    PVector endPoint = new PVector(-700, -300, 700);

    points1[0] = new PVector(0, 0, 0);  
    points1[1] = new PVector(0, 0, 1000);  
    points1[2] = new PVector(-400, 0, 1000);  
    points1[3] = endPoint.copy();
    curve[0] = new BezierCurve(points1);

    points2[0] = new PVector(0, 0, 0);  
    points2[1] = new PVector(0, 0, -200);  
    points2[2] = new PVector(0, 0, -1000);  
    points2[3] = endPoint.copy().mult(-1);
    curve[1] = new BezierCurve(points2);
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
      PVector p = posInit.copy();
      p.add(m);

      pos = p.copy();

      if (int(time / 100f) < int((time + (100f / steps)) / 100f)) {
        posInit = pos.copy();
      }
      time += 100f / steps;
    }
    return ret;
  }

  void ResetPos() {
    pos = posInit.copy();
    dir = dirInit.copy();
    dirChange = new PVector(0, 0, 0);
  }


  PVector ScreenToWorld(PVector input) {
    // :'  (

    float[] point = {input.x, input.y, input.z, 1};
    float[] output_1 = new float[4];
    float[] output_2 = new float[4];

    float[][] xRotationMatrix = {{1, 0, 0, 0}, 
      {0, cos(radians(ROTATION_X)), -sin(radians(ROTATION_X)), 0}, 
      {0, sin(radians(ROTATION_X)), cos(radians(ROTATION_X)), 0}, 
      {0, 0, 0, 1}};

    float[][] yRotationMatrix = {{cos(radians(ROTATION_Y)), 0, sin(radians(ROTATION_Y)), 0}, 
      {0, 1, 0, 0}, 
      {-sin(radians(ROTATION_Y)), 0, cos(radians(ROTATION_Y)), 0}, 
      {0, 0, 0, 1}};

    //X rotation
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        output_1[i] += point[j] * xRotationMatrix[i][j];
      }
    }

    //Y rotation
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        output_2[i] += output_1[i] * yRotationMatrix[i][j];
      }
    }

    return new PVector(output_2[0], output_2[1], output_2[2]);
  }

  void DrawAxis() {
    push();
    strokeWeight(1);
    stroke(50, 35, 20);
    fill(50, 35, 20);
    textSize(50);
    line(1000, 0, 0, -1000, 0, 0);
    text("x", 1000, 0, 0);
    line(0, 1000, 0, 0, -1000, 0);
    text("y", 0, 1000, 0);
    line(0, 0, 1000, 0, 0, -1000); 
    text("z", 0, 0, 1000);
    pop();
  }
}
