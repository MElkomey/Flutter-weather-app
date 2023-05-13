import 'package:flutter/material.dart';
import 'package:weather_app/modules/home_screen/home.dart';
import 'package:weather_app/shared/network/remote/dio_helper.dart';

void main()
//async
{
  // WidgetsFlutterBinding.ensureInitialized();
  // await
  DioHelper.init();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  );
  }


}

