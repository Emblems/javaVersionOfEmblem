class GraphVertex
{
  ArrayList functionsThatThisPointsTo;
  
  String name, description;
  
  Shape representation;
  
  GraphVertex()
  {
    representation = new Shape();
  }
  
  boolean mouseOver()
  {
    return representation.mouseOver();
  }
}
