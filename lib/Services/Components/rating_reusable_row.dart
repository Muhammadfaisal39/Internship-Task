import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RattingRow extends StatelessWidget {
  final String rating;
  const RattingRow({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          rating,
          style: const TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 10.w,),
        const Icon(Icons.star,color: Colors.yellow,size: 20,),
        const Icon(Icons.star,color: Colors.yellow,size: 20,),
        const Icon(Icons.star,color: Colors.yellow,size: 20,),
        const Icon(Icons.star,color: Colors.yellow,size: 20,),
        const Icon(Icons.star,color: Colors.yellow,size: 20,),
      ],
    );
  }
}
