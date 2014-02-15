import java.lang.StringBuilder;

class FunctionDefinitionString extends FunctionDefinition
{
  FunctionDefinitionString(String name, color c)
  {
    super(name, c);
  }
  
  Object execute(Object input)
  {
    if (input instanceof String)
      return execute((String)input);
    else
      return input;
  }
  
  String execute(String input)
  {
    return input;
  }
}

class Delete extends FunctionDefinitionString
{
  Delete()
  {
    super("delete", color(255, 0, 0));
  }
  
  String execute(String input)
  {
    return input.substring(1);
  }
}

class Reverse extends FunctionDefinitionString
{
  Reverse()
  {
    super("reverse", color(100, 200, 100));
  }
  
  String execute(String input)
  {
    return new StringBuilder(input).reverse().toString();
  }
}

class Increment extends FunctionDefinitionString
{
  Increment()
  {
    super("increment", color(200, 200, 100));
  }
  
  String execute(String input)
  {
    return char(int(input.charAt(0)) + 1) + input.substring(1);
  }
}

class Rotate extends FunctionDefinitionString
{
  Rotate()
  {
    super("rotate", color(200, 200, 200));
  }
  
  String execute(String input)
  {
    return input.substring(1) + input.substring(0, 1);
  }
}

class CopyFirstChar extends FunctionDefinitionString
{
  CopyFirstChar()
  {
    super("copy first character", color(20, 20, 200));
  }
  
  String execute(String input)
  {
    return input.substring(0, 1) + input.substring(0);
  }
}

class Copy extends FunctionDefinitionString
{
  Copy()
  {
    super("copy", color(0, 0, 255));
  }
  
  String execute(String input)
  {
    return input + input;
  }
}

class PrependStar extends FunctionDefinitionString
{
  PrependStar()
  {
    super("Prepend *", color(0, 0, 255));
  }
  
  String execute(String input)
  {
    return "*" + input;
  }
}

class IfStar extends ConditionDefinitionString
{
  IfStar()
  {
    super("If *", color(0, 100, 200));
  }
  
  String execute(String input)
  {
    return input.chatAt(0) == '*';
  }
}
class IfFirstTwoSame extends ConditionDefinitionString
{
  IfFirstTwoSame()
  {
    super("If first two same", color(0, 100, 200));
  }
  
  String execute(String input)
  {
    return input.chatAt(0) == input.chatAt(1);
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
