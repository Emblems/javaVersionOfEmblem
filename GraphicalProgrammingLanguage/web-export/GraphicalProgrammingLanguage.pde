FunctionDefinition currentFunction;

ArrayList<TestString> testStrings;

Toolbox toolbox;

boolean startedMakingArrow;

PVector trashLocation;

ArrayList<FunctionDefinition> allFunctionDefinitions;

void restart()
{
  currentFunction = new FunctionDefinition();

  allFunctionDefinitions = new ArrayList<FunctionDefinition>();

  trashLocation = new PVector(width, height);

  testStrings = new ArrayList<TestString>();

  startedMakingArrow = false;

  toolbox = new Toolbox();
}

void setup()
{
  size(displayWidth, displayHeight);

  restart();
}

void draw()
{
  background(255);
  
  toolbox.show();

  currentFunction.show();

  //for (TestString test : testStrings)
  for (int i = 0; i < testStrings.size(); i++)
  {
    TestString test = (TestString)testStrings.get(i);
    test.show();
  }

  if (startedMakingArrow)
  {
    line(source.getLocation(), mouse());
  }

  pushMatrix();
  translate(width - 60, 0);

  fill(200);
  rect(0, 0, 60, 30);
  stroke(0);
  fill(0);
  textSize(20);
  text("Run", 25, 15);

  popMatrix();

  ellipse(width, height, 100, 100);
}

void makeArrow()
{
  println(source);
  println(source.functionsThatThisPointsTo);
  source.functionsThatThisPointsTo.add(sink);
}

void runCurrentFunction()
{
  println("Result: " + currentFunction.execute("ship"));
}

void debugCurrentFunction()
{
  currentFunction.debug();
}

class Circle extends Shape
{
  float radius;
  
  Circle()
  {
    radius = 50;
  }
  
  void show()
  {
    fill(c);
    
    ellipse(0, 0, radius*2, radius*2);
  }
  
  void showHover()
  {
    fill(c);
    
    int d = 10;
    ellipse(0, 0, (radius+d)*2, (radius+d)*2);
  }
  
  boolean containsOffset(PVector offset)
  {
    return offset.mag() < radius;
  }
}
class FunctionDefinition
{
  //This are the inputs and outputs
  ArrayList<Input> inputs;
  ArrayList<Output> outputs;

  //These are everything
  ArrayList<GraphVertex> graph;

  String name;
  Shape representation;

  FunctionDefinition()
  {
    representation = new Circle();

    graph = new ArrayList<GraphVertex>();

    inputs = new ArrayList<Input>();
    outputs = new ArrayList<Output>();

    Input input = new Input();
    input.setLocation(new PVector(400, height/2));
    input.representation.c = color(0, 255, 0);
    inputs.add(input);
    graph.add(input);

    Output output = new Output();
    output.setLocation(new PVector(width - 300, height/2));
    output.representation.c = color(255, 0, 255);
    outputs.add(output);
    graph.add(output);
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
        graph.remove(this);
    }
  }

  String execute(String input)
  {
    return "NYI";//inputs.get(0).execute(input);
  }

  void debug()
  {
    for (Input input : inputs)
      testStrings.add(new TestString("test", input.getLocation()));
  }
}
class FunctionUse extends GraphVertex
{
  FunctionDefinition definition;
  
  FunctionUse(FunctionDefinition definition)
  {
    location = new PVector();
    
    this.definition = definition;
    name = definition.name;
    representation = definition.representation;
  }

  void show()
  {   
    for (int i = 0; i < functionsThatThisPointsTo.size(); i++)
    {
      GraphVertex sink = functionsThatThisPointsTo.get(i);

      arrow(this, sink);
    }
    
    super.show();
  }

  String execute(String input)
  {
    String output = definition.execute(input);
    
    if (functionsThatThisPointsTo.size() > 0)
      return ((FunctionUse)functionsThatThisPointsTo.get(0)).execute(output);
      
    return output;
  }
}
class GraphVertex
{
  ArrayList<GraphVertex> functionsThatThisPointsTo;
  PVector location;
  
  String name;
  Shape representation;

  GraphVertex()
  {
    representation = new Circle();
    
    name = "undefined";
    
    functionsThatThisPointsTo = new ArrayList<GraphVertex>();
  }

  boolean mouseOver()
  {
    return representation.containsOffset(PVector.sub(getLocation(), mouse()));
  }

  PVector getLocation()
  {
    return location;
  }

  void setLocation(PVector location)
  {
    this.location = location;
  }

  void show()
  {
      
    pushMatrix();
    translate(getLocation());

    if (mouseOver())
      representation.showHover();
    else
      representation.show();

    fill(0);
    textAlign(CENTER, CENTER);
    text(name, 0, -2);

    popMatrix();
  }
}
final PVector ORIGIN = new PVector(0, 0);

void translate(PVector loc)
{
  translate(loc.x, loc.y);
}

