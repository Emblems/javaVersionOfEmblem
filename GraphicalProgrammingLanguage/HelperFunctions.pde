final PVector ORIGIN = new PVector(0, 0);

void translate(PVector loc)
{
  translate(loc.x, loc.y);
}

/**
Draws an arrow from f1 to f2
*/
void arrow(GraphVertex f1, GraphVertex f2)
{
  int radius = 50;
  
  PVector directionVector = PVector.sub(f2.getLocation(), f1.getLocation());
  directionVector.normalize();
  
  PVector start = f1.getLocation();//PVector.add(f1.getLocation(), PVector.mult(directionVector, f1.representation.radius));
  PVector end = f2.getLocation();//PVector.sub(f2.getLocation(), PVector.mult(directionVector, f2.representation.radius));

  arrow(start.x, start.y, end.x, end.y);
}
void arrow(PVector loc1, PVector loc2)
{
  arrow(loc1.x, loc1.y, loc2.x, loc2.y);
}
void arrow(float x1, float y1, float x2, float y2)
{
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -10, -10);
  line(0, 0, 10, -10);
  popMatrix();
}

void line(PVector location1, PVector location2)
{
  line(location1.x, location1.y, location2.x, location2.y);
}

void ellipse(PVector center, PVector dimensions)
{
  ellipse(center.x, center.y, dimensions.x, dimensions.y);
}

void rect(PVector center, PVector dimensions)
{
  rect(center.x, center.y, dimensions.x, dimensions.y);
}
void rect(PVector dimensions)
{
  rect(ORIGIN, dimensions);
}

PVector abs(PVector vector)
{
  return new PVector(abs(vector.x), abs(vector.y));
}

boolean less(PVector vector1, PVector vector2)
{
  return vector1.x < vector2.x && vector1.y < vector2.y;
}

color randomColor()
{
  return color(random(255), random(255), random(255));
}

PVector copy(PVector vector)
{
  return new PVector(vector.x, vector.y);
}
