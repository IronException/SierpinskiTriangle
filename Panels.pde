

public class Panel /*extends UseProc*/{
  
  public Panel(){
    //col = 255;
    //img = null;
    //setImg(new FileManager("").getImg());
    setCol(255);
    
    setPosSize(0, 0, width, height / 2);
    /*xPos = 0;
    xSize = width;
    yPos = 0;
    ySize = height / 2;*/
    
    //set
  }
  /*
  public Panel setOffset(float offset){
    this.offset = offset;
    return this;
  }*/
  
  public Panel setImg(PImage img){
    this.img = img;
    return this;
  }
  
  public Panel setCol(int col){
    this.col = col;
    return this;
  }
  
  public Panel setPosSize(float xPos, float yPos, float xSize, float ySize){
    setX(xPos, xSize).setY(yPos, ySize);
    return this;
  }
  
  public Panel setPos(float xPos, float yPos){
    setXPos(xPos).setYPos(yPos);
    return this;
  }
  
  public Panel setSize(float xSize, float ySize){
    setXSize(xSize).setYSize(ySize);
    return this;
  }
  
  public Panel setX(float xPos, float xSize){
    setXPos(xPos).setXSize(xSize);
    return this;
  }
  
  public Panel setY(float yPos, float ySize){
    
    setYPos(yPos).setYSize(ySize);
    
    return this;
  }
  
  public Panel setXPos(float xPos){
    this.xPos = xPos;
    nevPosSize(1);
    return this;
  }
  
  public Panel setYPos(float yPos){
    this.yPos = yPos;
    nevPosSize(2);
    return this;
  }
  
  public Panel setXSize(float xSize){
    this.xSize = xSize;
    nevPosSize(3);
    return this;
  }
  
  public Panel setYSize(float ySize){
    this.ySize = ySize;
    nevPosSize(4);
    return this;
  }
  
  
  public void nevPosSize(int id){}
  
  
  
  int col;
  
  PImage img;
  
  //float offset;
  float xPos, yPos, xSize, ySize;
  
  
  
  public void render(){
    if(img == null){
      fill(col);
      rect(xPos, yPos, xSize, ySize);
    } else {
      image(img, xPos, yPos, xSize, ySize);
    }
  }
  
}

public class Button extends Panel {
  
  public Button(){
    super();
    this.txt = "";
    this.txtCol = 0;
  }
  
  public Button setTxt(String txt){
    this.txt = txt;
    return this;
  }
  
  public Button setPressImg(PImage img){
    this.press = img;
    return this;
  }
  
  public Button setTxtCol(int col){
    this.txtCol = col;
    return this;
  }
  
  public String getTxt(){
    return txt;
  }
  
  String txt;
  int txtCol;
  
  int active;
  PImage press;
  
  
  public void render(){
    super.render();
    new TextPanel(txt, xPos, yPos, xSize, ySize).setCol(txtCol).render();
    
  }
  
  public boolean tickButton(){
    boolean rV = false;
    if(isMouseOnButton()){
      exeTickButton((mouseX - xPos) / xSize, (mouseY - yPos) / ySize);
      rV = true;
    }
    return rV;
  }
  
  public boolean isMouseOnButton(){
    if(isMouseXOnButton()){
      if(isMouseYOnButton()){
        return true;
      }
    }
    return false;
  }
  
  public boolean isMouseXOnButton(){
    if(mouseX > xPos && mouseX < xPos + xSize){
      return true;
    }
    return false;
  }
  
  public boolean isMouseYOnButton(){
      if(mouseY > yPos && mouseY < yPos + ySize){
        return true;
      }
    return false;
  }
  
  public void exeTickButton(float x, float y){}
  
  
}

//public class 







public class RadioButton extends Button{
  
  public RadioButton(){
    super();
    //tested = true;
    
    
    
    //yPos = width / 2;//width / testSizes.length + height / 16;
    //ySize = height - 2 * yPos;
    
    //xPos = width / 8;
    //x2Pos = width - xPos;
    
    //lec = x2Pos;
    
    setOffset(xSize / 8);
    setTxtHeight(ySize / 4.0);
    setLine(50);
    setLineCol(color(39, 76, 148));
    
    setRenderHelpLine(true);
    
  }
  
  public RadioButton setXSize(float xSize){
    super.setXSize(xSize);
    //refreshLine();
    setOffset(xSize / 8);
    return this;
  }
  
