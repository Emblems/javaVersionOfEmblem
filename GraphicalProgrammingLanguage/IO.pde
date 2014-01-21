void mousePressed()
{
  for (int i = 0; i < functions.size(); i++)
  {
    Function f = (Function)functions.get(i);

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

  functions.add(new Function());
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
    for (int i = 0; i < functions.size(); i++)
    {
      Function f = functions.get(i); 
      if (f.representation.mouseOver()) functions.remove(f);
    }
}

void mouseDragged()
{
  if (dragging == null)
    for (int i = 0; i < functions.size(); i++)
    {
      Function f = (Function)functions.get(i);

      if (f.mouseOver())
        dragging = f;
    }
  else
  {
    PVector move = new PVector(mouseX - pmouseX, mouseY - pmouseY);
    dragging.representation.loc.add(move);
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

