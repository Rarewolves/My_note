import 'package:flutter/material.dart';
import 'package:flutter_application_25/model/note_model.dart';

import 'package:flutter_application_25/utils/color_constant/color_constant.dart';
import 'package:flutter_application_25/view/all_screen/widgets/viewcard/viewcard.dart';
import 'package:flutter_application_25/view/home_screen/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:share/share.dart';

class AllScreen extends StatefulWidget {
  AllScreen({
    super.key,
  });

  @override
  State<AllScreen> createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  var box = Hive.box<NoteModel>('noteBox');
  List modellist = [];
  @override
  void initState() {
    modellist = box.keys.toList();
    super.initState();
  }

  int editIndex = 0;
  String edittit = "";
  String editdes = "";
  String editdate = "";
  String edittime = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MasonryGridView.builder(
        itemCount: modellist.length,
        gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
        ),
        itemBuilder: (context, index) {
          final key = modellist[index];
          final note = box.get(key);
          return Padding(
            padding: const EdgeInsets.all(20),
            child: InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewCard(
                      Index: index,
                      cardlist: modellist,
                    ),
                  ),
                  (route) => false,
                );
              },
              child: Container(
                padding: EdgeInsets.all(2),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 20,
                  color: Color(note?.color ?? 0xFFFFFFFF),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          note?.title ?? "",
                          style: GoogleFonts.balooDa2(
                              color: Colorconstant.primaryblack,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          note?.description ?? "",
                          style: GoogleFonts.balooDa2(
                            color: Colorconstant.primaryblack,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              note?.date ?? "",
                              style: GoogleFonts.balooDa2(
                                  color: Colorconstant.Ablack,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.justify,
                            ),
                            Text(
                              note?.picktime ?? "",
                              style: GoogleFonts.balooDa2(
                                  color: Colorconstant.Ablack,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (note != null) {
                                  Share.share(
                                      "${note.title}\n${note.description}\n${note.date}");
                                }
                              },
                              icon: Image.asset(
                                "assets/icons/share (1).png",
                                scale: 22,
                                color: Colorconstant.Egrey,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    editIndex = index;
                                    editdate = note?.date ?? "";
                                    edittime = note?.picktime ?? "";
                                    edittit = note?.title ?? "";
                                    editdes = note?.description ?? "";
                                    setState(() {});
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(25))),
                                        elevation: 0,
                                        backgroundColor: Colors.grey.shade500,
                                        context: context,
                                        builder: (context) => BottomsheetScreen(
                                              editdes: editdes,
                                              edittitle: edittit,
                                              editdate: editdate,
                                              edittime: edittime,
                                              editlist: modellist,
                                              editindex: editIndex,
                                              onItemedited: (updatedNote) {
                                                final existingNote = box
                                                    .get(modellist[editIndex]);
                                                if (existingNote != null) {
                                                  existingNote.title =
                                                      updatedNote.title;
                                                  existingNote.description =
                                                      updatedNote.description;
                                                  existingNote.date =
                                                      updatedNote.date;
                                                  existingNote.picktime =
                                                      updatedNote.picktime;
                                                  existingNote.color =
                                                      updatedNote.color;

                                                  box.put(modellist[editIndex],
                                                      existingNote);
                                                  setState(() {
                                                    modellist =
                                                        box.keys.toList();
                                                  });
                                                }
                                              },
                                            ));
                                  },
                                  icon: Image.asset(
                                    "assets/icons/pencil.png",
                                    scale: 24,
                                    color: Colorconstant.Egrey,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                IconButton(
                                  onPressed: () {
                                    box.delete(modellist[index]);
                                    setState(() {});
                                    modellist = box.keys.toList();
                                  },
                                  icon: Image.asset(
                                    "assets/icons/delete (1).png",
                                    scale: 20,
                                    color: Colorconstant.Egrey,
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          Icons.add,
          color: Colorconstant.primarywhite,
          size: 25,
        ),
        label: Text(
          "Add notes",
          style: TextStyle(
            color: Colorconstant.primarywhite,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colorconstant.indicatorcolor,
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25))),
              elevation: 0,
              backgroundColor: Colors.grey.shade500,
              context: context,
              builder: (context) => BottomsheetScreen(
                    onItemAdded: () {
                      setState(() {
                        modellist = box.keys.toList();
                      });
                    },
                  ));
        },
      ),
    );
  }
}
