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
  /*
  else if (key == 'x')
    for (int i = 0; i < currentFunction.graph.size(); i++)
    {
      GraphVertex f = currentFunction.graph.get(i); 
      if (f.mouseOver())
        currentFunction.destroy(f);
    }
  */
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
  if (dragging != null)
  {
    dragging.drop();
    dragging = null;
  }
}

PVector mouse()
{
  return new PVector(mouseX, mouseY);
}

String prompt(String msg)
{
  return JOptionPane.showInputDialog(null, msg); 
}
