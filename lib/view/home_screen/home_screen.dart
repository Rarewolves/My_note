import 'package:flutter/material.dart';

import 'package:flutter_application_25/utils/color_constant/color_constant.dart';
import 'package:flutter_application_25/view/all_screen/all_screen.dart';
import 'package:flutter_application_25/view/calendar_screen/calendar_screen.dart';
import 'package:flutter_application_25/view/gallery_screen/gallery_screen.dart';

import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colorconstant.Lwhite,
        appBar: AppBar(
          backgroundColor: Colorconstant.Agrey,
          elevation: 0,
          toolbarHeight: 80,
          title: Row(
            children: [
              Text("My Notes",
                  style: GoogleFonts.balooDa2(
                      color: Colorconstant.primaryblack,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                width: 15,
              ),
              Image.asset(
                "assets/icons/notes.png",
                scale: 12,
                color: Colorconstant.primaryblack,
              )
            ],
          ),
          bottom: TabBar(indicatorColor: Colorconstant.indicatorcolor, tabs: [
            Tab(
              child: Text(
                "Notes",
                style: GoogleFonts.ibmPlexSans(
                    color: Colorconstant.primaryblack,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Tab(
              child: Text(
                "Gallery",
                style: GoogleFonts.ibmPlexSans(
                    color: Colorconstant.primaryblack,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Tab(
              child: Text(
                "Calendar",
                style: GoogleFonts.ibmPlexSans(
                    color: Colorconstant.primaryblack,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ]),
        ),
        body: TabBarView(children: [
          AllScreen(),
          GalleryScreen(),
          CalendarScreen(),
        ]),
      ),
    );
  }
}
