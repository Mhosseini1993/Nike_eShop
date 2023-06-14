import 'package:flutter/material.dart';
import 'package:nike/AppThemeConfig.dart';
import 'package:nike/Data/Context/DataBaseContext.dart';
import 'package:nike/Screens/Login/AuthScreen.dart';

void main() async {
  await DataBaseContext.initDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nike EShop',
      debugShowCheckedModeBanner: false,
      theme: AppThemeConfig.Light().GetAppTheme(),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: AuthScreen(), //ShippingScreen(),
      ),
    );
  }
}
