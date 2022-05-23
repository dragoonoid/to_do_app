import 'package:get/get.dart';
import 'package:to_do_app/db/db_helper.dart';

import '../models/task.dart';

class TaskController extends GetxController{
@override
  void onReady() {
    super.onReady();
  }

  Future<int> addTask({required Task task}) async{
    return await DbHelper().insert(task);
  }
}