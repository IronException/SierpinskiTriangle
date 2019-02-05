 
public int getIntValue(byte[] data, int pos, int len){
  return (int) getLongValue(data, pos, len);
}

public long getLongValue(byte[] data, int pos, int len){
    boolean first = true;
    len *= 2;
    long rV = 0;
    for(int i = 0; i < len; i ++){
      rV *= 16;
      rV += getNibble(data[pos], first);
      //println("doLong: " + getNibble(data[pos], first) + " = " + rV + " " + pos + " " + first);
      //pointer.nibbleAdd();
      first = !first;
      if(first){
        pos ++;
      }
    }
    
    return rV;
  }
  
  public byte getNibble(byte data, boolean first){
    //a = info[ind];
    if(first){
      return (byte) (data >> 4); // test wether this 0x0F is needed
    }
    
    return (byte) (data & 0x0F);
}
  
  
  
 
 
 
public class Time{
  
  protected int year;
  protected int month;
  protected int day;
  protected int hour;
  protected int min;
  protected int sec;
  //protected int mil;
  
  public final int[] monthSize = new int[]{
    31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
  };
  
  public Time(){
    this(year(), month(), day(), hour(), minute(), second(), millis());
    //this.mil = millis(); 
  }
  
  public Time(Time clone){
    this(clone.year, clone.month, clone.day, clone.hour, clone.min, clone.sec);
  }
  
  public Time(int day, int month, int year){
    this(year, month, day, 0, 0, 0, 0);
  }
  
  public Time(int hour, int min, int sec, int mil){
    this(0, 0, 0, hour, min, sec, mil);
  }
  
  public Time(int year, int month, int day, int hour, int min, int sec){
    this(year, month, day, hour, min, sec, 0);
  }
  
  public Time(int year, int month, int day, int hour, int min, int sec, int mil){
    this.year = year;
    this.month = month;
    this.day = day;
    this.hour = hour;
    this.min = min;
    this.sec = sec;
    //this.mil = mil;
    // TODO
  }
  
  
  public Time setTime(Time set){
      this.year = set.year;
      this.month = set.month;
      this.day = set.day;
      this.hour = set.hour;
      this.min = set.min;
      this.sec = set.sec;
      return this;
  }
  
  public Time clone(){
    Time rV = new Time();
    rV.setTime(this);
    return rV;
  }
  
  public int getMonthSize(){
    if(leapYear() && month == 2){
      return 29;
    }
    return monthSize[month - 1];
  }
  
  public String toDate(){
    return toDate(true, true);
  }
  
  
  public String toDate(boolean withWeek, boolean withTime){
    String rV = year + "";
    String add = month + "";
    if(add.length() == 1){
      rV += "0";
    }
    rV += add;
    
    add = day + "";
    if(add.length() == 1){
      rV += "0";
    }
    rV += add;
    
    if(withWeek){
      rV += "-" + toWeek();
    }
    
    rV += toWeekDay();
    
    if(withTime){
      rV += toTime();
    }
    
    
    
    
    return rV;
  }
  
  public int getWeekDay(){
    return getWeekDay(true, year, month, day);
  }
  
  public String toWeekDay(){
    /*String rV;
    switch(getWeekDay()){
      case 0:
      rV = "MOMO";
      break;
      case 1:
      rV = "TUDI";
      break;
      case 2:
      rV = "WEMI";
      break;
      case 3:
      rV = "THDO";
      break;
      case 4:
      rV = "FRFR";
      break;
      case 5:
      rV = "SASA";
      break;
      case 6:
      rV = "SUSO";
      break;
      default:
      rV = "";
    }
    return rV;*/
    return toWeekDay(true, year, month, day);
  }
  
  public String toTime(){
    String rV = hour + "";
    if(rV.length() == 1){
      rV = "0" + rV;
    }
    
    String add = min + "";
    if(add.length() == 1){
      rV += "0";
    }
    rV += add;
    
    //if(withSec && savedSec){
      rV += ".";
      add = sec + "";
      if(add.length() == 1){
        rV += "0";
      }
      rV += add;
      /*
      rV += ".";
      add = mil + "";
      while(add.length() < 3){
        add = "0" + add;
        //for(int i = add.length(); i < 
      }
      rV += add;*/
   // }
    return rV;
  }
  
  
  
  public String toWeek(){
    String rV = getWeek() + "";
    if(rV.length() == 1){
      rV = "0" + rV;
    }
    return rV;
  }
  
  public int getDayInYear(){
    return getDayInYear(true, year, month, day);
  }
  
