import 'package:flutter/material.dart';

class MyTestScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(decoration: BoxDecoration(border: Border.all())),
          Image.asset("assets/images/eggs_avocado_toast.jpg", width: 100),
          Image.network("https://picsum.photos/id/58/120"),
        ],
      ),
    );
  }
}
