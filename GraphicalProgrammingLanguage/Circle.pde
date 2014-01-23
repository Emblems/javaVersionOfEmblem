class Circle extends Representation
{
  float radius;
  
  Circle()
  {
    radius = 50;
  }
  
  void show()
  {
    fill(c);
    
    ellipse(0, 0, radius*2, radius*2);
    
    super.show();
  }
  
  void showHover()
  {
    fill(c);
    
    int d = 10;
    ellipse(0, 0, (radius+d)*2, (radius+d)*2);
    
    super.showHover();
  }
  
  boolean containsOffset(PVector offset)
  {
    return offset.mag() < radius;
  }
}
