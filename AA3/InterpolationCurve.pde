class InterpolationCurve extends Curve {
  
  InterpolationCurve(PVector[] p, int drawAccuracy) {
    float[][] temp = {{1, 0, 0, 0},
                    {-5.5, 9, -4.5, 1},
                    {9, -22.5, 18, -4.5},
                    {-4.5, 13.5, -13.5, 4.5}};
    intMatrix = temp;
    
    Setup(p, drawAccuracy);
    
    color_p = color(50,250,100);
    color_l = color(50,200,150);
  }
}
