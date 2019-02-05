




public class ComTag extends UseProc {
  
  public ComTag(){
    super();
    
    xSize = width / 2;
    
    tagSize = width / 3;
    
    ySaveSize = height / 6;
    ySavePos = height - ySaveSize;
    
    saveTxt = new TextPanel[2];
    saveTxt[0] = new TextPanel("<", 0, ySavePos, xSize, ySaveSize);
    saveTxt[1] = new TextPanel("save", xSize, ySavePos, xSize, ySaveSize);
    
    String[] info = new FileManager(new String[]{"Tags", "information.txt"}).getStrings();
    //loadStrings(getTagInfo());
    
    tags = new Tag[info.length];
    for(int i = 0; i < tags.length; i ++){
      tags[i] = new Tag(info[i]);
    }
    
    tagInd = 0;
  }
  
  float tagSize;
  
  float xSize;
  
  float ySavePos;
  float ySaveSize;
  TextPanel[] saveTxt;
  
  
  float xTagPos;
  int tagInd;
  Tag[] tags;
  
  float xMousePos;
  
  public void render(){
    background(225);
    renderTags();
    
    renderSave();
  }
  
  public void renderTags(){
    for(int y = 0; y < 3; y ++){
      for(int x = 0; x < 4; x ++){
        fill(255);
        rect(xTagPos + x * tagSize, y * tagSize, tagSize, tagSize);
        //new TextPanel((tagInd * 3 + x * 3 + y) + "", xTagPos + x * tagSize, y * tagSize, tagSize, tagSize).render();
        
        try{
          tags[tagInd * 3 + x * 3 + y].render(xTagPos + x * tagSize, y * tagSize, tagSize);
        } catch(Exception e){
          
        }
      }
    }
    
  }
  
  public void renderSave(){
    fill(225);
    rect(0, ySavePos, xSize, ySaveSize);
    rect(xSize, ySavePos, xSize, ySaveSize);
    
    saveTxt[0].render();
    saveTxt[1].render();
  }
  
  public void tickButtons(){
    if(mouseY < width){
      int x = 3 * mouseX / width;
      int y = 3 * mouseY / width;
      try{
        tags[tagInd * 3 + x * 3 + y].tick();
        
        coolActivate();
      }catch(Exception e){}
      
    }
    
    if(mouseY > ySavePos){
      if(mouseX < xSize){
        back();
      } else {
        sace();
      }
    }
  }
  
  public void tickPress(){
    if(mouseX < 3 * tagSize){
      //float change = 
      xTagPos += mouseX - xMousePos;
      if(xTagPos > 0){
        xTagPos -= tagSize;
        tagInd --;
        if(tagInd < 0){
          tagInd ++;
          xTagPos = 0;
        }
      } else if(xTagPos < -tagSize){
        xTagPos += tagSize;
        tagInd ++;
        if(tagInd + 3 > (tags.length - 1) / 3){
          tagInd --;
          xTagPos = -tagSize;
        }
      }
      setDoRender(true);
    
    }
    
    xMousePos = mouseX;
  }
  
  
  public void tickPressStart(){
    xMousePos = mouseX;
  }
  
  public String getTags(){
  String rV = "";
  for(int i = 0; i < tags.length; i ++){
    rV += tags[i].getNameIf(", ");
  }
  return rV;
}
  
  
  
}

public class Tag{
  
  
  public Tag(String info){
    // name:3:2
    //name:disNums:actNums
    //int rand;
    
    sp = info.split(":");
    //println(sp.length);
    //int left = sp.length;
    folder = null;
    try{
    name = sp[0];
    
    show = false;
    //try{
    if(sp[1].equals("2")){
      show = true;
      folder = sp[4];
    } else if(sp[2].equals("1")){
      show = true;
    }
    
    d = Integer.parseInt(sp[2]);
    a = Integer.parseInt(sp[3]);
    refreshImg();
    
    
    } catch(Exception e){
      
      switch(sp.length){
        case 0:
          name = "";
        case 1:
          show = true;
        case 2:
          d = 1;
        case 3:
          a = 1;
        
      }
      
    }
    
    
  }
  
  //int disNum;
  //int actNum;
  String[] sp;
  
  String name;
  
  String folder;
  
  int d, a;
  PImage dis;
  PImage act;
  
  boolean active;
  
  boolean show;
  
  public void refreshImg(){
    int rand;
    name = sp[0];
    if(sp[1].length() == 0){
      dis = createImage(2, 2, RGB);
    } else {
      rand = (int) random(d);
      //rand = (int) random(Integer.parseInt(sp[1]));
      rand ++;
      dis = new FileManager(new String[]{"Tags", name + rand + ".png"}).getImg();
      //loadImage(getTags() + name + rand + ".png");
      //println(dis);
      if(dis == null){
        dis = createImage(2, 2, RGB);
      }
    }
    
    if(sp[2].length() == 0){
      act = createImage(2, 2, RGB);
    } else {
      rand = (int) random(a);
      //rand = (int) random(Integer.parseInt(sp[2]));
      rand ++;
      act = new FileManager(new String[]{"Tags", name + "-" + rand + ".png"}).getImg();
      //loadImage(getTags() + name + "-" + rand + ".png");
      if(act == null){
        act = createImage(2, 2, RGB);
      }
    }
    
  }
  
  public void render(float xPos, float yPos, float size){
    //fill(255);
    //rect(xPos, yPos, size, size);
    
    if(active){
      image(act, xPos, yPos, size, size);
    } else{
      image(dis, xPos, yPos, size, size);
    }
    
    if(show){
      float halfS = size /2;
      if(folder != null){
        halfS = size;
      }
      new TextPanel(name, xPos, yPos + halfS, size, halfS).render();
    }
    
  }
  
  public void tick(){
    active = !active;
    refreshImg();
  }
  
  public String getNameIf(String betw){
    String rV = "";
    if(active){
      rV = name + betw;
    }
    return rV;
  }
  
  
}

public void back(){
  backScreen();
}


// hdhdhdhdhdhdhdhdhdhdhd

public void sace(){
  FileManager values = new FileManager(
  new String[]{// to set:...
    "values.txt"
  });//.getStrings();
  
  values.addStrings(new String[]{getData()}, true);
  delAutoSave();
  //saveStrings(getValues(), nev);
  //println("atEnd");
  nextScreen(new Statistics());
}

public String getData(){
  String bar = ":";
  String rV = "";
  rV += new Time().toDate();
  
  rV += bar;
  
  
  
  /*rV += bar;
  if(resumed){
    rV += "resumed ";
  } else{
    rV += "open ";
  }
  rV += open.toDate(true, true, true);*/
  rV += bar;
  rV += ((ComTag) useProc).getTags();
  
  return rV;
}

