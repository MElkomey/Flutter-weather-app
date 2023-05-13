// http://api.openweathermap.org/data/2.5/forecast?q=cairo&appid=fd077282779b0fde456c151f3f7c45c2
//
class FiveDaysForecastModel {
  late final String cod;
  late final num message;
  late final num cnt;
  late final List<Listt> list;
  late final City city;

  FiveDaysForecastModel.fromJson(Map<String, dynamic> json){
    cod = json['cod'];
    message = json['message'];
    cnt = json['cnt'];
    list = List.from(json['list']).map((e)=>Listt.fromJson(e)).toList();
    city = City.fromJson(json['city']);
  }

}

class Listt {

  late final num dt;
  late final Main main;
  late final List<Weather> weather;
  late final Clouds clouds;
  late final Wind wind;
  late final num visibility;
  late final num pop;
  late final Sys sys;
  late final String dtTxt;

  Listt.fromJson(Map<String, dynamic> json){
    dt = json['dt'];
    main = Main.fromJson(json['main']);
    weather = List.from(json['weather']).map((e)=>Weather.fromJson(e)).toList();
    clouds = Clouds.fromJson(json['clouds']);
    wind = Wind.fromJson(json['wind']);
    visibility = json['visibility'];
    pop = json['pop'];
    sys = Sys.fromJson(json['sys']);
    dtTxt = json['dt_txt'];
  }


}

class Main {

  late final num? temp;
  late final num? feelsLike;
  late final num? tempMin;
  late final num? tempMax;
  late final num pressure;
  late final num seaLevel;
  late final num grndLevel;
  late final num humidity;
  late final num? tempKf;

  Main.fromJson(Map<String, dynamic> json){
    temp = json['temp'];
    feelsLike = json['feels_like'];
    tempMin = json['temp_min'];
    tempMax = json['temp_max']-272.15;
    pressure = json['pressure'];
    seaLevel = json['sea_level'];
    grndLevel = json['grnd_level'];
    humidity = json['humidity'];
    tempKf = json['temp_kf'];
  }


}

class Weather {

  late final num id;
  late final String main;
  late final String description;
  late final String icon;

  Weather.fromJson(Map<String, dynamic> json){
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

}

class Clouds {

  late final num all;

  Clouds.fromJson(Map<String, dynamic> json){
    all = json['all'];
  }


}

class Wind {

  late final num speed;
  late final num deg;
  late final num gust;

  Wind.fromJson(Map<String, dynamic> json){
    speed = json['speed'];
    deg = json['deg'];
    gust = json['gust'];
  }


}

class Sys {

  late final String pod;

  Sys.fromJson(Map<String, dynamic> json){
    pod = json['pod'];
  }


}

class City {

  late final num id;
  late final String name;
  late final Coord coord;
  late final String country;
  late final num population;
  late final num timezone;
  late final num sunrise;
  late final num sunset;

  City.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    coord = Coord.fromJson(json['coord']);
    country = json['country'];
    population = json['population'];
    timezone = json['timezone'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }


}

class Coord {

  late final num lat;
  late final num lon;

  Coord.fromJson(Map<String, dynamic> json){
    lat = json['lat'];
    lon = json['lon'];
  }

}
// import 'package:weatherapp/models/currentweathermodel.dart';
//
// class FiveDaysForecastModel{
//   String? cod;
//   int? cnt;
//   int? message;
//   List? list;
//   CityModel? city;
//
//   FiveDaysForecastModel.fromJson(Map<String, dynamic> json){
//     cod=json['cod'];
//     cnt=json['cnt'];
//     message=json['message'];
//     json['list'].forEach((element){
//       list?.add(ListModel.fromJson(element));
//     });
//     city=CityModel.fromJson(json['city']);
//   }
// }
//
// class CityModel{
//   int? id;
//   String? name;
//   Coord? coord;
//   String? country;
//   int? population;
//   int? timezone;
//   int? sunrise;
//   int? sunset;
//
//   CityModel.fromJson(Map<String, dynamic> json)
//   {
//     id=json['id'];
//     name=json['name'];
//     coord=Coord.fromJson(json['coord']);
//     country=json['country'];
//     population=json['population'];
//     timezone=json['timezone'];
//     sunrise=json['sunrise'];
//     sunset=json['sunset'];
//   }
//
//
// }
//
// class ListModel{
//   num? dt;
//   Main? main;
//   List<Weather>? weather;
//   Clouds? clouds;
//   Wind? wind;
//   num? visibility;
//   num? pop;
//   String? dttxt;
//
//   ListModel.fromJson(json){
//     dt=json['dt'];
//     main=Main.fromJson(json['main']);
//     json['weather'].forEach((element){
//       weather?.add(Weather.fromJson(element));
//     });
//     clouds=Clouds.fromJson(json['clouds']);
//     wind=Wind.fromJson(json['wind']);
//     visibility=json['visibility'];
//     pop=json['pop'];
//     dttxt=json['dttxt'];
//   }
// }
//
