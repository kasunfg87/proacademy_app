part of 'objects.dart';

@JsonSerializable()
class UserModel {
  final String uid;
  final String firstName;
  final String lastName;
  final String birthDay;
  final int age;
  final String gender;
  final String mobile;
  final String address;
  final String school;
  String? img;
  String? lastSeen;
  bool? isOnline;
  @JsonKey(defaultValue: "")
  String token;

  UserModel(
      this.uid,
      this.firstName,
      this.lastName,
      this.birthDay,
      this.age,
      this.gender,
      this.mobile,
      this.address,
      this.school,
      this.img,
      this.lastSeen,
      this.isOnline,
      this.token);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