  public RadioButton setYSize(float ySize){
    super.setYSize(ySize);
    //refreshLine();
    setTxtHeight(ySize / 4.0);
    return this;
  }
  /*
  private void refreshLine(){
   // line = xPos + (x2Pos - xPos) / 2;
    setLine(50);
  }*/
  
  /**
    0 - 100.0
  */
  public RadioButton setLine(float size){
    line = size; //xPos + size * xSize / 100.0;
    return this;
  }
  
  
  public RadioButton setOffset(float off){
    this.offset = off;
    return this;
  }
  
  public RadioButton setTxtHeight(float txtHeight){
    this.txtHeight = txtHeight;
    return this;
  }
  
  public RadioButton setLineCol(int lCol){
    this.lineCol = lCol;
    return this;
  }
  
  public RadioButton setRenderHelpLine(boolean render){
    this.helpLine = render;
    return this;
  }
  
  float txtHeight;
  
  float line;
  float offset;
  
  boolean renderHl;
  boolean helpLine;
  
  int lineCol;
  
  //float yPos, ySize, xPos, x2Pos;
  
  public void render(){
    //l
    fill(col);
    rect(xPos, yPos, xSize, ySize);
    // txt
    new TextPanel(txt, xPos, yPos, xSize, txtHeight).setCol(txtCol).render();
    
    
    
    
    float size = (ySize - txtHeight) / 4.0;
    
   // float difS = ySize / 3;
    float pos = yPos + txtHeight + (ySize - txtHeight) / 2.0;
    
    fill(lineCol);
    stroke(lineCol);
    line(xPos + offset, pos, xPos + xSize - offset, pos);
    ellipse(xPos + offset + line * (xSize - 2.0 * offset) / 100.0, pos, size, size);
    
    // in case it will be forgotten
    afterRender();
    
  }
  
  public void afterRender(){
    if(renderHl){
      float x = xPos + offset;
      line(x, 0, x, height);
      x = xPos + offset + line * (xSize - 2.0 * offset) / 100.0;
      line(x, 0, x, height);
      x = xPos + xSize - offset;
      line(x, 0, x, height);
      //renderHl = false;
    }
    
  }
  /*
  public void tickButton(){
    
    
    if(super.tickButton()){
      
    }
    /*
    if(mouseY < yPos){
      //time.put("test", new Time());
     // value = testSizes[(int) (testSizes.length * mouseX / width)];
      //spris.add(new Spri(new Time(), 
     // doRender();
    } else if(mouseY > yPos + ySize){
      //if(value > 0 && !added){
        //added = true;
        
     //   time.put("got", new Time());
      //  spris.add(this);
      //}
      backScreen();
    /*  if(getLine() > 0.5){
        ((Times) useProc).testWasSucces = true;
      }
    }*
    
  }*/
  
  /*
  public float getDif(){
    return getLine();
  }*/
  
  
  public float getLine(){
    return line;
  }
  /*
  public String getData(){
    String rV = value + ", ";
    //rV += getTimeData();
    
    rV += "t(" + getLine() + ")";
    return rV;
  }*/
  
  public void tickPress(){
    //renderHl = false;
    if(mouseY > yPos && mouseY < yPos + ySize){
     // int y = (int) (2 * (mouseY - yPos) / ySize);
      //println(y);
     // if(y == 0){
        line = 100 * (mouseX - (xPos + offset)) / (xSize - 2 * offset);
        
        if(line < 0){
          line = 0;
       // } else if(mouseX > x2Pos){
          //line = x2Pos;
        } else if(line > 100){
          line = 100;
        }
      //}
      
      if(helpLine){
        renderHl = true;
      }
     useProc.doRender();
    }
  }
  
  public void tickRelease(){
    renderHl = false;
    useProc.doRender();
  }
  
  
  
  
}


public class Offset extends Panel {
  
  public Offset(){
    setOffset(0);
    
  }
  
  //public Offset 
  
  public Offset setOffset(float offset){
    this.offset = offset;
    //println("O.setOffset: " + this.offset);
    refreshPosSize();
    return this;
  }
  
  public void nevPosSize(int id){
    super.nevPosSize(id);
    //println("O.nevPosSize " + this.offset);
    refreshPosSize();
  }
  
  private void refreshPosSize(){
    //println("O.refreshPosSize: " + this.offset);
    float off = this.offset;
    //println("refresj: " + off);
    this.xOffPos = xPos + off;
    this.yOffPos = yPos + off;
    
    off *= 2;
    
    this.xOffSize = xSize - off;
    this.yOffSize = ySize - off;
    
  }
  
  
  float offset;
  
  float xOffPos, yOffPos, xOffSize, yOffSize;
}






