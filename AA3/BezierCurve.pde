class BezierCurve extends Curve {
  
  BezierCurve(PVector[] p, int drawAccuracy) {
    float[][] temp = {{1, 0, 0, 0},
                    {-3, 3, 0, 0},
                    {3, -6, 3, 0},
                    {-1, 3, -3, 1}};
    intMatrix = temp;
    
    Setup(p, drawAccuracy);
    
    color_p = color(250,50,100);
    color_l = color(200,50,150);
  }
}
