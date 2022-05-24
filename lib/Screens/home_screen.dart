import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:to_do_app/services/notification_services.dart';
import 'package:to_do_app/services/theme_services.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/widgets/addtask_button.dart';
import 'package:to_do_app/widgets/task_tile.dart';

import '../controller/task_controller.dart';
import '../models/task.dart';
import 'addTaskPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _date = DateTime.now();
  var notifyHelper;
  late TaskController taskController;
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();

    taskController = Get.put(TaskController());
    taskController.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: _appBar(),
      body: Column(
        children: [
          _firstBar(),
          _selectDate(),
          const SizedBox(height: 10),
          _showTasks()
        ],
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
          itemBuilder: (context, i) {
            Task t = taskController.taskList[i];
            if (t.repeat == 'Daily') {
              return AnimationConfiguration.staggeredList(
                position: i,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showTaskBar(i);
                          },
                          child: TaskTile(t),
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else if (t.date == DateFormat.yMd().format(_date)) {
              return AnimationConfiguration.staggeredList(
                position: i,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showTaskBar(i);
                          },
                          child: TaskTile(t),
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
          itemCount: taskController.taskList.length,
        );
      }),
    );
  }

  _showTaskBar(int i) {
    Get.bottomSheet(Container(
      color:
          ThemeServices().theme == ThemeMode.dark ? Colors.black : Colors.white,
      //width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              taskController.taskList[i].isCompleted =
                  taskController.taskList[i].isCompleted == 0 ? 1 : 0;
              await taskController.upgrade(task: taskController.taskList[i]);
              await taskController.getTasks();
              Get.back();
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  taskController.taskList[i].isCompleted == 0
                      ? 'Task Completed'
                      : 'Revert Task Completed',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () async {
              await taskController.delete(task: taskController.taskList[i]);
              await taskController.getTasks();
              Get.back();
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text(
                  'Delete task',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  _selectDate() {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: Colors.purple,
        selectedTextColor: Colors.white,
        //deactivatedColor: ThemeServices().theme==ThemeMode.dark?Colors.white:Colors.black,
        dateTextStyle: const TextStyle(color: Colors.grey, fontSize: 20),
        monthTextStyle: const TextStyle(color: Colors.grey, fontSize: 12),
        dayTextStyle: const TextStyle(color: Colors.grey, fontSize: 12),
        onDateChange: (date) {
          setState(() {
            _date = date;
          });
        },
      ),
    );
  }

  _firstBar() {
    return Container(
      //color: Theme.of(context).primaryColor,
      margin: const EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: TextStyle(
                  fontSize: 20,
                  color: ThemeServices().theme == ThemeMode.dark
                      ? Colors.grey[400]
                      : Colors.grey,
                ),
              ),
              const Text(
                'Today',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          AddTaskButton(
              text: '+Add Task',
              ontap: () async {
                await Get.to(() => const AddTaskPage());
                taskController.getTasks();
              }),
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          ThemeServices().switchTheme();
          notifyHelper.displayNotification(
            title: 'Theme Changed',
            body: ThemeServices().theme == ThemeMode.dark ? "Dark" : "Light",
          );
          notifyHelper.scheduledNotification();
        },
        child: Icon(
          Icons.nightlight_round,
          size: 20,
          color: ThemeServices().theme == ThemeMode.dark
              ? Colors.white
              : Colors.black,
        ),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('images/person.png'),
        ),
        SizedBox(width: 20),
      ],
    );
  }
}
