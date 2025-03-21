import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Note {
  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  @HiveField(2)
  String category;

  @HiveField(3)
  DateTime date;

  Note({
    required this.title,
    required this.content,
    required this.category,
    required this.date,
  });
}
