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
  
  PVector start = PVector.add(f1.getLocation(), PVector.mult(directionVector, f1.representation.arrowStopRadius));
  PVector end = PVector.sub(f2.getLocation(), PVector.mult(directionVector, f2.representation.arrowStopRadius));

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
void ellipse(PVector center, float widthAndHeight)
{
  ellipse(center.x, center.y, widthAndHeight, widthAndHeight);
}
void ellipse(float widthAndHeight)
{
  ellipse(0, 0, widthAndHeight, widthAndHeight);
}

void rect(PVector center, PVector dimensions)
{
  rect(center.x, center.y, dimensions.x, dimensions.y);
}
void rect(PVector dimensions)
{
  rect(ORIGIN, dimensions);
}
void rect(int x, int y, int widthAndHeight)
{
  rect(x, y, widthAndHeight, widthAndHeight);
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

void text(String str)
{
  text(str, 0, 0);
}
void text(String str, PVector location)
{
  text(str, location.x, location.y);
}

PVector div(PVector vec1, PVector vec2)
{
  return new PVector(vec1.x / vec2.x, vec1.y / vec2.y);
}
PVector mult(PVector vec1, PVector vec2)
{
  return new PVector(vec1.x * vec2.x, vec1.y * vec2.y);
}
PVector add(PVector vec1, PVector vec2)
{
  return PVector.add(vec1, vec2);
}
PVector sub(PVector vec1, PVector vec2)
{
  return PVector.sub(vec1, vec2);
}
PVector mult(PVector vec, float scalar)
{
  return PVector.mult(vec, scalar);
}
PVector div(PVector vec, float scalar)
{
  return PVector.div(vec, scalar);
}  

PVector floor(PVector vec)
{
  return new PVector(floor(vec.x), floor(vec.y));
}
PVector round(PVector vec)
{
  return new PVector(round(vec.x), round(vec.y));
}
PVector ceil(PVector vec)
{
  return new PVector(ceil(vec.x), ceil(vec.y));
}

PVector roundToNearest(PVector location, PVector spacing)
{
  return mult(round(div(location, spacing)), spacing);
}
