ArrayList<Function> functions;

ArrayList<TestString> testStrings;

boolean startedMakingArrow;
Function source, sink;
Function dragging;

Function start, end;

int defaultRadius = 50;
int mouseOverRadius = 60;
PVector trashLocation;

void restart()
{
  trashLocation = new PVector(width, height);
  functions = new ArrayList<Function>();
  testStrings = new ArrayList<TestString>();

  startedMakingArrow = false;

  start = new Function();
  start.representation.loc = new PVector(400, height/2);
  start.name = "start";
  start.representation.c = color(0, 255, 0);
  functions.add(start);
  
  end = new Function();
  end.representation.loc = new PVector(width - 300, height/2);
  end.name = "end";
  end.representation.c = color(255, 0, 255);
  functions.add(end);
  
  for(int y = 0; y < 10; y++)
  {
    Function f;
   
    if (random(1) < .3)
      f = new Increment();
    else if (random(1) < .5)
      f = new Delete();
    else
      f = new Copy();
      
    f.representation.loc = new PVector(50, 50 + y * 110);
    functions.add(f);
  }
}

void setup()
{
  size(displayWidth, displayHeight);

  restart();
}

void draw()
{
  background(255);

  //Make an arrow from the left hand side of the screen to the start vertex
  arrow(0, start.representation.loc.y, start.representation.loc.x - start.representation.radius, start.representation.loc.y);
  //Make an arrow from the end vertex to the right hand side of the screen
  arrow(end.representation.loc.x, end.representation.loc.y, width, end.representation.loc.y);
  
  //Draw the toolbox.
  fill(200);
  rect(0, 0, 100, height);
  
  for (int i = 0; i < functions.size(); i++)
  {
    Function f = (Function)functions.get(i);

    f.show();
  }

  //for (TestString test : testStrings)
  for (int i = 0; i < testStrings.size(); i++)
  {
    TestString test = (TestString)testStrings.get(i);
    test.show();
  }
  
  if (startedMakingArrow)
  {
    line(source.representation.loc.x, source.representation.loc.y, mouseX, mouseY);
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
  source.functionsThatThisPointsTo.add(sink);
}

void runCurrentFunction()
{
  println("Result: " + start.execute("ship"));
}

void debugCurrentFunction()
{
  testStrings.add(new TestString("test", start.loc()));
}
