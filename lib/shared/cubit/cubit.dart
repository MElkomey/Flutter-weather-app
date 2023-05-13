import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/current_weather_model.dart';
import 'package:weather_app/models/five_days_forecast_model.dart';
import 'package:weather_app/models/sunrise_sunset_model.dart';
import 'package:weather_app/shared/cubit/states.dart';
import 'package:weather_app/shared/network/remote/dio_helper.dart';
import 'package:http/http.dart' as http;

class WeatherCubit extends Cubit<WeatherStates>{

  WeatherCubit(): super(WeatherInitialState());
  static WeatherCubit get(context) => BlocProvider.of(context);

  var long,lat;
  bool isNight=false;
  TimeOfDay? sunrise;
  TimeOfDay? sunset;



  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void getPosition(){
    emit(GetCurrentLocationLoadingState());
    determinePosition().then((value) {
     if(kDebugMode) print(value);
      long=value.longitude;
      lat=value.latitude;
      emit(GetCurrentLocationSuccessState());
     getFiveDaysForeCast();
    }).catchError((error){
      emit(GetCurrentLocationErrorState(error.toString()));
    });
  }


 CurrentWeather? currentWeather;
  void getCurrentWeatherByLonLat(){
 emit(GetCurrentWeatherDataLoadingState());
    DioHelper.getData(
        url: 'data/2.5/weather',
        queryParams:   long==null&&lat==null? {'q':'cairo','appid':'fd077282779b0fde456c151f3f7c45c2',}: {'lat':lat, 'lon':long, 'appid':'fd077282779b0fde456c151f3f7c45c2',},
    ).then((value) {
      currentWeather=CurrentWeather.fromJson(value.data);
      if(kDebugMode) print(value.data.toString());
      getSunriseSunset();
      emit(GetCurrentLocationSuccessState());
    }).catchError((error){
      if(kDebugMode)  print(error);
      emit(GetCurrentWeatherDataErrorState());
    });
  }

FiveDaysForecastModel? fiveDaysForecastModel;
  void getFiveDaysForeCast(){
    emit(GetFiveDyesForecastWeatherDataLoadingState());
    DioHelper.getData(
        url: 'data/2.5/forecast',
        queryParams: {
          'lat': lat,
          'lon': long,
          'appid': 'fd077282779b0fde456c151f3f7c45c2',
        }
    ).then((value) {
      fiveDaysForecastModel=FiveDaysForecastModel.fromJson(value.data);
      if(kDebugMode) print(value.data.toString());
      print(fiveDaysForecastModel!.list);
      emit(GetFiveDyesForecastWeatherDataSuccessState());
    }).catchError((error){
      if(kDebugMode) print(error);
      emit(GetFiveDyesForecastWeatherDataErrorState());
    });
  }

  SunriseModel? sunriseModel;
  void getSunriseSunset()async{
    emit(GetSunriseSunsetTimeLoadingState());
    final  res= await http.get(Uri.parse('https://api.sunrise-sunset.org/json?lat=$lat&lng=-$long&date=today'));
   if(res.statusCode==200){
     var obj=json.decode(res.body);
     sunriseModel=SunriseModel.fromJson(obj);
     if(kDebugMode) print(res.body);
     List list1=sunriseModel!.results!.sunrise!.split(':');
     List list2=sunriseModel!.results!.sunrise!.split(' ');
     print(list1); print(list2);
     sunrise=TimeOfDay(hour:
     list2[1]=='AM'? int.parse(list1[0]):int.parse(list1[0])+12,
         minute: int.parse(list1[1]));
      list1=sunriseModel!.results!.sunset!.split(':');
      list2=sunriseModel!.results!.sunset!.split(' ');
     sunset=TimeOfDay(hour:
     list2[1]=='AM'? int.parse(list1[0]):int.parse(list1[0])+12,
         minute: int.parse(list1[1]));
     print(sunrise);print(sunset);
     emit(GetSunriseSunsetTimeSuccessState());
     determineNight();
   }else{
     if(kDebugMode) print('failed to get sunRise/set');
     emit(GetSunriseSunsetTimeErrorState());
   }
  }
  //https://api.sunrise-sunset.org/json?lat=36.7201600&lng=-4.4203400&date=today

void determineNight(){
    print('now time: ${DateTime.now().hour}');
    if(sunriseModel!=null){
      if(DateTime.now().hour < sunset!.hour &&DateTime.now().hour > sunrise!.hour){
        isNight=false;
      }else{
        isNight=true;
      }
      print('isNight: $isNight');
      emit(DetermineIsNightSuccessState());
    }
}

List<CurrentWeather>? otherCities=[];
  List<String> cities=[
    'alexandria',
    'cairo',
    'suez',
    'aswan',
    'Assiut',
  ];

  void getCurrentWeatherForCities(){
    emit(GetCurrentWeatherForOtherCitiesLoadingState());
    int count=0;
    cities.forEach((element) {
      DioHelper.getData(
        url: 'data/2.5/weather',
        queryParams: {'q':'$element','appid':'fd077282779b0fde456c151f3f7c45c2',},
      ).then((value) {
        CurrentWeather? currentWeather;
        currentWeather=CurrentWeather.fromJson(value.data);
        otherCities?.add(currentWeather);
        // if(kDebugMode) print(value.data.toString());
        // print(otherCities?.length);
        emit(GetCurrentWeatherForOtherCitiesSuccessState());
      }).catchError((error){
        if(kDebugMode)  print(error);
        emit(GetCurrentWeatherForOtherCitiesErrorState());
      });
      count++;
    });

  }

}