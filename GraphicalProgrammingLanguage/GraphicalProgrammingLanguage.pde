FunctionDefinition currentFunction;

ArrayList<TestString> testStrings;

Toolbox toolbox;

boolean startedMakingArrow;

PVector trashLocation;

void restart()
{
  currentFunction = new FunctionDefinition();

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

void debugCurrentFunction(String input)
{
  currentFunction.debug(input);
}

