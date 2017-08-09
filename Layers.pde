class Layer {
  int sides = SIDES;
  color c;
  int numShapes;
  float shapeSize; 
  float startAngle;
  float angle;
  int stepsOut = 8;
  int singleStep = (CRYSTAL_SIZE / 2) / stepsOut;
  int thinStroke = 1;
  int thickStroke = 3;
  
  Layer (color[] palette) {
    c = getRandomColorFromPalette(palette);
    rectMode(CENTER);
  }
  
  void render(float posX, float posY) {};
}

/* --------------------------------------------  STEPPED HEXAGONS */
class SteppedHexagons extends Layer {
    int numSteps;
    int strokeWidth;
  
    SteppedHexagons(color[] palette) {
      super(palette); 
      numShapes = 6;
      startAngle = randomSelectTwo() ? calcStartAngle(numShapes) : 0;
      angle = TWO_PI / numShapes;
      numSteps = randomSelectTwo() ? stepsOut : int(stepsOut * 1.25);
      strokeWidth = randomSelectTwo() ? thinStroke : thickStroke;
    }
    
    void render(float posX, float posY) {
      stroke(c);
      noFill();
      strokeWeight(strokeWidth);
      pushMatrix();
      translate(posX, posY);
      rotate(startAngle);
      float centerOffset = CRYSTAL_SIZE / 2 * 0.15;
      float step = ((CRYSTAL_SIZE / 2) - centerOffset) / numSteps;
      for (float i = 1; i < numSteps+1; i++ ){
        hexagon(0, 0, centerOffset + (i * step));
      }
      popMatrix();
    }
}

/* --------------------------------------------  OUTLINE SHAPE */
class OutlineShape extends Layer {
   boolean hexagon;
   int strokeWeight;
  
   OutlineShape(color[] palette) {
     super(palette);
     numShapes = 6;
     startAngle = randomSelectTwo() ? calcStartAngle(numShapes) : 0;
     hexagon = randomSelectTwo(); // hexagon or circle only.
     strokeWeight = randomSelectTwo() ? thinStroke : thickStroke;
   }
   
   void render(float posX, float posY) {
      stroke(c);
      noFill();
      strokeWeight(strokeWeight);
      pushMatrix();
      translate(posX, posY);
      rotate(startAngle);
      if (hexagon) {
       hexagon(0, 0, CRYSTAL_SIZE / 2 - (singleStep/2));
      } else {
       ellipse(0, 0, CRYSTAL_SIZE - singleStep, CRYSTAL_SIZE - singleStep); 
      }
      popMatrix();
   }
}

/* --------------------------------------------  RING OF SHAPES */
class RingOfShapes extends Layer {
  float steps;
  float radius;
  float center;
  color fillColor;
  int strokeWeight;
  float randomShape;
  boolean direction;
  
  RingOfShapes(color[] palette) {
     super(palette);
     numShapes = SIDES;
     startAngle = randomSelectTwo() ? calcStartAngle(numShapes) : 0;
     angle = TWO_PI / numShapes;
    
     steps = floor(random(1, stepsOut));
     center = steps * singleStep;
     if (steps < stepsOut/2) {
       radius = floor(random(1, steps)) * singleStep; 
     } else if (steps > stepsOut/2) {
        radius = floor(random(1, stepsOut - steps)) * singleStep; 
     } else {
        radius = floor(random(1, (stepsOut/2) + 1)) * singleStep; 
     }
     
     randomShape = random(0, 1);
     direction = randomSelectTwo(); // for triangle only
     fillColor = randomSelectTwo() ? c : color(0, 1);
     strokeWeight = randomSelectTwo() ? thinStroke : thickStroke;
   }
   
   void render(float posX, float posY) {
      stroke(c);
      fill(fillColor);
      strokeWeight(strokeWeight);
      pushMatrix();
      translate(posX, posY);
      rotate(startAngle);
      for (int i = 0; i < SIDES; i++) {
      // circle = 33%, square = 33%, triangle = 33%
        if (randomShape < 0.33) {
           ellipse(0, center, radius, radius);
        } else if (randomShape > 0.33 && randomShape < 0.66) {
           rect(0, center, radius, radius);
        } else if (randomShape > 0.66) {
            myTriangle(center, radius, direction);
        }
        rotate(angle); 
      } 
      popMatrix();
   }
}

