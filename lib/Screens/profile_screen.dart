import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/Services/Components/reusable_row_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 70, left: 10, right: 10),
        child: Column(
          children: [
            Center(
              child: Text(
                "Mitt konto",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24.sp,
                  fontFamily: "Playfair Display",
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20.h,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 05),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(05),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                  ),
                  title: Text("My Name",style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.white
                  ),),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("myemail@gmail.com",style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          color: Colors.white
                      ),),
                      Text("0XXXXXXX",style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          color: Colors.white
                      ),)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 80.h,),
            ReusableRowProfile(icon: Icons.settings, title: "Kontoinstallningar"),
            SizedBox(height: 25.h,),
            ReusableRowProfile(icon: Icons.video_stable_rounded, title: "Mina betalmetoder"),
            SizedBox(height: 25.h,),
            ReusableRowProfile(icon: Icons.support, title: "Support"),
          ],
        ),
      ),
    );
  }
}
