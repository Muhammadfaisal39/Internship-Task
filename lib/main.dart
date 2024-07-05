import'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/Services/add_to_favourite_services/favourite_provider.dart';
import 'package:internship_task/Screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main(){
   runApp(ChangeNotifierProvider(
     create: (context) => FavoritesProvider(),
     child: const MyApp(),
   ),);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: const Size(375, 812), // Example design size (width, height)
      minTextAdapt: true, // Ensures text scales down for smaller screens
      splitScreenMode: true, // Allows for better handling of split screens
      builder: (context, child) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Internship Task',
        home: SplashScreen(),
      ),
    );
  }
}
