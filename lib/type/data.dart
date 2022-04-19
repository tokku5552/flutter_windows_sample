import 'package:hive/hive.dart';

part 'data.g.dart';

@HiveType(typeId: 1)
class Data {
  @HiveField(0)
  String title;

  @HiveField(1)
  List<String> list;

  Data({required this.title, required this.list});
}
