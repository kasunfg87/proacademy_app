part of 'objects.dart';

@JsonSerializable()
class CourseModel {
  final String category;
  // ignore: non_constant_identifier_names
  final int course_id;
  final String? description;
  final String? img;
  final String? instructor;
  final String? title;
  final String? lesson;
  final String? duration;
  final String? price;

  CourseModel(
      {required this.category,
      // ignore: non_constant_identifier_names
      required this.course_id,
      required this.description,
      required this.img,
      required this.instructor,
      required this.title,
      required this.lesson,
      required this.duration,
      required this.price});

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseModelToJson(this);
}
