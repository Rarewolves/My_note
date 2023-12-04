import 'package:flutter/material.dart';
import 'package:flutter_application_25/model/note_model.dart';
import 'package:flutter_application_25/utils/color_constant/color_constant.dart';

import 'package:flutter_application_25/view/home_screen/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ViewCard extends StatefulWidget {
  ViewCard({super.key, required this.cardlist, required this.Index});

  List cardlist;
  int Index;

  @override
  State<ViewCard> createState() => _ViewCardState();
}

class _ViewCardState extends State<ViewCard> {
  var box = Hive.box<NoteModel>('noteBox');

  @override
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          Color(box.get(widget.cardlist[widget.Index])?.color ?? 0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Colorconstant.Agrey,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (
                    context,
                  ) =>
                      HomeScreen(),
                ));
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colorconstant.primaryblack,
            size: 28,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                box.get(widget.cardlist[widget.Index])?.title ?? "",
                style: TextStyle(
                    fontSize: 18,
                    color: Colorconstant.primaryblack,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                box.get(widget.cardlist[widget.Index])?.description ?? "",
                style: TextStyle(
                  fontSize: 15,
                  color: Colorconstant.primaryblack,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    box.get(widget.cardlist[widget.Index])?.date ?? "",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colorconstant.primaryblack,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    box.get(widget.cardlist[widget.Index])?.picktime ?? "",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colorconstant.primaryblack,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
