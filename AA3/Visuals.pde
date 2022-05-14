void ShiftPerspective() {
  rotateX(radians(ROTATION_X));
  rotateY(radians(ROTATION_Y));
  translate(OFFSET_X, OFFSET_Y, OFFSET_Z);
}

PVector ScreenToWorld(PVector input) {
  // :'  (
  
  float[] point = {input.x,input.y,input.z,1};
  float[] output_1 = new float[4];
  float[] output_2 = new float[4];
  
  float[][] xRotationMatrix = {{1,0,0,0},
                              {0,cos(radians(ROTATION_X)),-sin(radians(ROTATION_X)),0},
                              {0,sin(radians(ROTATION_X)),cos(radians(ROTATION_X)),0},
                              {0,0,0,1}};
    
  float[][] yRotationMatrix = {{cos(radians(ROTATION_Y)),0,sin(radians(ROTATION_Y)),0},
                              {0,1,0,0},
                              {-sin(radians(ROTATION_Y)),0,cos(radians(ROTATION_Y)),0},
                              {0,0,0,1}};
  
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
  
  return new PVector(output_2[0],output_2[1],output_2[2]);
}

void DrawAxis() {
  push();
  strokeWeight(1);
  stroke(50,35,20);
  fill(50,35,20);
  ShiftPerspective();
  textSize(50);
  line(1000, 0, 0, -1000, 0, 0);
  text("x", 1000, 0, 0);
  line(0, 1000, 0, 0, -1000, 0);
  text("y", 0, 1000, 0);
  line(0, 0, 1000, 0, 0, -1000); 
  text("z", 0, 0, 1000);
  pop();
}
