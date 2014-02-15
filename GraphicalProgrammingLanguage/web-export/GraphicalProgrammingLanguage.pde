/**
TODOs

Snap to grid?
fix arrows
arrow to input goes behind toolbox, but vertices are still in front of toolbox
variables
*/

FunctionDefinition currentFunction;

ArrayList<TestObject> testObjects;

Toolbox toolbox;

boolean startedMakingArrow;

PVector trashLocation;
PVector nameLocation, descriptionLocation;

void restart()
{
  trashLocation = new PVector(width, height);
  nameLocation = new PVector(width/2, 25);
  descriptionLocation = new PVector(width/2, 100);

  testObjects = new ArrayList<TestObject>();

  startedMakingArrow = false;

  toolbox = new Toolbox();
  
  startNewFunction();
}

void setup()
{
  //size(displayWidth, displayHeight);
  size(600, 600);

  restart();
}

void draw()
{
  background(255);

  currentFunction.show();

  //for (TestString test : testStrings)
  for (int i = 0; i < testObjects.size(); i++)
  {
    TestObject test = (TestObject)testObjects.get(i);
    test.show();
    test.run();
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
  
  
  toolbox.show();
}

void makeArrow()
{
  source.children.add(sink);
}

void debugCurrentFunction(Object input)
{
  currentFunction.debug(input);
}

void drawGrid()
{
  int gridSpacing = 50;
  for(int x = 0; x < 100; x++)
    for(int y = 0; y < 100; y++)
      rect(x * gridSpacing, y * gridSpacing, gridSpacing);
}
class Circle extends Representation
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
    
    super.show();
  }
  
  void showHover()
  {
    fill(c);
    
    int d = 10;
    ellipse(0, 0, (radius+d)*2, (radius+d)*2);
    
    super.showHover();
  }
  
  boolean containsOffset(PVector offset)
  {
    return offset.mag() < radius;
  }
}
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
class GraphVertex
{
  ArrayList<GraphVertex> children;
  PVector location;
  
  Representation representation;

  GraphVertex()
  {
    representation = new Circle();
    
    children = new ArrayList<GraphVertex>();
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
  
  PVector start = PVector.add(f1.getLocation(), PVector.mult(directionVector, f1.representation.arrowStopRadius));
  PVector end = PVector.sub(f2.getLocation(), PVector.mult(directionVector, f2.representation.arrowStopRadius));

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
void rect(int x, int y, int widthAndHeight)
{
  rect(x, y, widthAndHeight, widthAndHeight);
}

PVector abs(PVector vector)
{
  return new PVector(abs(vector.x), abs(vector.y));
}

boolean less(PVector vector1, PVector vector2)
{
  return vector1.x < vector2.x && vector1.y < vector2.y;
}

color randomColor()
{
  return color(random(255), random(255), random(255));
}

PVector copy(PVector vector)
{
  return new PVector(vector.x, vector.y);
}

void text(String str)
{
  text(str, 0, 0);
}
void text(String str, PVector location)
{
  text(str, location.x, location.y);
}
import javax.swing.JOptionPane;

GraphVertex source, sink; // for drawing arrow
GraphVertex dragging;

void mousePressed()
{
  // mouseEvent variable contains the current event information
  if (mouseEvent.getClickCount()==2)
    mousePressedDouble();
  //else if (mouseEvent.getButton()==MouseEvent.BUTTON3)
    //mousePressedRight();
  else
    mousePressedSingle();
}

void mousePressedDouble()
{
  for (GraphVertex vertex : currentFunction.graph)
    if (vertex.mouseOver() && vertex instanceof FunctionUse)
      switchTo(((FunctionUse)vertex).definition);
      
  for (GraphVertex vertex : toolbox.getUses())
    if (vertex.mouseOver() && vertex instanceof FunctionUse)
      switchTo(((FunctionUse)vertex).definition);
      
  //check for double-click on title
  if (mouse().dist(nameLocation) < 20)
    currentFunction.representation.name = prompt("What's the new title?");
  if (mouse().dist(descriptionLocation) < 20)
    currentFunction.representation.description = prompt("What's the new description?");
}
void switchTo(FunctionDefinition definition)
{
  currentFunction = definition;
}

void mousePressedRight()
{
}

void mousePressedSingle()
{
  for (GraphVertex f : currentFunction.graph)
  {
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
  else if (key == 'd')
  {
    String input = JOptionPane.showInputDialog(null, "What input would you like to test?");
    
    try{
      float floatInput = Float.valueOf(input);
      debugCurrentFunction(floatInput);
    }
    catch(Exception e)
    {
      debugCurrentFunction(input);
    }
  }
  else if (key == 'x')
    for (int i = 0; i < currentFunction.graph.size(); i++)
    {
      GraphVertex f = currentFunction.graph.get(i); 
      if (f.mouseOver())
        currentFunction.destroy(f);
    }
  else if (key == 'e')
    startNewFunction();
}

void startNewFunction()
{
    currentFunction = new FunctionDefinition();
    toolbox.add(currentFunction);
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

String prompt(String msg)
{
  return JOptionPane.showInputDialog(null, msg); 
}
class Rectangle extends Representation
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
abstract class Representation
{
  color c;
  String name;
  String description;
  int arrowStopRadius;

  Representation()
  {
    arrowStopRadius = 50;
    
    c = color(random(255), random(255), random(255));
    name = "TEST";
    description = "double click to put a description here";
  }

  void show()
  {
    fill(0);
    textAlign(CENTER, CENTER);

    text(name, 0, -2);
  }

  void showHover()
  {  
    fill(0);
    textAlign(CENTER, CENTER);

    text(name, 0, -2);
  }

  abstract boolean containsOffset(PVector offset);
}

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

class Copy extends FunctionDefinitionString
{
  Copy()
  {
    super("copy", color(0, 0, 255));
  }
  
  String execute(String input)
  {
    return input.substring(0, 1) + input.substring(0);
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
class TestObject
{
  Object data;
  PVector location;

  GraphVertex next;

  TestObject(Object input, GraphVertex start)
  {
    this(input, start, null);
  }
  TestObject(Object input, GraphVertex start, FunctionDefinition callback)
  {
    this.data = input;
    
    next = start;
    this.location = copy(start.location);
  }

  void show()
  {
    pushMatrix();
    translate(location);

    if (data instanceof String)
      text((String)data);
    else if (data instanceof Float)
      text("" + (Float)data);
    else if (data instanceof Integer)
      text("" + (Integer)data);

    popMatrix();
  }
  
  void run()
  {
    if (location.dist(next.location) < 1) // If we're close enough to the next vertex
    {
      if (next.children.size() == 0)
      {
        JOptionPane.showMessageDialog(null, data);
        testObjects.remove(this);
        
        //if (callback != null)
          //callback.call(str);
      }
      else
      {
        if (next instanceof FunctionUse)
          data = ((FunctionUse)next).execute(data);
          
        next = next.children.get(0);
      }
    }
    
    PVector move = PVector.sub(next.location, location);
    move.mult(.08);
    location.add(move);
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
    
    add(new Input());
    add(new Output());
    
    //Add the math primatives
    //add(new Add1());
    //add(new Subtract1());
  }

  void show()
  {
    //Draw the toolbox.
    fill(200);
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

class Triangle extends Representation
{
  boolean containsOffset(PVector offset)
  {
    return false;
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


