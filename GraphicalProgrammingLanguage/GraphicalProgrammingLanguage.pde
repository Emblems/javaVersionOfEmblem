/**
 TODOs
 
 Snap to grid?
 arrow to input goes behind toolbox, but vertices are still in front of toolbox
 variables
 branching <---------- high priority. Will allow loops
 fix rounding
 fix color of input and output arrows
 button not working consistently
 */

FunctionDefinition currentFunction;

ArrayList<TestObject> testObjects;

Toolbox toolbox;

boolean startedMakingArrow;

PVector trashLocation;
PVector nameLocation, descriptionLocation;

PVector gridSpacing = new PVector(50, 50);
boolean gridEnabled;

void restart()
{
  trashLocation = new PVector(width, height);
  nameLocation = new PVector(width/2, 25);
  descriptionLocation = new PVector(width/2, 75);

  testObjects = new ArrayList<TestObject>();

  startedMakingArrow = false;

  toolbox = new Toolbox();

  startNewFunction();
  
  gridEnabled = true;
}

void setup()
{
  size(displayWidth, displayHeight);

  restart();

  controlP5();
}

void draw()
{
  background(140);

  if (gridEnabled)
    drawGrid();

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

  stroke(0);
  fill(0);
  ellipse(trashLocation, 100);


  toolbox.show();
}

void makeArrow()
{
  source.children.add(sink);
}

void debugCurrentFunction()
{
  String input = JOptionPane.showInputDialog(null, "What input would you like to test?");

  try {
    float floatInput = Float.valueOf(input);
    debugCurrentFunction(floatInput);
  }
  catch(Exception e)
  {
    debugCurrentFunction(input);
  }
}
void debugCurrentFunction(Object input)
{
  currentFunction.debug(input);
}

void drawGrid()
{
  fill(0, 0);
  stroke(255);
  strokeWeight(1);
  int gridSpacing = 50;
  for (int x = 0; x < 100; x++)
    for (int y = 0; y < 100; y++)
      rect(x * gridSpacing, y * gridSpacing, gridSpacing);
}
