class Toolbox
{
  ArrayList<FunctionDefinition> definitions;
  ArrayList<FunctionUse> uses;

  Toolbox()
  { 
    definitions = new ArrayList<FunctionDefinition>();
    uses = new ArrayList<FunctionUse>();
    
    //Add all of the primatives
    add(new Delete());
    add(new Reverse());
    add(new Increment());
    add(new Rotate());
    add(new Copy());
    add(new CopyFirstChar());
    
    add(new Input());
    add(new Output());
    
    //Add the math primatives
    //add(new Add1());
    //add(new Subtract1());
  }

  void show()
  {
    //Draw the toolbox.
    fill(0, 100);
    rect(0, 0, 100, height);
    
    for (FunctionUse use : uses)
      use.show();
  }
  
  void add(FunctionDefinition definition)
  {
    definitions.add(definition);
    
    FunctionUse use = new FunctionUse(definition);
    use.setLocation(new PVector(50, 50 + uses.size() * 100));
    uses.add(use);
  }
  
  void mouseDragged()
  {
    for (int i = 0; i < uses.size(); i++)
    {
      GraphVertex v = uses.get(i);

      if (v.mouseOver())
      {
        dragging = v;
        
        uses.remove(v);
        currentFunction.graph.add(v);
        
        FunctionUse replacement = new FunctionUse(((FunctionUse)v).definition);
        replacement.location = copy(v.location);
        uses.add(replacement);
        
        return;
      }
    }
  }
  
  ArrayList<FunctionUse> getUses()
  {
    return uses;
  }
  
  ArrayList<FunctionDefinition> getDefinitions()
  {
    return definitions;
  }
}

