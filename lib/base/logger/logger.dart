library logger;

class Log {


  void e( msg) {
    print("===${Level.ERROR.val}===:= $msg");
  }

  void i( msg){
    print("===${Level.INFO.val}===:= $msg");
  }
}

class Level{

  final int level;
  final String val;

  const Level(this.level,this.val);
  
  static const Level INFO = const Level(0,"INFO");

  static const Level ERROR = const Level(1, "ERROR");
}

final logger = Log();
