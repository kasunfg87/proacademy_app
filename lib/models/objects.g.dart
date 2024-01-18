// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'objects.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => CourseModel(
      category: json['category'] as String,
      course_id: json['course_id'] as int,
      description: json['description'] as String?,
      img: json['img'] as String?,
      instructor: json['instructor'] as String?,
      title: json['title'] as String?,
      lesson: json['lesson'] as String?,
      duration: json['duration'] as String?,
      price: json['price'] as String?,
    );

Map<String, dynamic> _$CourseModelToJson(CourseModel instance) =>
    <String, dynamic>{
      'category': instance.category,
      'course_id': instance.course_id,
      'description': instance.description,
      'img': instance.img,
      'instructor': instance.instructor,
      'title': instance.title,
      'lesson': instance.lesson,
      'duration': instance.duration,
      'price': instance.price,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['uid'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['birthDay'] as String,
      json['age'] as int,
      json['gender'] as String,
      json['mobile'] as String,
      json['address'] as String,
      json['school'] as String,
      json['img'] as String?,
      json['lastSeen'] as String?,
      json['isOnline'] as bool?,
      json['token'] as String? ?? '',
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'birthDay': instance.birthDay,
      'age': instance.age,
      'gender': instance.gender,
      'mobile': instance.mobile,
      'address': instance.address,
      'school': instance.school,
      'img': instance.img,
      'lastSeen': instance.lastSeen,
      'isOnline': instance.isOnline,
      'token': instance.token,
    };

EnrolledModel _$EnrolledModelFromJson(Map<String, dynamic> json) =>
    EnrolledModel(
      json['course_id'] as int,
      json['status'] as String,
      json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      json['last_update'] as String,
    );

Map<String, dynamic> _$EnrolledModelToJson(EnrolledModel instance) =>
    <String, dynamic>{
      'course_id': instance.course_id,
      'status': instance.status,
      'user': instance.user?.toJson(),
      'last_update': instance.last_update,
    };

BookmarkModel _$BookmarkModelFromJson(Map<String, dynamic> json) =>
    BookmarkModel(
      category: json['category'] as String,
      course_id: json['course_id'] as int,
      title: json['title'] as String,
      uid: json['uid'] as String,
    );

Map<String, dynamic> _$BookmarkModelToJson(BookmarkModel instance) =>
    <String, dynamic>{
      'category': instance.category,
      'course_id': instance.course_id,
      'title': instance.title,
      'uid': instance.uid,
    };

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      category: json['category'] as String?,
      category_name: json['category_name'] as String?,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'category': instance.category,
      'category_name': instance.category_name,
    };

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      json['conId'] as String,
      json['senderName'] as String,
      json['senderId'] as String,
      json['receiverId'] as String,
      json['message'] as String,
      json['messageTime'] as String,
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'conId': instance.conId,
      'senderName': instance.senderName,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'message': instance.message,
      'messageTime': instance.messageTime,
    };

ConversationModel _$ConversationModelFromJson(Map<String, dynamic> json) =>
    ConversationModel(
      json['id'] as String,
      (json['users'] as List<dynamic>).map((e) => e as String).toList(),
      (json['userArray'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['lastMassage'] as String,
      json['lastMassageTime'] as String,
      json['createdBy'] as String,
    );

Map<String, dynamic> _$ConversationModelToJson(ConversationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'users': instance.users,
      'userArray': instance.userArray.map((e) => e.toJson()).toList(),
      'lastMassage': instance.lastMassage,
      'lastMassageTime': instance.lastMassageTime,
      'createdBy': instance.createdBy,
    };
