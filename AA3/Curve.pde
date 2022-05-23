class Curve {

  protected PVector[] p;
  protected PVector[] coefs;
  protected float[][] intMatrix;
  protected color color_p;
  protected color color_l;
  protected float size = 10f;
  protected int drawAccuracy;

  void Setup(PVector[] p) {

    this.p = new PVector[p.length];
    coefs = new PVector[p.length];
    
    for (int i = 0; i < p.length; i++) {
      this.p[i] = p[i].copy();
      
      coefs[i] = new PVector(0,0,0);
    }
    
    CalculateCoefs();
  }

  void CalculateCoefs() {
  
    for (int i = 0; i < this.p.length; i++) {
      for (int j = 0; j < this.p.length; j++) {
        coefs[i].x += p[j].x * intMatrix[i][j];
        coefs[i].y += p[j].y * intMatrix[i][j];
        coefs[i].z += p[j].z * intMatrix[i][j];
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
}
