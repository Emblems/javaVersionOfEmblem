  class Circle extends Shape
{
  Circle()
  {
  }
  
  void show()
  {
    pushMatrix();
    translate(loc);
    
    fill(c);
    ellipse(0, 0, radius*2, radius*2);
    
    popMatrix();
  }
  
  boolean mouseOver()
  {
    return mouse().dist(loc) < radius;
  }
}
