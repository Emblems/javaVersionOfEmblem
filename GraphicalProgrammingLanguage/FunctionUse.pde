class FunctionUse extends GraphVertex
{
  FunctionDefinition definition;
  
  FunctionUse(FunctionDefinition definition)
  {
    location = new PVector();
    
    this.definition = definition;
    representation = definition.representation;
  }

  void show()
  {
    for (GraphVertex child : children)
      arrow(this, child);
    
    super.show();
  }

  Object execute(Object input)
  {
    return definition.execute(input);
  }
}
