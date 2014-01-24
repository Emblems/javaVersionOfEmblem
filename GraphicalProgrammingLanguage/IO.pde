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
  for (GraphVertex g : currentFunction.graph)
  {
    if (g.mouseOver() && g instanceof FunctionUse)
    {
      currentFunction = ((FunctionUse)g).definition;
    }
  }
}

void mousePressedRight()
{
}

void mousePressedSingle()
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
  else if (key == 'd')
    debugCurrentFunction(JOptionPane.showInputDialog(null, "What string would you like to test?"));
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

