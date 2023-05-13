class SunriseModel{
Results? results;
String? status;

SunriseModel.fromJson( json){
  results=Results.fromJson(json['results']);
  status=json['status'];
}
}

class Results{
  String? sunrise;
  String? sunset;
  String? solarNoon;
  String? dayLength;
  String? civilTwilightBegin;
  String? civilTwilightEnd;
  String? nauticalTwilightBegin;
  String? nauticalTwilightEnd;
  String? astronomicalTwilightBegin;
  String? astronomicalTwilightEnd;

  Results.fromJson(Map<String,dynamic> json){
     sunrise=json['sunrise'];
     sunset=json['sunset'];
     solarNoon=json['solarNoon'];
     dayLength=json['dayLength'];
     civilTwilightBegin=json['civilTwilightBegin'];
     civilTwilightEnd=json['civilTwilightEnd'];
     nauticalTwilightBegin=json['nauticalTwilightBegin'];
     nauticalTwilightEnd=json['nauticalTwilightEnd'];
     astronomicalTwilightBegin=json['astronomicalTwilightBegin'];
     astronomicalTwilightEnd=json['astronomicalTwilightEnd'];
  }
}