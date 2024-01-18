part of 'objects.dart';

@JsonSerializable()
class CategoryModel {
  final String? category;
  // ignore: non_constant_identifier_names
  final String? category_name;

  // ignore: non_constant_identifier_names
  CategoryModel({required this.category, required this.category_name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
