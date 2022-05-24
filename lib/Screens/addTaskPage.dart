import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/controller/task_controller.dart';
import 'package:to_do_app/widgets/addtask_button.dart';
import 'package:to_do_app/widgets/inputFieldTaskPage.dart';

import '../models/task.dart';
import '../services/theme_services.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  //get notifyHelper => null;
  var dateSelected = DateTime.now();
  final _contName = TextEditingController();
  final _contNote = TextEditingController();
  final _contDate = TextEditingController();
  final _contStartTime = TextEditingController();
  final _contEndTime = TextEditingController();
  final _contRemind = TextEditingController();
  final _contRepeat = TextEditingController();

  String startTime = "9:00 AM";
  String endTime = "9:00 PM";
  int _selectedRemind = 5;
  List<int> remind = [5, 10, 15, 20];
  int tick = 0;

  String _selectedRepeat = 'Daily';
  List<String> repeat = ['Daily', 'Only Once'];

  final TaskController taskController = Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 16),
              child: const Text(
                'Add Task',
                style: TextStyle(
                    //color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            InputFieldTaskPage(
              title: 'Title',
              hint: 'Enter title name',
              controller: _contName,
              widgt: null,
              size: 0.88,
            ),
            InputFieldTaskPage(
              title: 'Note',
              hint: 'Write your note here',
              controller: _contNote,
              widgt: null,
              size: 0.88,
            ),
            InputFieldTaskPage(
              title: 'Date',
              hint: DateFormat.yMd().format(dateSelected),
              controller: _contDate,
              widgt: IconButton(
                onPressed: () {
                  _getDate();
                },
                icon: const Icon(Icons.calendar_today),
              ),
              size: 0.88,
            ),
            Row(
              children: [
                InputFieldTaskPage(
                  title: 'Start Time',
                  hint: startTime,
                  controller: _contStartTime,
                  widgt: IconButton(
                    onPressed: () {
                      _getTime(true);
                    },
                    icon: const Icon(Icons.calendar_today),
                  ),
                  size: 0.4,
                ),
                InputFieldTaskPage(
                  title: 'End Time',
                  hint: endTime,
                  controller: _contEndTime,
                  widgt: IconButton(
                    onPressed: () {
                      _getTime(false);
                    },
                    icon: const Icon(Icons.calendar_today),
                  ),
                  size: 0.4,
                ),
              ],
            ),
            InputFieldTaskPage(
              title: 'Remind',
              hint: '$_selectedRemind minutes early',
              controller: _contRemind,
              size: 0.88,
              widgt: DropdownButton(
                items: remind.map<DropdownMenuItem<String>>((int x) {
                  return DropdownMenuItem(
                    value: x.toString(),
                    child: Text(x.toString()),
                  );
                }).toList(),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),
                iconSize: 32,
                elevation: 4,
                underline: Container(height: 0),
                onChanged: (String? s) {
                  setState(() {
                    _selectedRemind = int.parse(s!);
                  });
                },
              ),
            ),
            InputFieldTaskPage(
              title: 'Repeat',
              hint: _selectedRepeat,
              controller: _contRepeat,
              size: 0.88,
              widgt: DropdownButton(
                items: repeat.map<DropdownMenuItem<String>>((String x) {
                  return DropdownMenuItem(
                    value: x,
                    child: Text(x),
                  );
                }).toList(),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),
                iconSize: 32,
                elevation: 4,
                underline: Container(height: 0),
                onChanged: (String? s) {
                  setState(() {
                    _selectedRepeat = s!;
                  });
                },
              ),
            ),
            const SizedBox(height: 5),
            Container(
              margin: const EdgeInsets.only(left: 16, right: 30, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Color',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                tick = 0;
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.blue[800],
                              radius: 14,
                              child: tick == 0
                                  ? const Icon(Icons.check)
                                  : const SizedBox(),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                tick = 1;
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.pink,
                              radius: 14,
                              child: tick == 1
                                  ? const Icon(Icons.check)
                                  : const SizedBox(),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                tick = 2;
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.yellowAccent,
                              radius: 14,
                              child: tick == 2
                                  ? const Icon(Icons.check)
                                  : const SizedBox(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  AddTaskButton(
                      text: 'Submit',
                      ontap: () async{
                        await _validate();
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _addToDb() async {
    int x=await taskController.addTask(task: Task(
      note: _contNote.text,
      title: _contName.text,
      date: DateFormat.yMd().format(dateSelected),
      startTime: startTime,
      endTime: endTime,
      remind: _selectedRemind,
      repeat: _selectedRepeat,
      color: tick,
      isCompleted: 0,
    ));
    print('id is $x');
    await taskController.getTasks();
  }

  _validate()async {
    if (_contName.text.isNotEmpty && _contNote.text.isNotEmpty) {
      print(_contName.text);
      print(_contNote.text);

      await _addToDb();

      Get.back();
    } else {
      Get.snackbar('Failure', 'Please enter all fields correctly');
    }
  }

  _getTime(bool startBool) async {
    var x = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 9, minute: 10),
    );
    var formattedTime = x?.format(context);
    if (x == null) {
      print('no time selected');
    } else if (startBool == true && formattedTime != null) {
      setState(() {
        startTime = formattedTime;
      });
    } else if (formattedTime != null) {
      setState(() {
        endTime = formattedTime;
      });
    }
  }

  _getDate() async {
    var x = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (x != null) {
      setState(() {
        dateSelected = x;
      });
    } else {}
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.exit_to_app,
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
