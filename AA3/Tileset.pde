class Tileset {

  private PVector pos;
  private Tile[][] tile;
  private float tileSize;
  private final float TILE_HEIGHT = 40f;
  private int rows, cols;

  private final int CUTSCENE_POINTS = CUTSCENE_CURVE_NUM * (POINT_NUM - 1) - 1;
  private PVector cutscenePoints[] = new PVector[CUTSCENE_POINTS];
  private int validCutscenePoints = 0;

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

  void SetCutscenePoint(float r, float c) {
    if (!tile[int(r/TILE_SIZE)][int(c/TILE_SIZE)].IsSelected()) {
      //Add point
      if (tile[int(r/TILE_SIZE)][int(c/TILE_SIZE)].cutscene_id == -1) {
        if (validCutscenePoints < CUTSCENE_POINTS) {

          PVector temp = tile[int(r/TILE_SIZE)][int(c/TILE_SIZE)].GetPos().copy();
          temp.sub(pos);

          cutscenePoints[validCutscenePoints] = temp.copy();
          tile[int(r/TILE_SIZE)][int(c/TILE_SIZE)].cutscene_id = validCutscenePoints;
          validCutscenePoints++;
        }
      }
      //Remove point
      else {

        tile[int(r/TILE_SIZE)][int(c/TILE_SIZE)].cutscene_id = -1;
        validCutscenePoints--;
      }
    }
  }

  void SelectTile(float r, float c) {

    if (!tile[int(r/TILE_SIZE)][int(c/TILE_SIZE)].IsSelected() && tile[int(r/TILE_SIZE)][int(c/TILE_SIZE)].cutscene_id == -1) {
      tile[int(r/TILE_SIZE)][int(c/TILE_SIZE)].Select();
    }
  }

  void Draw() {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        tile[i][j].Draw();
      }
    }

    push();
    PVector size = new PVector(rows * tileSize, cols * tileSize);
    translate(pos.x + size.x/2f - tileSize/2, pos.y, pos.z + size.y/2f - tileSize/2);
    strokeWeight(2);
    fill(BORDER_COLOR);
    stroke(BORDER_COLOR);
    box(size.x+1, TILE_HEIGHT-1, size.y+1);
    pop();
  }

  PVector GetCutscenePoint(int cid) {
    return cutscenePoints[cid];
  }

  boolean IsTileSelected(int x, int y) {
    return tile[x][y].IsSelected();
  }

  boolean ValidCutscene() {
    return validCutscenePoints == CUTSCENE_POINTS;
  }
}
