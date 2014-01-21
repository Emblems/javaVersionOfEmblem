void translate(PVector loc)
{
  translate(loc.x, loc.y);
}

void arrow(Function f1, Function f2)
{
  int radius = 50;
  
  PVector directionVector = PVector.sub(f2.representation.loc, f1.representation.loc);
  directionVector.normalize();
  
  PVector start = PVector.add(f1.representation.loc, PVector.mult(directionVector, f1.representation.radius));
  PVector end = PVector.sub(f2.representation.loc, PVector.mult(directionVector, f2.representation.radius));

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

void ellipse(PVector center, PVector dimensions)
{
  ellipse(center.x, center.y, dimensions.x, dimensions.y);
}
void rect(PVector center, PVector dimensions)
{
  rect(center.x, center.y, dimensions.x, dimensions.y);
}
