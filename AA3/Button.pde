class Button {

  int id;
  private boolean active = true;
  private PVector pos;
  private int size;
  private color color_f;
  private color colorActive;
  private color colorInactive;

  Button(int id, PVector pos, int size, color colorActive) {
    this.id = id + 1000;
    this.pos = pos.copy();
    this.size = size;
    this.colorActive = colorActive;
    this.colorInactive = color((red(colorActive)+green(colorActive)+blue(colorActive))/3);
  }

  boolean CheckPress(int x, int y) {
    return ((x < pos.x+size/2 && x > pos.x-size/2) && (y < pos.y+size/3 && y > pos.y-size/3));
  }

  void Draw() {
    push();
    if (active) {
      color_f = colorActive;
    }
    else {
      color_f = colorInactive;
    }
    
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
  
  void CameraIcon() {
    push();
    translate(pos.x, pos.y, pos.z);
    fill(200,210,210);
    strokeWeight(0);
    translate(-size/4,-size/6);
    rect(0,0,size/2,3*size/8,10);
    push();
    noFill();
    strokeWeight(3);
    stroke(color_f);
    ellipse(size/4,1.5*size/8,size/5,size/5);
    pop();
    translate(size/4,0,0);
    beginShape();
    vertex(-size/7,0);
    vertex(size/7,0);
    vertex(size/9,-size/15);
    vertex(-size/9,-size/15);
    endShape(CLOSE);
    pop();
  }
  
  void SetActive() {
    active = true;
  }
  
  void SetInactive() {
    active = false;
  }
}
