import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/services/notification_services.dart';
import 'package:to_do_app/services/theme_services.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/widgets/addtask_button.dart';

import 'addTaskPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _date=DateTime.now();
  var notifyHelper;
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          _firstBar(),
          _selectDate(),
        ],
      ),
    );
  }

  _selectDate(){
    return Container(
      margin: const EdgeInsets.only(top: 10,left: 10),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: Colors.purple,
        selectedTextColor: Colors.white,
        //deactivatedColor: ThemeServices().theme==ThemeMode.dark?Colors.white:Colors.black,
        dateTextStyle: const TextStyle(color: Colors.grey,fontSize: 20),
        monthTextStyle: const TextStyle(color: Colors.grey,fontSize: 12),
        dayTextStyle: const TextStyle(color: Colors.grey,fontSize: 12),
        onDateChange: (date){
          _date=date;
        },
      ),
    );
  }

  _firstBar(){
    return Container(
            margin:const  EdgeInsets.only(top: 5,left: 20,right: 20,bottom: 5),
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
                    const Text('Today',style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),),
                  ],
                ),
                AddTaskButton(text: '+Add Task', ontap: (){
                  Get.to(()=> const AddTaskPage());
                }),
              ],
            ),
          ) ;
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
