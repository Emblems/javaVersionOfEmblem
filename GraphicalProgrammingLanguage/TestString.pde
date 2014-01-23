class TestString
{
  String str;
  PVector location;

  GraphVertex next;

  TestString(String str, GraphVertex start)
  {
    this.str = str;
    
    next = start;
    this.location = copy(start.location);
  }

  void show()
  {
    pushMatrix();
    translate(location);

    text(str, 0, 0);

    popMatrix();

    if (location.dist(next.location) < 1)
    {
      if (next.children.size() == 0)
      {
        JOptionPane.showMessageDialog(null, str);
        testStrings.remove(this);
      }
      else
      {
        if (next instanceof FunctionUse)
          str = ((FunctionUse)next).execute(str);
        next = next.children.get(0);
      }
    }
    
    PVector move = PVector.sub(next.location, location);
    move.mult(.10);
    location.add(move);
  }
}

