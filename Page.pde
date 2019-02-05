public class Page extends UseProc{
  
  
  
  public Page(){
    
    
    goTo = 50; // = 50%
    goIn = 50;
    goOut = 50; // to get back in
    
    pos = new PVector(width / 2.0, height / 2.0);
    
    size = 3;
    float dif = width / 12.0;
    points = new PVector[]{
      new PVector(width / 2.0, height / 6.0),
      new PVector(dif, height - dif),
      new PVector(width - dif, height - dif),
      //new PVector(width - dif, dif)
      
    };
    
    fill(255, 0, 0);
    for(int i = 0; i < points.length; i ++){
      ellipse(points[i].x, points[i].y, 2.0 * size, 2.0 * size);
      
    }
    
    
    
    
    
  }
  
  
  float size;
  float goTo, goIn, goOut;
  
  PVector[] points;
  
  PVector pos;
  
  
  public void render(){
    
    
    // TODO save every point and draw that!!!!
    fill(255);
    stroke(0);
    ellipse(pos.x, pos.y, size, size);
   // println();
    
    renderFrameRate();
    
  }
  
  public void renderFrameRate(){
    float xSize = width / 12.0;
    fill(255);
    rect(width - xSize, 0, xSize, xSize / 3.0);
    new TextManager().setTxt(frameRate + "").setPosSize(width - xSize, 0, xSize, xSize / 3.0).render();
    
    
  }
  
  public void tick(){
    step();
  }
  
  public void tickButtons(){
    
    step();
    
  }
  
  
  public void step(){
    
    int go = (int) random(points.length);
    
    pos.x += (points[go].x - pos.x) * goTo / 100.0;
    pos.y += (points[go].y - pos.y) * goTo / 100.0;
    
    test();
    
    doRender();
  }
  
  
  public void test(){
    if(isOut()){
      goTo = goOut;
    } else {
      goTo = goIn;
    }
    
    
  }
  
  public boolean isOut(){
    if(pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height){
      return true;
    }
    return false;
  }
  
  
  
  
}