class Rectangle extends Shape
{
  PVector dimensions;
  
  Rectangle()
  {
    dimensions = new PVector(50, 50);
  }
  
  void show()
  {
    rect(loc, dimensions);
  }
}
