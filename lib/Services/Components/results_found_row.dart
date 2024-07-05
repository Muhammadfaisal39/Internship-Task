import 'package:flutter/material.dart';

class ResultsFound extends StatelessWidget {
  final String number;
  const ResultsFound({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text("$number ",style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: "Poppins",
              fontSize: 10,
              color: Colors.grey
          ),),
          const Text("results found",style: TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: "Poppins",
              fontSize: 10,
              color: Colors.grey
          ),)
        ],
      ),
    );
  }
}
