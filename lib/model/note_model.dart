import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 1)
class NoteModel {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? description;
  @HiveField(2)
  String? date;
  @HiveField(3)
  int? color;
  @HiveField(4)
  String? picktime;
 

  NoteModel(
      {this.title,
      this.description,
      this.date,
      this.color,
      this.picktime,
      });
}
@HiveType(typeId: 2)
class ImageModel {
  @HiveField(0)
  List<int> imageBytes;
  ImageModel({required this.imageBytes});
}