/**
Draws an arrow from f1 to f2
*/
void arrow(GraphVertex f1, GraphVertex f2)
{
  int radius = 50;
  
  PVector directionVector = PVector.sub(f2.getLocation(), f1.getLocation());
  directionVector.normalize();
  
  PVector start = f1.getLocation();//PVector.add(f1.getLocation(), PVector.mult(directionVector, f1.representation.radius));
  PVector end = f2.getLocation();//PVector.sub(f2.getLocation(), PVector.mult(directionVector, f2.representation.radius));

  arrow(start.x, start.y, end.x, end.y);
}
void arrow(PVector loc1, PVector loc2)
{
  arrow(loc1.x, loc1.y, loc2.x, loc2.y);
}
void arrow(float x1, float y1, float x2, float y2)
{
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -10, -10);
  line(0, 0, 10, -10);
  popMatrix();
}

void line(PVector location1, PVector location2)
{
  line(location1.x, location1.y, location2.x, location2.y);
}

void ellipse(PVector center, PVector dimensions)
{
  ellipse(center.x, center.y, dimensions.x, dimensions.y);
}

void rect(PVector center, PVector dimensions)
{
  rect(center.x, center.y, dimensions.x, dimensions.y);
}
void rect(PVector dimensions)
{
  rect(ORIGIN, dimensions);
}

PVector abs(PVector vector)
{
  return new PVector(abs(vector.x), abs(vector.y));
}

boolean less(PVector vector1, PVector vector2)
{
  return vector1.x < vector2.x && vector1.y < vector2.y;
}
GraphVertex source, sink; // for dragging arrow
GraphVertex dragging;

void mousePressed()
{
  for (int i = 0; i < currentFunction.graph.size(); i++)
  {
    GraphVertex f = (GraphVertex)currentFunction.graph.get(i);

    if (f.mouseOver())
    {
      if (!startedMakingArrow)  
      {
        startedMakingArrow = true;
        source = f;
      }
      else
      {
        sink = f;
        makeArrow();
        startedMakingArrow = false;
      }

      return;
    }
  }

  //functions.add(new Function()); //this is 'click to add undefined function'
  startedMakingArrow = false;
}

void keyPressed()
{
  if (key == ' ')
    restart();
  else if (key == 'r')
    runCurrentFunction();
  else if (key == 'd')
    debugCurrentFunction();
  else if (key == 'x')
    for (int i = 0; i < currentFunction.graph.size(); i++)
    {
      GraphVertex f = currentFunction.graph.get(i); 
      if (f.mouseOver())
        currentFunction.graph.remove(f);
    }
  else if (key == 'e')
  {
    //We're done with the curret function definition
    toolbox.add(currentFunction);
    
    //Let's start making a new function now
    currentFunction = new FunctionDefinition();
  }
}

void mouseDragged()
{
  if (dragging == null)
  {
    for (int i = 0; i < currentFunction.graph.size(); i++)
    {
      GraphVertex v = currentFunction.graph.get(i);

      if (v.mouseOver())
        dragging = v;
    }
    toolbox.mouseDragged();
  }
  else
  {
    PVector move = new PVector(mouseX - pmouseX, mouseY - pmouseY);
    dragging.getLocation().add(move);
    startedMakingArrow = false;
  }
}

void mouseReleased()
{
  dragging = null;
}

PVector mouse()
{
  return new PVector(mouseX, mouseY);
}
class Input extends GraphVertex
{
}
class Output extends GraphVertex
{
}
class Rectangle extends Shape
{
  PVector dimensions;
  
  Rectangle()
  {
    dimensions = new PVector(50, 50);
  }
  
  void show()
  {
    rect(dimensions);
  }
  void showHover()
  {
    rect(dimensions);
  }
  
  boolean containsOffset(PVector offset)
  {
    return less(PVector.mult(abs(offset), 2), dimensions);
  }
}
abstract class Shape
{
  color c;
  
  Shape()
  {
    c = color(random(255), random(255), random(255));
  }
  
  abstract void show();
  abstract void showHover();
  
  abstract boolean containsOffset(PVector offset);
}
class Delete extends FunctionDefinition
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

class Reverse extends FunctionDefinition
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

class Increment extends FunctionDefinition
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

class Rotate extends FunctionDefinition
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

class Copy extends FunctionDefinition
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
class TestString
{
  String str;
  PVector loc;
  
  TestString(String str, PVector loc)
  {
    println("TESTSTT");
    this.str = str;
    this.loc = loc;
  }
  
  void show()
  {
    println("TESTSTT");
    
    pushMatrix();
    translate(loc);
    
    text(str, 0, 0);
    
    popMatrix();
  }
}
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
  }

  void show()
  {
    //Draw the toolbox.
    fill(200);
    rect(0, 0, 100, height);
    
    pushMatrix();
    
    translate(50, 0);
    for (FunctionUse use : uses)
    {
      use.show();
      translate(0, 120);
    }
      
    popMatrix();
  }
  
  void add(FunctionDefinition definition)
  {
    definitions.add(definition);
    uses.add(new FunctionUse(definition));
  }
  
  void mouseDragged()
  {
    for (int i = 0; i < uses.size(); i++)
    {
      GraphVertex v = uses.get(i);

      if (v.mouseOver())
        dragging = v;
        
      uses.remove(v);
      currentFunction.graph.add(v);
    }
  }
}

class Variable extends GraphVertex
{
  Variable()
  {
    representation = new Rectangle();
  }

  void show()
  {
    representation.show();
  }
}


