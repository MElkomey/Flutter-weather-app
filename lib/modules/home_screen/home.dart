

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather_app/shared/cubit/cubit.dart';
import 'package:weather_app/shared/cubit/states.dart';



class HomeScreen extends StatelessWidget {

  var format= DateFormat().add_MMMMEEEEd();

  @override
  Widget build(BuildContext context) {
    var date= format.format(DateTime.now());
    return BlocProvider(
      create: (context)=>WeatherCubit()..getCurrentWeatherForCities()..getPosition(),
      child: BlocConsumer<WeatherCubit,WeatherStates>(
       listener: (context,state){
         if(state is GetCurrentLocationErrorState){
           var snackBar=SnackBar(
             content: Text('${state.error}',
             ),
           );
           ScaffoldMessenger.of(context).showSnackBar(snackBar);
         }
       },
       builder: (context,state){
         var cubit=WeatherCubit.get(context);
         List<SalesData> data=[
           SalesData('${DateTime.now().day.toString()}', (cubit.fiveDaysForecastModel?.list[0].main.tempMax)??0.0),
           SalesData('${DateTime.now().add(new Duration(days: 1)).day.toString()}', cubit.fiveDaysForecastModel?.list[8].main.tempMax??1.0),
           SalesData('${DateTime.now().add(new Duration(days: 2)).day.toString()}', cubit.fiveDaysForecastModel?.list[16].main.tempMax??2.0),
           SalesData('${DateTime.now().add(new Duration(days: 3)).day.toString()}', cubit.fiveDaysForecastModel?.list[24].main.tempMax??3.0),
           SalesData('${DateTime.now().add(new Duration(days: 4)).day.toString()}', cubit.fiveDaysForecastModel?.list[33].main.tempMax??4.0),         ];
         return Scaffold(
           body: Stack(
             children: [
               Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   if(cubit.isNight==false)
                   Container(
                     height: 300,
                     decoration: const BoxDecoration(
                         borderRadius: BorderRadius.only(
                           bottomRight: Radius.circular(40),
                           bottomLeft: Radius.circular(40),
                         ),
                         image: DecorationImage(
                             image: AssetImage(
                               'assets/images/cloud-in-blue-sky.jpg',
                             ),
                             fit: BoxFit.cover)),
                   ),
                   if(cubit.isNight==true)
                     Container(
                       height: 300,
                       decoration: const BoxDecoration(
                           borderRadius: BorderRadius.only(
                             bottomRight: Radius.circular(40),
                             bottomLeft: Radius.circular(40),
                           ),
                           image: DecorationImage(
                               image: AssetImage(
                                 'assets/images/night.jpg',
                               ),
                               fit: BoxFit.cover)),
                     ),
                 ],
               ),
               SingleChildScrollView(
                 child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       IconButton(
                           onPressed: () {
                            cubit.getCurrentWeatherByLonLat();
                           },
                           icon: const Icon(
                             Icons.my_location,
                             color: Colors.white,
                           )),
                       const SizedBox(
                         height: 15,
                       ),
                       TextFormField(
                         style: const TextStyle(color: Colors.white),
                         decoration: InputDecoration(
                             hintText: 'Search for other locations',
                             hintStyle: const TextStyle(color: Colors.white),
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                               borderSide: const BorderSide(color: Colors.white, width: 3),
                             ),
                             disabledBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                               borderSide: const BorderSide(color: Colors.white, width: 3),
                             ),
                             enabledBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                               borderSide: const BorderSide(color: Colors.white, width: 3),
                             ),
                             focusedBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                               borderSide: const BorderSide(color: Colors.white, width: 3),
                             ),
                             suffixIcon: IconButton(
                               icon: const Icon(
                                 Icons.search,
                                 color: Colors.white,
                               ),
                               onPressed: () {},
                             )),
                       ),
                       const SizedBox(
                         height: 15,
                       ),
                       Material(
                         elevation: 10,
                         clipBehavior: Clip.antiAliasWithSaveLayer,
                         borderRadius: BorderRadius.circular(40),
                         child: Container(
                           height: 220,
                           width: double.infinity,
                           decoration: const BoxDecoration(
                             color: Colors.white,
                           ),
                           child: Padding(
                             padding: const EdgeInsets.only(top: 8.0),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Text(cubit.currentWeather?.name??'search for city',
                                     style: TextStyle(
                                       color: Colors.grey[600],
                                       fontSize: 30,
                                     )),
                                 Text(date,
                                     style: TextStyle(
                                       color: Colors.grey[500],
                                       fontSize: 16,
                                     )),
                                 Divider(
                                   color: Colors.grey[200],
                                   thickness: 1,
                                 ),
                                 Expanded(
                                   child: Row(
                                     children: [
                                       Expanded(
                                         child: Column(
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           children: [
                                             Text(cubit.currentWeather?.weather?.description ??'UNKNOWN',
                                                 style: TextStyle(
                                                   color: Colors.grey[500],
                                                   fontSize: 22,
                                                 )),
                                             const SizedBox(
                                               height: 8,
                                             ),
                                              Text(
                                                  cubit.currentWeather?.main?.temp==null? '0\u2103' : '${(cubit.currentWeather!.main!.temp!-272.15).toStringAsFixed(1)}\u2103'
                                                  //'${cubit.currentWeather?.main?.temp ??'0'}\u2103',
                                                 ,style: TextStyle(
                                                   color: Colors.grey[600],
                                                   fontSize: 46,
                                                 )),
                                             Text(
                                                 cubit.currentWeather?.main?.temp_min==null? 'min: 0\u2103/ max: 0\u2103' : 'min: ${(cubit.currentWeather!.main!.temp_min!-272.15).toStringAsFixed(1)}\u2103/ max: ${(cubit.currentWeather!.main!.temp_max!-272.15).toStringAsFixed(1)}\u2103',
                                                 style: TextStyle(
                                                   color: Colors.grey[500],
                                                   fontSize: 12,
                                                 )),
                                           ],
                                         ),
                                       ),
                                       Expanded(
                                           child: Column(
                                             crossAxisAlignment: CrossAxisAlignment.center,
                                             children: [
                                               Expanded(
                                                 child: Stack(
                                                   children: [
                                                     Align(
                                                       alignment:
                                                       cubit.currentWeather?.weather?.main=='Clouds'||cubit.currentWeather?.weather?.main=='Smoke'||cubit.currentWeather?.weather?.main=='Haze'?AlignmentDirectional.topEnd : AlignmentDirectional.center,
                                                       child: Padding(
                                                         padding: const EdgeInsets.only(
                                                             right: 8.0),
                                                         child: Icon(
                                                           Icons.wb_sunny_rounded,
                                                           color: Colors.yellow[600],
                                                           size: 120,
                                                         ),
                                                       ),
                                                     ),
                                                     if(cubit.currentWeather?.weather?.main=='Clouds'||cubit.currentWeather?.weather?.main=='Smoke'||cubit.currentWeather?.weather?.main=='Haze')
                                                     Align(
                                                       alignment:
                                                       AlignmentDirectional.bottomCenter,
                                                       child: Icon(
                                                         Icons.cloud,
                                                         color: Colors.grey[300],
                                                         size: 100,
                                                       ),
                                                     ),
                                                   ],
                                                 ),
                                               ),
                                               Padding(
                                                 padding: const EdgeInsets.only(bottom: 5),
                                                 child: Text(
                                                   'wind ${cubit.currentWeather?.wind?.speed.toString()??'0'} m/s',
                                                   style: TextStyle(
                                                     height: .6,
                                                     fontSize: 14,
                                                     color: Colors.grey[500],
                                                   ),
                                                 ),
                                               )
                                             ],
                                           )),
                                     ],
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ),
                       ),
                       const SizedBox(
                         height: 10,
                       ),
                       const Text(
                         'Other cities',
                         style: TextStyle(
                             color: Colors.grey,
                             fontSize: 18,
                             fontWeight: FontWeight.bold),
                       ),
                       const SizedBox(
                         height: 10,
                       ),
                       Container(
                         height: 140,
                         padding: const EdgeInsets.symmetric(
                           horizontal: 8,
                         ),
                         child: ConditionalBuilder(
                           condition: cubit.otherCities!.isNotEmpty,
                           builder: (BuildContext context) =>ListView.separated(
                             scrollDirection: Axis.horizontal,
                             itemBuilder: (context, index) => buildOtherCities(
                               context: context,
                               name:cubit.otherCities?[index].name??'city',
                               degree:cubit.otherCities?[index].main?.temp==null? '0\u2103' : '${(cubit.otherCities![index].main!.temp!-272.15).toStringAsFixed(1)}\u2103' ,
                               description: cubit.otherCities?[index].weather?.description ??'UNKNOWN',
                             ),
                             separatorBuilder: (context, index) => const SizedBox(
                               width: 20,
                             ),
                             itemCount: cubit.otherCities!.length,
                           ),
                           fallback: (BuildContext context)=> Center(child: CircularProgressIndicator()),
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(top: 8.0),
                         child: Text(
                           'Forecast for next 5 days'.toUpperCase(),
                           style: const TextStyle(
                               color: Colors.grey,
                               fontSize: 20,
                               fontWeight: FontWeight.bold),
                         ),
                       ),
                       SizedBox(
                         width: MediaQuery.of(context).size.width,
                         height: 240,
                         child: Card(
                           elevation: 5,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(15),
                           ),
                           child: SfCartesianChart(

                             primaryXAxis: CategoryAxis(),
                             series: <ChartSeries<SalesData, String>>[
                               SplineSeries<SalesData, String>(
                                 dataSource: data,
                                 xValueMapper: (SalesData f, _) =>
                                 f.day,
                                 yValueMapper: (SalesData f, _) =>
                                 f.degree,
                               ),
                             ],
                           ),
                         ),
                       )
                     ],
                   ),
                 ),
               ),
             ],
           ),
         );
       },
      ),
    );
  }

  Widget buildOtherCities({
  required name,
    required degree,
    required description,
    required context,
}) => Material(
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 140,
          width: 120,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('$name',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  Text('$degree',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  Expanded(
                    child: Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.wb_sunny_rounded,
                              color: Colors.yellow[600],
                              size: 60,
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Icon(
                            Icons.cloud,
                            color: Colors.grey[300],
                            size: 60,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text('$description',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
          ),
      );
}

class SalesData {
  SalesData(this.day,this.degree);
  final String day;
  final num degree;
}


