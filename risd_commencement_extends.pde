int CRYSTAL_SIZE = 130;
int SIDES = 6;
 color[] defaultPalette = {
  color(255, 52, 154),
  color(4, 0, 152),
 };
ArrayList<Crystal> allCrystals = new ArrayList<Crystal>();
float PADDING = CRYSTAL_SIZE * 0.2;
int MARGIN = int((CRYSTAL_SIZE / 2) + PADDING);

void setup() {
 size(1000, 1000);
 float gridBox = CRYSTAL_SIZE + PADDING;
 for (int x = MARGIN; x < width - PADDING; x += gridBox) {
    for (int y = MARGIN; y < height - PADDING; y += gridBox) {
      Crystal newCrystal = new Crystal(x, y, defaultPalette);
      allCrystals.add(newCrystal);
    }
 }
 //Crystal firstCrystal = new Crystal(width/2, height/2, defaultPalette);
 //allCrystals.add(firstCrystal);
 smooth();
}

void draw() {
  background(255);
  for(Crystal thisCrystal : allCrystals) {
     thisCrystal.render(); 
  }
}

// a single shape at the center, always at bottom (ternery @ Crystal level), if hexagon, pointed up
// shpaes on a circumference. filled or outlined (thick or thin), if triangle, facing in or out
// single circle or hexagon outline inside edge, thick or thin
// layers of hexagon outline, 7 steps with invisible 8th equal to outer circumference
// lines extending from center of varying length, with dist from center in steps, 6 or 12 around
// dotted lines extending from center, light or thick, 6 or 12 around

// Formula for finding a point on the circumference of a circle
// x = cx + r * cos(a)
// y = cy + r * sin(a)

// Tutorial steps
// write the rules (see above)
// set up the basic template for a Crystal and draw one with outlines
// build first shape, add helpers, etc. as you go. 