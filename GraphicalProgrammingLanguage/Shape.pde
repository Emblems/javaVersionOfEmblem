class Shape
{
  PVector loc;
  color c;
  int radius;
  
  Shape()
  {
    loc = new PVector(mouseX, mouseY);
    c = color(random(255), random(255), random(255));
    radius = 50;
  }
  
  void show()
  {
    ellipse(0, 0, 100, 100);
  }
  
  boolean mouseOver()
  {
    return false;
  }
}
