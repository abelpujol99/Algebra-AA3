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
    int id = 0;
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        PVector tilePos = new PVector(j * tileSize, 0, i * tileSize);
        tile[i][j] = new Tile(id, tilePos.add(pos), new PVector(tileSize, TILE_HEIGHT, tileSize));
        id++;
      }
    }
  }


  void SelectTile(int id) {
    if (id < rows * cols && !tile[id/cols][id%cols].IsSelected()) {
      tile[id/cols][id%cols].Select();
    }
  }

  void Draw() {
    int id = 0;
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        picker.start(id);
        tile[i][j].Draw();
        id++;
      }
    }

    picker.stop();

    push();
    PVector size = new PVector(rows * tileSize, cols * tileSize);
    translate(pos.x + size.x/2f - tileSize/2, pos.y, pos.z + size.y/2f - tileSize/2);
    strokeWeight(2);
    fill(BORDER_COLOR);
    stroke(BORDER_COLOR);
    box(size.x+1, TILE_HEIGHT-1, size.y+1);
    pop();
  }
}
