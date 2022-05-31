class Button {

  int id;
  private PVector pos;
  private int size;
  private color color_f;


  Button(int id, PVector pos, int size, color color_f) {
    this.id = id + 1000;
    this.pos = pos.copy();
    this.size = size;
    this.color_f = color_f;
  }


  void Draw() {
    push();
    translate(pos.x, pos.y, pos.z);
    fill(color_f);
    strokeWeight(2);
    beginShape();
    stroke(Darken(color_f, 40));
    vertex(-size/2, -size/3);  
    vertex(size/2, -size/3);
    stroke(Brighten(color_f, 40));
    vertex(size/2, size/3);
    vertex(-size/2, size/3);
    endShape(CLOSE);
    
    pop();
  }
}
