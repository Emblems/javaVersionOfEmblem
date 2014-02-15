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
    
    ellipse(radius*2);
    
    super.show();
  }
  
  void showHover()
  {
    fill(c);
    
    int d = 10;
    ellipse((radius+d)*2);
    
    super.showHover();
  }
  
  boolean containsOffset(PVector offset)
  {
    return offset.mag() < radius;
  }
}
