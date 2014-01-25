class FunctionDefinition
{
  //This are the inputs and outputs
  ArrayList<GraphVertex> inputs, outputs;

  //These are everything
  ArrayList<GraphVertex> graph;

  Representation representation;

  FunctionDefinition()
  {
    this(JOptionPane.showInputDialog(null, "What would you like to call your new function?"), randomColor());
  }

  FunctionDefinition(String name, color c)
  {
    representation = new Circle();
    representation.name = name;
    representation.c = c;

    graph = new ArrayList<GraphVertex>();

    inputs = new ArrayList<GraphVertex>();
    outputs = new ArrayList<GraphVertex>();
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
    /*
    for (GraphVertex input : inputs)
     //Make an arrow from the left hand side of the screen to the input vertex:
     arrow(0, input.getLocation().y, input.getLocation().x - input.representation.radius, input.getLocation().y);
     
     for (GraphVertex output : outputs)
     //Make an arrow from the oudimensionsrtex to the right hand side of the screen:
     arrow(output.getLocation().x, output.getLocation().y, width, output.getLocation().y);
     */
    for (int i = 0; i < graph.size(); i++)
    {
      GraphVertex f = (GraphVertex)graph.get(i);

      f.show();

      //If you drag it to the trash can, kill it 
      if (f.getLocation().dist(trashLocation) < 100 && dragging != f)
        destroy();
    }

    text(representation.name, width/2, 20);
  }

  Object execute(Object input)
  {
    return input;
    //debug(input);
  }

  void destroy()
  {
    graph.remove(this);
    
    for (GraphVertex vertex : graph)
      vertex.children.remove(this);
  }

  void debug(Object input)
  {
    //for (GraphVertex input : inputs)
    for (GraphVertex v : graph)
      if (v instanceof FunctionUse && ((FunctionUse)v).definition instanceof Input)
        testObjects.add(new TestObject(input, v, this));
  }
}
