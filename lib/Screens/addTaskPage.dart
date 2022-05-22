import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/widgets/inputFieldTaskPage.dart';

import '../services/theme_services.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  //get notifyHelper => null;
  var dateSelected = DateTime.now();
  var _contName = TextEditingController();
  String startTime = "9:00 AM";
  String endTime = "9:00 PM";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              controller: _contName,
              widgt: null,
              size: 0.88,
            ),
            InputFieldTaskPage(
              title: 'Date',
              hint: DateFormat.yMd().format(dateSelected),
              controller: _contName,
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
                  controller: _contName,
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
                  controller: _contName,
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
          ],
        ),
      ),
    );
  }

  _getTime(bool startBool) async {
    var x = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 9, minute: 10),
    );
    var formattedTime=x?.format(context);
    if(x==null){
      print('no time selected');
    }
    else if(startBool==true && formattedTime!=null){
      setState(() {
        startTime=formattedTime;
      });
    }
    else if(formattedTime!=null){
      setState(() {
        endTime=formattedTime;
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
