final float CRT_SPEED = 300;

void FilterLoop() {

  if (filter1) {
    CRTFilter();
  }
  if (filter2) {
    GrayscaleFilter();
  }
}

void CRTFilter() {

  loadPixels();
  for (int y = 0; y < height; y++) {

    float t = (millis()) / CRT_SPEED;
    float mod1 = abs(sin(y * 50f - t * 5f)) * 8f;
    float mod2 = abs(sin(y * 150f - t * 10f)) * 0.5f;

    for (int x = 0; x < width; x++) {

      color in = pixels[x+y*width];

      color out = color(red(in)+mod1+mod2, green(in)+mod1+mod2, blue(in)+mod1+mod2);

      pixels[x+y*width] = out;
    }
  }
  updatePixels();
}

void GrayscaleFilter() {
  loadPixels();
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {

      color in = pixels[x+y*width];

      color out = color(GetLuma(in));

      pixels[x+y*width] = out;
    }
  }
  updatePixels();
}
