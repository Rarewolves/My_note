import 'dart:typed_data';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_25/model/note_model.dart';

import 'package:flutter_application_25/utils/color_constant/color_constant.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

class Gridview extends StatefulWidget {
  Gridview({
    super.key,
    required this.mylist,
  });
  final List mylist;

  @override
  State<Gridview> createState() => _GridviewState();
}

class _GridviewState extends State<Gridview> {
  var imbox = Hive.box<ImageModel>('imageBox');

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
        itemCount: widget.mylist.length,
        gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(5),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                          color: Colorconstant.dropcolor,
                          borderRadius: BorderRadius.circular(12))),
                  onChanged: (value) {
                    setState(() {});
                  },
                  customButton: InstaImageViewer(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.memory(
                        Uint8List.fromList(
                          widget.mylist[index].imageBytes,
                        ),
                      ),
                    ),
                  ),
                  openWithLongPress: true,
                  items: [
                    DropdownMenuItem(
                        child: SingleChildScrollView(
                      child: DropdownMenuItem(
                          child: InkWell(
                        onTap: () {
                          imbox.deleteAt(index);
                          setState(() {
                            widget.mylist.removeAt(index);
                          });
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colorconstant.indicatorcolor,
                            ),
                            Text("delete"),
                          ],
                        ),
                      )),
                    )),
                  ],
                ),
              ));
        });
  }
}
