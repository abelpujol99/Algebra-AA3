class Tileset {
  
  private PVector pos;
  private Tile[][] tile;
  private float tileSize;
  private final float TILE_HEIGHT = 40f;
  private int rows, cols;
  
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
  
  
  void SelectTile(PVector pos) {
    
    int x = int(pos.x / tileSize);
    int y = int(pos.y / tileSize);
    if (x < cols && x >= 0 && y < rows && y >= 0) {
      if (!tile[y][x].IsSelected()) {
        tile[y][x].Select();
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
