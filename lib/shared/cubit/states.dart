abstract class WeatherStates{}

class WeatherInitialState extends WeatherStates{}

//get current location states
class GetCurrentLocationLoadingState extends WeatherStates{}
class GetCurrentLocationSuccessState extends WeatherStates{}
class GetCurrentLocationErrorState extends WeatherStates{
  final String error;
  GetCurrentLocationErrorState(this.error);
}

//get current weather states
class GetCurrentWeatherDataLoadingState extends WeatherStates{}
class GetCurrentWeatherDataSuccessState extends WeatherStates{}
class GetCurrentWeatherDataErrorState extends WeatherStates{}

//get 5 days weather forecast states
class GetFiveDyesForecastWeatherDataLoadingState extends WeatherStates{}
class GetFiveDyesForecastWeatherDataSuccessState extends WeatherStates{}
class GetFiveDyesForecastWeatherDataErrorState extends WeatherStates{}

//get sunrise sun set states

class GetSunriseSunsetTimeLoadingState extends WeatherStates{}
class GetSunriseSunsetTimeSuccessState extends WeatherStates{}
class GetSunriseSunsetTimeErrorState extends WeatherStates{}

//determine night states

class DetermineIsNightSuccessState extends WeatherStates{}


//get Current Weather For Cities for other cities

class GetCurrentWeatherForOtherCitiesLoadingState extends WeatherStates{}
class GetCurrentWeatherForOtherCitiesSuccessState extends WeatherStates{}
class GetCurrentWeatherForOtherCitiesErrorState extends WeatherStates{}