  public int getDayInYear(boolean greg, int year, int month, int day){
    int sum = day;
    int monthToCalc = month - 1;
    while(monthToCalc > 0){
      sum += getDaysOfMonth(monthToCalc);
      monthToCalc --;
    }
    
    return sum;
  }
  
  
  
  
  public int getDaysOfMonth(int month){
    int rV = monthSize[month - 1];
    if(month == 2 && leapYear(true, year)){
      rV ++;
    }
    return rV;
  }
  
 
  
public int getWeekDay(boolean greg, int year, int month, int day){
  int yearD = year % 100;
  
  int yearHalf = yearD / 4;
  int yearCode = (yearD + yearHalf) % 7;
  
  int monthCode = 0;
  switch((month - 1) % 12){
    case 0:
      monthCode = 0;
      break;
    case 1:
      monthCode = 3;
      break;
    case 2:
      monthCode = 3;
      break;
    case 3:
      monthCode = 6;
      break;
    case 4:
      monthCode = 1;
      break;
    case 5:
      monthCode = 4;
      break;
    case 6:
      monthCode = 6;
      break;
    case 7:
      monthCode = 2;
      break;
    case 8:
      monthCode = 5;
      break;
    case 9:
      monthCode = 0;
      break;
    case 10:
      monthCode = 3;
      break;
    case 11:
      monthCode = 5;
      break;
  }
  
  int centuryCode = (18 - ((year - yearD) / 100)) % 7;
  //ce /= 100;
  if(greg){
    centuryCode = 6 - (((year - yearD) / 50) % 4);
  }
  
  int leapYearCode = 0;
  if(leapYear(greg, year) && month <= 2){
    leapYearCode = -1;
  }
  
  
  return (yearCode + centuryCode + monthCode + day - 1 + leapYearCode) % 7;
}


public boolean leapYear(){
  return leapYear(true, this.year);
}

public boolean leapYear(boolean gregorian, int year){
  boolean leapYear = false;
  if(year % 4 == 0){
    leapYear = true;
    if(gregorian && year % 100 == 0){
      leapYear = false;
      if(year % 400 == 0){
        leapYear = true;
      }
    }
  }
  
  return leapYear;
}


public String toWeekDay(boolean greg, int year, int month, int day){
  switch(getWeekDay(greg, year, month, day)){
    case 0:
      return "MOMO";
    case 1:
      return "TUDI";
    case 2:
      return "WEMI";
    case 3:
      return "THDO";
    case 4:
      return "FRFR";
    case 5:
      return "SASA";
    case 6:
      return "SUSO";
    
  }
  
  return "";
}
 
 
 public int getWeek(){
    int days = getDayInYear();
    //text(days, width/12, height/4);
    int firstDay = getWeekDay(true, year, 1, 1);
    
    days -= firstDay + 1;
    
    // (days -= (getWeekDay() + 1); )
    
    int rV = 1 + days / 7;
    if(firstDay > 3){
      rV ++;
    }
    if(rV == 0){
      rV = 52; // in lastYear
    }
    
    return rV;
  }
  
  public boolean equals(Time c){
    boolean rV = true;
    if(!equalsDate(c)){
      rV = false;
    }
    if(!equalsTime(c)){
      rV = false;
    }
    return rV;
  }
  
  public boolean equalsDate(Time c){
    boolean rV = true;
    if(this.year != c.year){
      rV = false;
    }
    if(this.month != c.month){
      rV = false;
    }
    if(this.day != c.day){
      rV = false;
    }
    return rV;
  }
  
  public boolean equalsTime(Time c){
    boolean rV = true;
    if(this.hour != c.hour){
      rV = false;
    }
    if(this.min != c.min){
      rV = false;
    }
    if(this.sec != c.sec){
      rV = false;
    }
    return rV;
  }
  
  
  public Time negate(){
    int r = -1;
    year *= r;
    month *= r;
    day *= r;
    hour *= r;
    min *= r;
    sec *= r;
    
    return this;
  }
  
  public Time subTime(Time toSub){
    //toSub.negate();
    Time big = new Time(this);
    //println("so?");
    Time small = new Time(toSub).negate();
    big.addTime(small.hour, small.min, small.sec);
    big.day += small.day;
    
    big.addMonth(small.month);
    for( ; big.month > 0; big.month --){
      big.day = big.getMonthSize();
      
    }
    big.year --;
    
    big.year += small.year;
    for( ; big.year > 0; big.year --){
      day += 365;
      if(big.leapYear()){
        day ++;
      }
    }
    
    // time adding is alright
    // month and years to days
    
    toSub = big; // ?
    
    return big;//addTime(new Time(a).negate());
    //return addTime(b);
  }
  
  private void addTime(int hourI, int minI, int secI){
    this.sec += secI;
    int n = sec - (sec % 60);
    if(sec < 0){
      n -= 60;
    }
    sec -= n;
    min += n / 60;
    
    this.min += minI;
    n = min - (min % 60);
    if(min < 0){
      n -= 60;
    }
    min -= n;
    hour += n / 60;
    
    this.hour += hourI;
    n = hour - (hour % 24);
    if(hour < 0){
      n -= 24;
    }
    hour -= n;
    day += n / 24;
    
  }
  
