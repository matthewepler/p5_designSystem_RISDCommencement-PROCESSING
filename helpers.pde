float calcStartAngle (int num) {
  switch(num) {
      case 12:
        return 0;
      case 6:
        return radians((360/6) / 2);
      default:
        return 0;
  }
}

color getRandomColorFromPalette (color[] palette) {
  return palette[floor(random(0, palette.length))];
}

boolean randomSelectTwo() {
  float rando = random(2);
  return rando > 1 ? true : false; 
}

void hexagon(float posX, float posY, float radius) {
  float rotAngle = TWO_PI / 6;
  beginShape();
  for (int i = 0; i < 6; i++) {
    PVector vertex = pointOnCircle(posX, posY, radius, i * rotAngle);
    vertex(vertex.x, vertex.y);
  }
  endShape(CLOSE);
  
  
}

PVector pointOnCircle (float posX, float posY, float radius, float angle) {
   float x = posX + radius * cos(angle);
   float y = posY + radius * sin(angle);
   return new PVector(x, y);
}

void myTriangle(float center, float radius, boolean direction) {
  if (direction) {
    beginShape();
    vertex(center + radius * cos(0), radius * sin(0));
    vertex(center + radius * cos(radians(120)), radius * sin(radians(120)));
    vertex(center + radius * cos(radians(240)), radius * sin(radians(240)));
    endShape(CLOSE); 
  } else {
    beginShape();
    vertex(center + radius * cos(radians(180)), radius * sin(radians(180)));
    vertex(center + radius * cos(radians(300)), radius * sin(radians(300)));
    vertex(center + radius * cos(radians(60)), radius * sin(radians(60)));
    endShape(CLOSE);
  }
}