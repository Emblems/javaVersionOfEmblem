import controlP5.*;

void controlP5()
{
  ControlP5 cp = new ControlP5(this);
  
  int y = 30;
  
  cp.addButton("debugCurrentFunction")
    .setPosition(width - 150, y)
    .setSize(150, 30)
    .setLabel("debugCurrentFunction");
  y += 40;
    
  cp.addButton("restart")
    .setPosition(width - 150, y)
    .setSize(150, 30)
    .setLabel("Restart");
  y += 40;
    
  cp.addToggle("gridEnabled")
    .setPosition(width - 150, y)
    .setSize(150, 30)
    .setLabel("Grid");
  y += 40;
}
