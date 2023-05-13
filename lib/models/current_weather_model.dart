// https://api.openweathermap.org/data/2.5/weather?q=tanta&appid=fd077282779b0fde456c151f3f7c45c2

class CurrentWeather{
  Coord? coord;
  Weather? weather;
  String? base;
  Main? main;
  int? visibility;
  Wind? wind;
  Clouds? clouds;
  int? dt;
  Sys? sys;
  int? timezone;
  int? id;
  String? name;
  int? cod;
  
  CurrentWeather.fromJson(Map <String, dynamic> json){

  coord=Coord.fromJson(json['coord']);
  weather=Weather.fromJson(json['weather']);
  base=json[base];
  main=Main.fromJson(json['main']);
  visibility=json['visibility'];
  wind=Wind.fromJson(json['wind']);
  clouds=Clouds.fromJson(json['clouds']);
  dt=json['dt'];
  sys=Sys.fromJson(json['sys']);
  timezone=json['timezone'];
  id=json['id'];
  name=json['name'];
  cod=json['cod'];

  }
}


class Coord {
  double? lon;
  double? lat;
  Coord.fromJson(Map <String, dynamic> json){
    lon=json['lon'];
    lat=json['lat'];
  }
}

class Weather {
  int? id;
  String? main;
  String? icon;
  String? description;

  Weather.fromJson( json){
    id=json.first['id'];
    main=json.first['main'];
    icon=json.first['icon'];
    description=json.first['description'];
  }

}

class Main {
  double? temp;
  double? feels_like;
  double? temp_min;
  num? temp_max;
  int? pressure;
  int? humidity;
  num? sea_level;
  num? grnd_level;
  num? temp_kf;

  Main.fromJson(Map <String, dynamic> json){
    temp=json['temp'];
    feels_like=json['feels_like'];
    temp_min=json['temp_min'];
    temp_max=json['temp_max'];
    pressure=json['pressure'];
    humidity=json['humidity'];
    sea_level=json['sea_level'];
    grnd_level=json['grnd_level'];
    temp_kf=json['temp_kf'];
  }

}

class Wind {
  num? speed;
  num? deg;
  num? gust;

  Wind.fromJson(Map <String, dynamic> json){
    speed=json['speed'];
    deg=json['deg'];
    gust=json['gust'];
  }

}

class Clouds {
  num? all;
  Clouds.fromJson(Map <String, dynamic> json){
    all=json['all'];
  }

}

class Sys {
  String? country;
  int? sunrise;
  int? sunset;
  String? pod;
  Sys.fromJson(Map <String, dynamic> json){
    country=json['country'];
    sunrise=json['sunrise'];
    sunset=json['sunset'];
    pod=json['pod'];
  }

}