  class Function extends GraphVertex
{
  Function()
  {
    functionsThatThisPointsTo = new ArrayList();

    name = "undefined";

    description = "No description";
    
    representation = new Circle();
  }

  void show()
  {
    if (mouseOver())
      representation.radius = mouseOverRadius;
    else
      representation.radius = defaultRadius;
      
    representation.show();
      
    pushMatrix();
    translate(representation.loc);
    
    fill(0);
    textAlign(CENTER, CENTER);
    text(name, 0, -2);
    
    popMatrix();

    for (int i = 0; i < functionsThatThisPointsTo.size(); i++)
    {
      Function sink = (Function)functionsThatThisPointsTo.get(i);

      arrow(this, sink);
    }
    //If you drag it to the trash can, kill it 
    if (representation.loc.dist(trashLocation) < 100 && dragging != this) functions.remove(this);
  }

  String execute(String input)
  {
    if (functionsThatThisPointsTo.size() > 0)
      return ((Function)functionsThatThisPointsTo.get(0)).execute(input);
      
    return input;
  }
  
  PVector loc()
  {
    return representation.loc;
  }
}

