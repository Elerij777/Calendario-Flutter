import 'package:get/get.dart';
import 'package:notification_app/db/db_helper.dart';
import 'package:notification_app/models/task.dart';

class TaskControllers extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }
}
