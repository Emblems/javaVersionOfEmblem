class GraphVertex
{
  ArrayList<GraphVertex> children;
  PVector location;
  
  Representation representation;

  GraphVertex()
  {
    representation = new Circle();
    
    children = new ArrayList<GraphVertex>();
  }

  boolean mouseOver()
  {
    return representation.containsOffset(PVector.sub(getLocation(), mouse()));
  }

  PVector getLocation()
  {
    return location;
  }

  void setLocation(PVector location)
  {
    this.location = location;
  }

  void show()
  {
      
    pushMatrix();
    translate(getLocation());

    if (mouseOver())
      representation.showHover();
    else
      representation.show();

    popMatrix();
  }
  
  void drop()
  {
    if (gridEnabled)
      setLocation(roundToNearest(getLocation(), gridSpacing));
  }
}