  public Time addTime(Time a) {
    addTime(a.hour, a.min, a.sec);
    
    this.day += a.day - 1;
    while(day < 0){
      addMonth(-1);
      day += getMonthSize();
    }
    while(day > getMonthSize() - 1){
      day -= getMonthSize();
      addMonth(1);
    }
    day ++;
    
    addMonth(a.month);
    this.year += a.year;
    return this;
  }
  
  public void addMonth(int toAdd){
    this.month += toAdd - 1;
    int n = month - (month % 12);
    if(month < 0){
      n -= 12; // - think that wors 12 or what? 11?
    } // except for erg 1 !!!!
    month -= n;
    year += n / 12;
    
    month ++;
  }
  
  
  public byte[] getByteTime(byte last){
    //byte[] rV = new byte[
    int erg = hour * 60 * 60;
    erg += min * 60;
    erg += sec;
    
    byte[] zw = int2b(erg);
    byte[] rV = new byte[3];
    for(int i = 0; i < rV.length; i ++){
      rV[i] = zw[i + 1];
    }
    
    rV[0] += last << 1;
    
    return rV;
  }
  
  public byte setByteTime(byte[] info){
    byte rV = (byte) (info[0] >> 1);
    int erg = (info[0] & 0x01) << 16 | (info[1] & 0xFF) << 8 | (info[2] & 0xFF);
    
    sec = erg % 60;
    erg -= sec;
    
    min = erg % (60 * 60);
    
    erg -= min;
    min /= 60;
    
    hour = erg / (60 * 60);
    
    return rV;
  }
  
  public byte[] getByteDate(){
    byte[] rV;
    byte[] zw;
    boolean setLongYear = false;
    int erg = day - 1;//(year - 2000) * 60 * 60;
    erg += (month - 1) * 30;
    int useYear = year - 2000;
    if(useYear > 99 || useYear < 0){
      //erg += year * 30 * 11;
      
      rV = new byte[3 + 4];
      //year = 126;
      zw = int2b(year);
      //println(zw);
      for(int i = 0; i < zw.length; i ++){
        rV[3 + i] = zw[i];
      }
      //println(getIntValue(zw, 0, 4));
      
      setLongYear = true;
      
    } else {
      erg += useYear * 30 * 11;
      rV = new byte[3];
    }
    zw = int2b(erg);
    //rV = new byte[3];
    for(int i = 0; i < 3; i ++){
      rV[i] = zw[i + 1];
    }
    
    //rV[0] += last << 1;
    if(setLongYear){
      byte help = rV[0];
     // print(help);
      help = (byte) (help & 0x3F);
      help += 0x80;
     // println(" -> " + help);
      rV[0] = help;
    }
    
    
    return rV;
  }
  
  public int setByteDate(byte[] data, int pos){
    int len = 3;
    //boolean addOne;
    /*long info;
    
    if((data[pos] & 0x80) == 0x80){
      //addOne = true;
      println("works");
      
      len = getIntValue(new byte[]{(byte) (data[pos] & 0x3F)}, 0, 1);
      info = getLongValue(data, pos + 1, len);
      
      len ++; // for the pos ++
    } else{
      info = getIntValue(data, pos, len);
    }*/
    
    //byte rV = (byte) (info[0] >> 1);
    int erg = (data[pos] & 0x3F) << 16 | (data[pos + 1] & 0xFF) << 8 | (data[pos + 2] & 0xFF);
    
    day = erg % 30 + 1;
    erg -= day;
    
    month = erg % (30 * 11);
    
    erg -= month;
    month /= 30;
    month ++;
    
    year = erg / (30 * 11) + 2000;
    if((data[pos] & 0x80) == 0x80){
      
      year = getIntValue(data, pos + len, 4);
    //  println(year);
      len += 4;
    }
    
    
    //data[pos] = (byte) 0xF0;
    //println(data[pos] + " -> " + (data[pos] << 1));
    //println((data[pos] & 0x80) == 0x80);
    
    return len;
  }
  
  
  public Time setStringDate(String data){
    // year month day 
    String[] sp = data.split("-");
    int len = sp[1].length();
    setStringTime(sp[1].substring(len - 7, len));
    data = sp[0];
    len = data.length();
    try{
      day = Integer.parseInt(data.substring(len - 2, len));
      month = Integer.parseInt(data.substring(len - 4, len - 2));
      year = Integer.parseInt(data.substring(0, len - 4));
    } catch(Exception e){}
    return this;
  }
  
  public Time setStringTime(String data){
    //data = data.split("-")[0];
    int len = data.length();
    try{
      sec = Integer.parseInt(data.substring(len - 2, len));
      min = Integer.parseInt(data.substring(len - 5, len - 3));
      hour = Integer.parseInt(data.substring(0, len - 5));
    } catch(Exception e){
      println("time: " + e);
    }
    return this;
  }
  
  public long getSecs(){
    long rV = 0;
    
    
   // rV += day * 24 * 60 * 60;
    rV += hour * 60 * 60;
    rV += min * 60;
    rV += sec;
    return rV;
  }

  
}