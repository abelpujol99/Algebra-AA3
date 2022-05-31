color Brighten(color in, float add) {  
  return color((red(in)+add) % 256, (green(in)+add) % 256, (blue(in)+add) % 256);
}

color Darken(color in, float add) {  
  return color((red(in)-add) % 256, (green(in)-add) % 256, (blue(in)-add) % 256);
}

float GetLuma(color in) {
  return 0.299*red(in) + 0.587*green(in) + 0.114*blue(in);
}
