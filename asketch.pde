




void setup(){
  fullScreen();
  //accSetup();
  appName = this + ""; // preferably act appName... cuz the hex at end changes stimes
  frameRate(60);
  init();
  nextScreen(new Page());
  thread("loadAutoSave");
}

String appName;

/*
FAQ
doRender();
backScreen();

*/

public void autoSave(){
  thread("actAutoSave");
}

public void actAutoSave(){
  String rV = "";
  String bar = ":";
  
  //rV += events.autoSave();
  rV += bar;
  
  new FileManager(new String[]{"autoSave", appName, "autoSave.txt"}).setStrings(new String[]{rV});
}

public void loadAutoSave(){
  String[] info = new FileManager(new String[]{"autoSave", appName, "autoSave.txt"}).getStrings();
  if(info.length != 1){
    // WARNING: RETURNS IF !1
    return;
  }
  
  // how is it saved?
  try{
    String[] sp = info[0].split(":");
    int ind = 0;
    
    ind ++;
    
  
  } catch(Exception e){
    
  }
  useProc.doRender();
}



public void init(){
  
  
}




