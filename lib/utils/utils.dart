import 'dart:ffi';

class Util{
  static String greetings(){
    int hour = DateTime.now().hour;
    if(hour>0&&hour<6){
      return "Good Night";
    }
    else if(hour>=6&&hour<12){
      return "Good Morning";

    }
    else if(hour>=12&&hour<18){
      return "Good Afternoon";

    }
    else if(hour>=16&&hour<21){
      return "Good Evening";

    }
    else{
      return "Good Night";
    }

  }
}