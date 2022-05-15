class Camera {

  PVector pos;
  PVector posInit;
  PVector dir;
  PVector dirInit;
  PVector dirChange;

  BezierCurve curve;
  final int pointNum = 4;
  PVector[] points = new PVector[pointNum];
  final int steps = 500;
  float time = 0;

  Camera(PVector pos, PVector dir) {
    this.pos = pos.copy();
    this.posInit = pos.copy();
    this.dir = dir.copy();
    this.dirInit = dir.copy();
    dirChange = new PVector(0,0,0);

    points[0] = new PVector(0, 0, 0);  
    points[1] = new PVector(-500, 0, -1000);  
    points[2] = new PVector(1000, 0, 500);  
    points[3] = new PVector(0, 0, 0);
    curve = new BezierCurve(points);
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

  void Move() {
    if (time < 1f) {
      time += 1f / steps;
      
      PVector m = curve.CalculateCurvePoint(time);
      PVector p = posInit.copy();
      p.add(m);
      
      PVector r = new PVector(0,360*time,0);
      
      
      pos = p.copy();
      dirChange = r.copy();
    }
    else {
      ResetPos();
    }
  }
  
  void ResetPos() {
    pos = posInit.copy();
    dir = dirInit.copy();
    dirChange = new PVector(0,0,0);
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
