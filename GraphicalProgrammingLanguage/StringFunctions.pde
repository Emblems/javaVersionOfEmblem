class Delete extends Function
{
  Delete()
  {
    name = "delete";
    representation.c = color(255, 0, 0);
  }
  
  String execute(String input)
  {
    return super.execute(input.substring(1));
  }
}

class Reverse extends Function
{
  Reverse()
  {
    name = "reverse";
    representation.c = color(100, 200, 100);
  }
  
  String execute(String input)
  {
    return super.execute(input);//TODO: IMplement this
  }
}

class Increment extends Function
{
  Increment()
  {
    name = "increment";
    representation.c = color(200, 200, 100);
  }
  
  String execute(String input)
  {
    return super.execute(char(int(input.charAt(0)) + 1) + input.substring(1));
  }
}

class Rotate extends Function
{
  Rotate()
  {
    name = "rotate";
    representation.c = color(200, 200, 200);
  }
  
  String execute(String input)
  {
    return super.execute(input.substring(1) + input.substring(0, 1));
  }
}

class Copy extends Function
{
  Copy()
  {
    name = "copy";
    representation.c = color(0, 0, 255);
  }
  
  String execute(String input)
  {
    return super.execute(input.substring(0, 1) + input.substring(0));
  }
}
