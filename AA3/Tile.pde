class Tile {
  
  PVector pos;
  PVector size;
  color color_f;
  
  Tile(PVector pos, PVector size) {
    this.pos = pos.copy();
    this.size = size;
    color_f = BASE_COLOR;
  }

  void Draw() {
    push();
    translate(pos.x,pos.y,pos.z);
    fill(color_f);
    noStroke();
    box(size.x,size.y,size.z);
    pop();
  }

}
