part of 'objects.dart';

@JsonSerializable()
class BookmarkModel {
  final String category;
  // ignore: non_constant_identifier_names
  final int course_id;
  final String title;
  final String uid;

  BookmarkModel({
    required this.category,
    // ignore: non_constant_identifier_names
    required this.course_id,
    required this.title,
    required this.uid,
  });

  factory BookmarkModel.fromJson(Map<String, dynamic> json) =>
      _$BookmarkModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookmarkModelToJson(this);
}
