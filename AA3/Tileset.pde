class Tileset {
  
  PVector pos;
  Tile[][] tile;
  float tileSize;
  final float TILE_HEIGHT = 40f;
  int rows, cols;
  
  Tileset(PVector pos, int rows, int cols, float tileSize) {
  
    this.pos = pos.copy();
    this.rows = rows;
    this.cols = cols;
    this.tileSize = tileSize;
    
    tile = new Tile[rows][cols];
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        PVector tilePos = new PVector(j * tileSize, 0, i * tileSize);
        tile[i][j] = new Tile(tilePos.add(pos), new PVector(tileSize,TILE_HEIGHT,tileSize));
      }
    }
    
  }
  
  void Draw() {
    push();
    ShiftPerspective();
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        tile[i][j].Draw();
      }
    }
    PVector size = new PVector(rows * tileSize, cols * tileSize);
    translate(pos.x + size.x/2f - tileSize/2 , pos.y ,pos.z + size.y/2f - tileSize/2);
    strokeWeight(2);
    fill(BORDER_COLOR);
    stroke(BORDER_COLOR);
    box(size.x+1,TILE_HEIGHT-1,size.y+1);
    pop();
  }
  
}
