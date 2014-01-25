class FunctionDefinitionFloat extends FunctionDefinition
{
  FunctionDefinitionFloat(String name, color c)
  {
    super(name, c);
  }
  
  Object execute(Object input)
  {
    if (input instanceof Float)
      return execute((Float)input);
    else
      return input;
  }
  
  float execute(float input)
  {
    return input;
  }
}

class Add1 extends FunctionDefinitionFloat
{
  Add1()
  {
    super("add1", color(0,255,0));
  }
  
  float execute(float input)
  {
    return input+1;
  }
}

class Subtract1 extends FunctionDefinitionFloat
{
  Subtract1()
  {
    super("subtract1", color(0,0,255));
  }
  
  float execute(float input)
  {
    return input-1;
  }
}

class Double extends FunctionDefinitionFloat
{
  Double()
  {
    super("Double", color(0,0,255));
  }
  
  float execute(float input)
  {
    return input*2;
  }
}

class Halve extends FunctionDefinitionFloat
{
  Halve()
  {
    super("Halve", color(0,0,255));
  }
  
  float execute(float input)
  {
    return input/2;
  }
}

class sumDigits extends FunctionDefinitionFloat
{
  sumDigits()
  {
    super("sumDigits", color(0,0,255));
  }
  
  float execute(float input)
  {
    int sum = 0;
    while (input != 0){
      sum += input % 10;
      input = floor(input/10);
    } 
    return sum;
  }
}
