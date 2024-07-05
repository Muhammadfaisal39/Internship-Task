import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ReusableRow extends StatelessWidget {
  final String title;
  final String value;

  const ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$title:",style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          fontFamily: "Poppins",
        ),),
        SizedBox(width: 08.w,),
        Text(value,style: const TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.w400,
          fontSize: 10
        ),)

      ],
    );
  }
}
