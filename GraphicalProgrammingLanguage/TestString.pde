class TestString
{
  String str;
  PVector location;

  GraphVertex next;

  TestString(String input, GraphVertex start)
  {
    this(input, start, null);
  }
  TestString(String input, GraphVertex start, FunctionDefinition callback)
  {
    this.str = input;
    
    next = start;
    this.location = copy(start.location);
  }

  void show()
  {
    pushMatrix();
    translate(location);

    text(str);

    popMatrix();
  }
  
  void run()
  {
    if (location.dist(next.location) < 1)
    {
      if (next.children.size() == 0)
      {
        JOptionPane.showMessageDialog(null, str);
        testStrings.remove(this);
        
        //if (callback != null)
          //callback.call(str);
      }
      else
      {
        println("TEST");
        if (next instanceof FunctionUse)
        {
          str = ((FunctionUse)next).execute(str);
          println(str);
        }
        next = next.children.get(0);
      }
    }
    
    PVector move = PVector.sub(next.location, location);
    move.mult(.10);
    location.add(move);
  }
}

