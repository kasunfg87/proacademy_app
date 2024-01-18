import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_app/models/objects.dart';

class CategoryController {
  CollectionReference categorys =
      FirebaseFirestore.instance.collection('course_category');

  // ----- fetch courses

  Future<List<CategoryModel>> getCategorys() async {
    try {
      // ----- query for fetching all the coureses list

      QuerySnapshot snapshot = await categorys.get();

      // ----- courses list

      List<CategoryModel> list = [];

      // ----- mapping fetch data to course model and store then in coures list

      for (var element in snapshot.docs) {
        // ----- mapping to a single coures model
        CategoryModel model =
            CategoryModel.fromJson(element.data() as Map<String, dynamic>);
        // ----- adding to list
        list.add(model);
      }

      // return the courses list
      return list;
    } catch (e) {
      // ignore: avoid_print
      Logger().e(e);
      return [];
    }
  }
}
