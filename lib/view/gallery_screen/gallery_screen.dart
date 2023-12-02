import 'package:flutter/material.dart';

import 'package:flutter_application_25/model/note_model.dart';
import 'package:flutter_application_25/utils/color_constant/color_constant.dart';
import 'package:flutter_application_25/view/gallery_screen/widgets/gridview/gridview.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  var imbox = Hive.box<ImageModel>('imageBox');
  List<ImageModel> multiimagelist = [];
  @override
  void initState() {
    multiimagelist = imbox.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Gridview(
        mylist: multiimagelist,
      ),
      floatingActionButton: FloatingActionButton(
          child: Image.asset(
            "assets/icons/camera (3).png",
            color: Colorconstant.primarywhite,
            scale: 20,
          ),
          backgroundColor: Colorconstant.indicatorcolor,
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select Image",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              List<XFile> images =
                                  await picker.pickMultiImage();

                              for (var image in images) {
                                final bytes = await image.readAsBytes();
                                final imageModel =
                                    ImageModel(imageBytes: bytes);
                                imbox.add(imageModel);
                              }
                              setState(() {
                                multiimagelist = imbox.values.toList();
                              });

                              Navigator.pop(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "From gallery",
                                  style: TextStyle(fontSize: 14),
                                ),
                                Image.asset(
                                  "assets/icons/gallery.png",
                                  color: Colorconstant.indicatorcolor,
                                  scale: 20,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? photo = await picker.pickImage(
                                  source: ImageSource.camera);
                              if (photo != null) {
                                final bytes = await photo.readAsBytes();
                                final imageModel =
                                    ImageModel(imageBytes: bytes);
                                imbox.add(imageModel);
                                Navigator.pop(context);
                              }

                              setState(() {
                                multiimagelist = imbox.values.toList();
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "From camera",
                                  style: TextStyle(fontSize: 14),
                                ),
                                Image.asset(
                                  "assets/icons/camera (2).png",
                                  color: Colorconstant.indicatorcolor,
                                  scale: 20,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ));
          }),
    );
  }
}
