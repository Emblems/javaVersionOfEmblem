class TestObject
{
  Object data;
  PVector location;

  GraphVertex next;

  TestObject(Object input, GraphVertex start)
  {
    this(input, start, null);
  }
  TestObject(Object input, GraphVertex start, FunctionDefinition callback)
  {
    this.data = input;
    
    next = start;
    this.location = copy(start.location);
  }

  void show()
  {
    pushMatrix();
    translate(location);

    if (data instanceof String)
      text((String)data);
    else if (data instanceof Float)
      text("" + (Float)data);
    else if (data instanceof Integer)
      text("" + (Integer)data);

    popMatrix();
  }
  
  void run()
  {
    if (location.dist(next.location) < 1) // If we're close enough to the next vertex
    {
      if (next.children.size() == 0)
      {
        JOptionPane.showMessageDialog(null, data);
        testObjects.remove(this);
        
        //if (callback != null)
          //callback.call(str);
      }
      else
      {
        if (next instanceof FunctionUse)
          data = ((FunctionUse)next).execute(data);
          
        next = next.children.get(0);
      }
    }
    
    PVector move = PVector.sub(next.location, location);
    move.mult(.08);
    location.add(move);
  }
}
