class FunctionDefinition
{
  //These are everything
  ArrayList<GraphVertex> graph;

  Representation representation;

  FunctionDefinition()
  {
    this("unnamedFunction", randomColor());
  }

  FunctionDefinition(String name, color c)
  {
    representation = new Circle();
    representation.name = name;
    representation.c = c;

    graph = new ArrayList<GraphVertex>();
    /*
    FunctionUse input = new FunctionUse(new Input());
    input.setLocation(new PVector(400, height/2));
    input.representation.c = color(0, 255, 0);
    inputs.add(input);
    graph.add(input);

    FunctionUse output = new FunctionUse(new Output());
    output.setLocation(new PVector(width - 300, height/2));
    output.representation.c = color(255, 0, 255);
    outputs.add(output);
    graph.add(output);
    */
  }

  void show()
  {
    strokeWeight(3);
    for (GraphVertex input : getInputs())
     //Make an arrow from the left hand side of the screen to the input vertex:
     arrow(0, input.getLocation().y, input.getLocation().x, input.getLocation().y);
    
    for (GraphVertex output : getOutputs())
     //Make an arrow from the oudimensionsrtex to the right hand side of the screen:
     arrow(output.getLocation().x, output.getLocation().y, width, output.getLocation().y);
    
    for (int i = 0; i < graph.size(); i++)
    {
      GraphVertex f = (GraphVertex)graph.get(i);

      f.show();

      //If you drag it to the trash can, kill it 
      if (f.getLocation().dist(trashLocation) < 100 && dragging != f)
        destroy(f);
    }

    stroke(0);
    fill(0);
    text(representation.name, nameLocation);
    text(representation.description, descriptionLocation);
  }

  Object execute(Object input)
  {
    return run(input);
  }

  void destroy(GraphVertex doomed)
  {
    graph.remove(doomed);
    
    for (GraphVertex v : graph)
      v.children.remove(doomed);
  }

  void debug(Object input)
  {
    //for (GraphVertex input : inputs)
    for (GraphVertex v : graph)
      if (v instanceof FunctionUse && ((FunctionUse)v).definition instanceof Input)
        testObjects.add(new TestObject(input, v, this));
  }
  
  /**
  Run this function at maximum possible speed. Parallelization should be used as much as possible.
  */
  Object run(Object input)
  {
    if (graph.size() == 0)
      return input;
      
    Object data = input;
    FunctionUse currentVertex = (FunctionUse)getInputs().get(0);
    while(!(currentVertex.definition instanceof Output))
    {
      data = currentVertex.execute(data);
      currentVertex = (FunctionUse)currentVertex.children.get(0);
    }
    
    return data;
  }
  
  ArrayList<GraphVertex> getGraphVertices()
  {
    return graph;
  }
  
  ArrayList<FunctionUse> getFunctionUses()
  {
    ArrayList<FunctionUse> functionUses = new ArrayList<FunctionUse>();
    for (GraphVertex vertex : getGraphVertices())
      if (vertex instanceof FunctionUse)
        functionUses.add((FunctionUse)vertex);
    
    return functionUses;
  }
  
  ArrayList<FunctionUse> getInputs()
  {
    ArrayList<FunctionUse> inputs = new ArrayList<FunctionUse>();
    for (FunctionUse function : getFunctionUses())
      if (function.definition instanceof Input)
        inputs.add(function);
        
    return inputs;
  }
  ArrayList<FunctionUse> getOutputs()
  {
    ArrayList<FunctionUse> outputs = new ArrayList<FunctionUse>();
    for (FunctionUse function : getFunctionUses())
      if (function.definition instanceof Output)
        outputs.add(function);
        
    return outputs;
  }
}
