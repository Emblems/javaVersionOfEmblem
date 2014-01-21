class TestString
{
  String str;
  PVector loc;
  
  TestString(String str, PVector loc)
  {
    println("TESTSTT");
    this.str = str;
    this.loc = loc;
  }
  
  void show()
  {
    println("TESTSTT");
    
    pushMatrix();
    translate(loc);
    
    text(str, 0, 0);
    
    popMatrix();
  }
}
