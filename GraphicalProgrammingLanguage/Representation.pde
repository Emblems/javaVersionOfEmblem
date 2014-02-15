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
    strokeWeight(1);
    stroke(100);
    textAlign(CENTER, CENTER);

    text(name, 0, -2);
  }

  void showHover()
  {  
    fill(0);
    strokeWeight(1);
    stroke(100);
    textAlign(CENTER, CENTER);

    text(name, 0, -2);
  }

  abstract boolean containsOffset(PVector offset);
}

