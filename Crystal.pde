class Crystal {
  
 float posX;
 float posY; 
 boolean showOutline = false;

ArrayList<Layer> allLayers = new ArrayList<Layer>();

 Crystal(float x, float y, color[] palette) {
    posX = x;
    posY = y;
    allLayers = new ArrayList();
    float picker = random(0, 1);
    
    allLayers.add(new DebugLines(palette));
    
    boolean steppedHexagons = picker < 0.2 ? allLayers.add(new SteppedHexagons(palette)) : false;
    println("steppedHexagons: " + steppedHexagons);
    if (!steppedHexagons) {
      picker = random(0, 1);
      boolean outlineShape = picker < 0.6 ? allLayers.add(new OutlineShape(palette)) : false;
      println("outlineShape: " + outlineShape);
    }
    
    picker = random(0, 1);
    boolean centerShape = picker < 0.4 ? allLayers.add(new CenteredShape(palette)) : false;
    println("centerShape: " + centerShape);

    picker = random(0, 1);
    boolean ringOfShapes = picker < 0.7 ? allLayers.add(new RingOfShapes(palette)) : false;
    println("ringOfShapes: " + ringOfShapes);
    
    picker = random(0, 1);
    boolean circles = picker < 0.4 ? allLayers.add(new Circles(palette)) : false;
    println("circles: " + circles);
    
    allLayers.add(new SimpleLines(palette));
    // allLayers.add(new DottedLines(palette));
        
 }
 
 void render() { 
     for(int i = 0; i < allLayers.size(); i++) {
        allLayers.get(i).render(posX, posY); 
     }
   
    if (showOutline) {
      stroke(255, 0, 0);
      strokeWeight(1);
      noFill();
      ellipse(posX, posY, CRYSTAL_SIZE, CRYSTAL_SIZE);
    }
 }
}