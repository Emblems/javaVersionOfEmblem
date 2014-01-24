class Delete extends FunctionDefinition
{
  Delete()
  {
    super("delete", color(255, 0, 0));
  }
  
  String execute(String input)
  {
    return super.execute(input.substring(1));
  }
}

class Reverse extends FunctionDefinition
{
  Reverse()
  {
    super("reverse", color(100, 200, 100));
  }
  
  String execute(String input)
  {
    return super.execute(input);//TODO: IMplement this
  }
}

class Increment extends FunctionDefinition
{
  Increment()
  {
    super("increment", color(200, 200, 100));
  }
  
  String execute(String input)
  {
    return super.execute(char(int(input.charAt(0)) + 1) + input.substring(1));
  }
}

class Rotate extends FunctionDefinition
{
  Rotate()
  {
    super("rotate", color(200, 200, 200));
  }
  
  String execute(String input)
  {
    return super.execute(input.substring(1) + input.substring(0, 1));
  }
}

class Copy extends FunctionDefinition
{
  Copy()
  {
    super("copy", color(0, 0, 255));
  }
  
  String execute(String input)
  {
    println(input);
    return super.execute(input.substring(0, 1) + input.substring(0));
  }
}

///////////////////////
class Input extends FunctionDefinition
{
  Input()
  {
    super("input", color(200, 200, 200));
  }
}

class Output extends FunctionDefinition
{
  Output()
  {
    super("output", color(150, 150, 150));
  }
}
