class Curve {

  protected PVector[] p;
  protected PVector[] coefs;
  protected float[][] intMatrix;
  protected color color_p;
  protected color color_l;
  protected float size = 10f;
  protected int drawAccuracy;

  void Setup(PVector[] p, int drawAccuracy) {

    this.p = new PVector[p.length];
    coefs = new PVector[p.length];
    
    for (int i = 0; i < p.length; i++) {
      this.p[i] = p[i].copy();
      
      coefs[i] = new PVector(0,0,0);
    }
    
    this.drawAccuracy = drawAccuracy;
    
    CalculateCoefs();
  }

  void CalculateCoefs() {
  
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        coefs[i].x += p[j].x * intMatrix[i][j];
        coefs[i].y += p[j].y * intMatrix[i][j];
      }
    }
  }

  PVector CalculateCurvePoint(float u) {
    
    PVector ret = new PVector(0,0,0);
    PVector[] temp = new PVector[coefs.length];
    
    for (int i = 0; i < coefs.length; i++) {
      temp[i] = coefs[i].copy();
      temp[i].mult(pow(u,i));
      ret.add(temp[i]);   
    }
    
    return ret;
  }

  void Draw() {
    push();

    strokeWeight(3);
    fill(color_l);
    stroke(color_l);
    for (float i = 0f; i < 1f; i += 1f / drawAccuracy) {
      PVector pos = CalculateCurvePoint(i);
      point(pos.x, pos.y);
    }

    strokeWeight(0);
    fill(color_p);
    for (int i = 0; i < p.length; i++) {
      ellipse(p[i].x, p[i].y, size, size);
    }

    pop();
  }
}
