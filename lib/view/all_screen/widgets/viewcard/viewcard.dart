import 'package:flutter/material.dart';
import 'package:flutter_application_25/model/note_model.dart';
import 'package:flutter_application_25/utils/color_constant/color_constant.dart';

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
    return Container(
      color: Color(box.get(widget.cardlist[widget.Index])?.color ?? 0xFFFFFFFF),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 80, left: 15, right: 15, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        box.get(widget.cardlist[widget.Index])?.title ?? "",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colorconstant.primaryblack,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.justify,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {});
                        },
                        child: Image.asset(
                          "assets/icons/close.png",
                          color: Colorconstant.indicatorcolor,
                          scale: 25,
                        ),
                      )
                    ],
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
        ],
      ),
    );
  }
}
