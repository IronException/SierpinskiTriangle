import android.os.Environment;
import android.os.Vibrator;
import android.content.Context;

int vibSetup = 100;
int vibStand = 75;
int vibBut = 25;

float tpsCool = 4.5;
float start = 1;


void draw(){
  useProc.drawHelper();
}

UseProc useProc;
ArrayList<UseProc> lastUsedProc = new ArrayList<UseProc>();

public void nextScreen(UseProc nev){
  lastUsedProc.add(useProc);
  useProc = nev;
  useProc.doRender(); // useless but comes in handy when u dont use backScreen
  //accScreen(true);
}

public void backScreen(){
  
  try{
    
    UseProc nev = lastUsedProc.remove(lastUsedProc.size() - 1);
    //println("how did this work?");
    if(nev != null){
      useProc = nev;
    } else {
      println("got null in backScreen: " + this);
    }
  } catch(Exception e){
    println("Error in backScreen(" + e + "): " + this);
  }
  useProc.onBackScreen();
  useProc.setRender();
  //accScreen(false);
}

public void delAutoSave(){
  new FileManager(new String[]{"autoSave", appName, "autoSave.txt"}).setStrings(new String[0]);
}


//#^#^#^#^#^#^#^#^#^#^#^
/**
  only removes 1 entry that is same as data
*/
public String[] remove(String[] info, String data){
  // TODO
  //println(info);
  boolean removed = false;
  String[] rV = new String[info.length - 1];
  for(int i = 0; i < info.length; i ++){
    //println("i: " + i);
    if(removed){
      rV[i - 1] = info[i];
    } else {
      if(info[i].equals(data)){
        removed = true;
      } else if(i < rV.length) {
        
        rV[i] = info[i];
        
      }
    }
    //println(rV);
  }
  if(removed){
    return rV;
  }
  // if nothing got removed... its the old
  return info;
}
//#&#^#^#^#&#&#^#&#&#&#&#&#^


void onResume(){
  super.onResume();
  //accResume();
  try{
    useProc.setDoRender(true);
  }catch(Exception e){}
  super.onResume();
}

void onPause(){
  super.onPause();
  //accPause();
}






public void vibrate(int millis){
  //((Vibrator) getActivity().getSystemService(Context.VIBRATOR_SERVICE)).vibrate(millis);
}






public class Cooldown{
  
  public Cooldown(){
    this(tpsCool);
  }
  
  public Cooldown(float tps){
    this((int) (frameRate/tps));
  }
  
  public Cooldown(int cooldown){
    this.timer = cooldown;
  }
  
  int timer;
  
  public void update(){
    timer --;
  }
  
  public boolean isExpired(){
    if(timer < 1){
      return true;
    }
    return false;
  }
  
}

