import 'package:get/get.dart';
import 'package:to_do_app/db/db_helper.dart';

import '../models/task.dart';

class TaskController extends GetxController{
@override
  void onReady() {
    super.onReady();
  }
  var taskList=<Task>[].obs;
  Future<int> addTask({required Task task}) async{
    return await DbHelper().insert(task);

  }
  getTasks() async{
    List<Map<String,dynamic>> tasks=await DbHelper().getTasks();
    //taskList=tasks.map((e) => Task.mapToList(e)).toList();
    taskList.assignAll(tasks.map((e) => Task.mapToList(e)).toList());
    print(taskList.length);
  }

  delete({required Task task}) async{
    var x=await DbHelper().delete(task);
  }
  upgrade({required Task task}) async{
    var x=await DbHelper().update(task);
  }
}