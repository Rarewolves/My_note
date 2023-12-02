import 'package:flutter/material.dart';
import 'package:flutter_application_25/model/note_model.dart';
import 'package:flutter_application_25/utils/color_constant/color_constant.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class BottomsheetScreen extends StatefulWidget {
  BottomsheetScreen(
      {super.key,
      this.onItemAdded,
      this.edittitle,
      this.editdes,
      this.editlist,
      this.editindex,
      this.onItemedited,
      this.editdate,
      this.edittime});
  final Function()? onItemAdded;
  final Function(NoteModel)? onItemedited;
  String? edittitle;
  String? editdes;
  List? editlist;
  int? editindex;
  String? editdate;
  String? edittime;
  @override
  State<BottomsheetScreen> createState() => _BottomsheetScreenState();
}

class _BottomsheetScreenState extends State<BottomsheetScreen> {
  var box = Hive.box<NoteModel>('noteBox');
  final namecontroller = TextEditingController();
  final descriptionscontroller = TextEditingController();
  final datecontroller = TextEditingController();
  final timecontroller = TextEditingController();
  int selectedindex = 0;
  TimeOfDay selectedTime = TimeOfDay.now();
  final DateFormat timeFormat = DateFormat.Hm();
  @override
  void initState() {
    namecontroller.text = widget.edittitle ?? "";
    descriptionscontroller.text = widget.editdes ?? "";
    datecontroller.text = widget.editdate ?? "";
    timecontroller.text = widget.edittime ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding: mediaQueryData.viewInsets,
      child: StatefulBuilder(
        builder: (context, insetState) => Container(
          height: 500,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextFormField(
                        onChanged: (value) {
                          widget.edittitle = value;
                        },
                        controller: namecontroller,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Title'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextFormField(
                        onChanged: (value) {
                          widget.editdes = value;
                        },
                        maxLines: 10,
                        controller: descriptionscontroller,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Descriptions'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextFormField(
                        onChanged: (value) {
                          widget.editdate = value;
                        },
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickeddate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100));
                          if (pickeddate != null) {
                            setState(() {
                              datecontroller.text =
                                  DateFormat("yyyy-MM-dd").format(pickeddate);
                            });
                          }
                        },
                        controller: datecontroller,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Choose date'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextFormField(
                        onChanged: (value) {
                          widget.edittime = value;
                        },
                        readOnly: true,
                        onTap: () async {
                          TimeOfDay? pickedtime = await showTimePicker(
                              context: context, initialTime: selectedTime);
                          if (pickedtime != null) {
                            setState(() {
                              timecontroller.text = timeFormat.format(DateTime(
                                  2023,
                                  1,
                                  1,
                                  pickedtime.hour,
                                  pickedtime.minute));
                            });
                          }
                        },
                        controller: timecontroller,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Choose time'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          ColorConstant.mycolorlist.length,
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    insetState(() {});
                                    selectedindex = index;
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: ColorConstant.mycolorlist[index]
                                            .withOpacity(0.6),
                                        border: selectedindex == index
                                            ? Border.all(
                                                color: ColorConstant
                                                    .mycolorlist[index],
                                                width: 5)
                                            : null),
                                  ),
                                ),
                              )),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.pink)),
                      onPressed: () {
                        if (widget.editindex != null) {
                          final updateNote = NoteModel(
                            title: namecontroller.text.trim(),
                            description: descriptionscontroller.text.trim(),
                            date: datecontroller.text.trim(),
                            color:
                                ColorConstant.mycolorlist[selectedindex].value,
                            picktime: timecontroller.text.trim(),
                          );

                          widget.onItemedited?.call(updateNote);
                        } else {
                          box.add(
                            NoteModel(
                                picktime: timecontroller.text.trim(),
                                title: namecontroller.text.trim(),
                                description: descriptionscontroller.text.trim(),
                                date: datecontroller.text.trim(),
                                color: ColorConstant
                                    .mycolorlist[selectedindex].value),
                          );
                        }
                        namecontroller.clear();
                        descriptionscontroller.clear();
                        datecontroller.clear();
                        setState(() {});
                        widget.onItemAdded?.call();
                        Navigator.pop(context);
                      },
                      child: Text("Save")),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
