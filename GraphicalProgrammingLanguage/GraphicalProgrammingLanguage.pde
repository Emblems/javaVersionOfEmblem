FunctionDefinition currentFunction;

ArrayList<TestObject> testObjects;

Toolbox toolbox;

boolean startedMakingArrow;

PVector trashLocation;

void restart()
{
  currentFunction = new FunctionDefinition();

  trashLocation = new PVector(width, height);

  testObjects = new ArrayList<TestObject>();

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
}

void makeArrow()
{
  source.children.add(sink);
}

void debugCurrentFunction(Object input)
{
  currentFunction.debug(input);
}
