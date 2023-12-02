import 'package:flutter/material.dart';
import 'package:flutter_application_25/utils/color_constant/color_constant.dart';
import 'package:flutter_application_25/view/all_screen/all_screen.dart';
import 'package:flutter_application_25/view/home_screen/home_screen.dart';

class ViewCard extends StatelessWidget {
  const ViewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colorconstant.Agrey,
        elevation: 0,
        title: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ));
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colorconstant.primaryblack,
            size: 34,
          ),
        ),
      ),
    );
  }
}
