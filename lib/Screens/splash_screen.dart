import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/Services/Components/BottomNavBar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    // TODO: implement initState
    Timer(const Duration(seconds: 03), () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const BottomNavBar()));
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: const Image(
              fit: BoxFit.cover,
              image: AssetImage('Assets/images/background.jpeg'),
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 90),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(child: Text("My Store", style: TextStyle(
                  fontFamily: "Playfair Display",
                  fontWeight: FontWeight.w400,
                  fontSize: 50.sp
                ),)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 38),
                  child: Column(
                    children: [
                      Center(child: Text("Valkommen", style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: Colors.white
                      ),)),
                      SizedBox(height: 10.h,),
                      Center(child: Text("Hos ass kan du baka tid has nastan alla Sveriges salonger och motagningar. Baka frisor, massage, skonhetsbehandingar, friskvard och mycket mer.", style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: Colors.white
                      ),textAlign: TextAlign.center,))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