/* --------------------------------------------  CENTERED SHAPE */
class CenteredShape extends Layer {
  float randomShape;
  float shapeSize;
  
  CenteredShape(color[] palette) {
       super(palette);
       randomShape = random(0, 1);
       shapeSize = floor(random(stepsOut/2, stepsOut)) * singleStep;
   }
   
   void render(float posX, float posY) {
      stroke(c);
      fill(c);
      strokeWeight(1);
      pushMatrix();
      translate(posX, posY);
      // hexagon = 60%, circle = 30%, square = 10%
      if (randomShape < 0.1) {
        rect(0, 0, shapeSize * 2, shapeSize * 2);
      } else if (randomShape < 0.3) {
         ellipse(0, 0, shapeSize * 2, shapeSize * 2);
      } else if (randomShape < 0.6) {
        hexagon(0, 0, shapeSize);
      }
      popMatrix();
   } 
}

/* --------------------------------------------  CIRCLES */
class Circles extends Layer {
   boolean outline;
   int stepPosition;
   
   Circles(color[] palette) {
      super(palette);
      numShapes = randomSelectTwo() ? sides : sides * 2;
      startAngle = calcStartAngle(numShapes);
      angle = TWO_PI / numShapes;
    
      shapeSize = CRYSTAL_SIZE * 0.25;
      outline = randomSelectTwo();
      stepPosition = floor(random(4, stepsOut)) * singleStep;
   }
   
   void render(float posX, float posY) {
    stroke(c);
    color fillColor = outline ? color(0, 1) : c;
    fill(fillColor);
    strokeWeight(thinStroke);
    pushMatrix();
    translate(posX, posY);
    rotate(startAngle);
    for (int i = 0; i <= numShapes; i++) {
       ellipse(stepPosition, 0, shapeSize, shapeSize);
       rotate(angle);
    }
    popMatrix(); 
   }
}

/* --------------------------------------------  DOTTED LINES */
class DottedLines extends Layer {
  float stepOut = (CRYSTAL_SIZE / 2) / stepsOut;
  float centerOffset = stepOut;
  
  DottedLines(color[] palette) {
     super(palette);
     numShapes = randomSelectTwo() ? sides : sides * 2;
     startAngle = calcStartAngle(numShapes);
     angle = TWO_PI / numShapes;
    
     shapeSize = 3;
  }
  
  void render(float posX, float posY) {
    fill(c);
    noStroke();
    pushMatrix();
    translate(posX, posY);
    rotate(startAngle);
    for(int i = 0; i <= numShapes; i++) {
      for (float x = centerOffset; x < CRYSTAL_SIZE/2; x+=stepOut) {
       rect(x, 0, shapeSize, shapeSize);
     }
       rotate(TWO_PI / numShapes);
    }
    popMatrix();
  }
}

/* --------------------------------------------  SIMPLE LINES */
class SimpleLines extends Layer {    
 SimpleLines(color[] palette) {
    super(palette);
    numShapes = randomSelectTwo() ? sides : sides * 2;
    startAngle = calcStartAngle(numShapes);
    angle = TWO_PI / numShapes;
 }

 void render(float posX, float posY) {    
    stroke(c);
    noFill();
    strokeWeight(thinStroke);
    pushMatrix();
    translate(posX, posY);
    rotate(startAngle);
    for(float i = 0; i < TWO_PI-0.1; i += angle) {
       line(0, 0, 0, CRYSTAL_SIZE/2);
       rotate(angle);
    }
    popMatrix();
 }
}

/* --------------------------------------------  DEBUG LINES */
class DebugLines extends Layer {    
 DebugLines(color[] palette) {
    super(palette);
    numShapes = randomSelectTwo() ? sides : sides * 2;
    startAngle = calcStartAngle(numShapes);
    angle = TWO_PI / numShapes;
 }

 void render(float posX, float posY) {    
    stroke(c);
    noFill();
    strokeWeight(thinStroke);
    pushMatrix();
    translate(posX, posY);
    rotate(startAngle);
    for(float i = 0; i < TWO_PI-0.1; i += angle) {
       line(0, 0, 0, CRYSTAL_SIZE/2);
       rotate(angle);
    }
    popMatrix();
 }
}