import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusableRowProfile extends StatelessWidget {
  IconData icon;
  final String title;
  ReusableRowProfile({super.key,required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 25.w,),
          Text(title,style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: "Poppins"
          ),),
        ],
      ),
    );
  }
}
