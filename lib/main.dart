import 'package:drawmoneyadmin/Helper/Colors.dart';
import 'package:flutter/material.dart';

import 'Screen/spalashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Draw Money Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
        ),
        scaffoldBackgroundColor: AppColors.bgColor,
        textTheme: const TextTheme(
          bodySmall: TextStyle(fontFamily: 'Gilroy'),
          bodyLarge: TextStyle(fontFamily: 'Gilroy'),
          bodyMedium: TextStyle(fontFamily: 'Gilroy'),
          displayLarge: TextStyle(fontFamily: 'Gilroy'),
          displayMedium: TextStyle(fontFamily: 'Gilroy'),
          displaySmall: TextStyle(fontFamily: 'Gilroy'),
        ),
      ),
      home: SpalashLogo(),
    );
  }
}
