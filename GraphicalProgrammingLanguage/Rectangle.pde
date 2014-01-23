class Rectangle extends Representation
{
  PVector dimensions;
  
  Rectangle()
  {
    dimensions = new PVector(50, 50);
  }
  
  void show()
  {
    rect(dimensions);
  }
  void showHover()
  {
    rect(dimensions);
  }
  
  boolean containsOffset(PVector offset)
  {
    return less(PVector.mult(abs(offset), 2), dimensions);
  }
}
