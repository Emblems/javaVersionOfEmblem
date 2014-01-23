abstract class Representation
{
  color c;
  String name;

  Representation()
  {
    c = color(random(255), random(255), random(255));
    name = "TEST";
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

