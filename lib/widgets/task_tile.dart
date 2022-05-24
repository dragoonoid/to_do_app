import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task? task;
  const TaskTile(this.task, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: task?.color == 0
                    ? Colors.blue
                    : task?.color == 1
                        ? Colors.pink
                        : Colors.yellow,
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task?.title??"",
                  // style: GoogleFonts.lato(
                  //   textStyle: TextStyle(
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.white),
                  //),
                  //style:const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey[200],
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${task!.startTime} - ${task!.endTime}",
                      // style: GoogleFonts.lato(
                      //   textStyle:
                      //   TextStyle(fontSize: 13, color: Colors.grey[100]),
                      // ),
                      //style:const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  task?.note??"",
                  // style: GoogleFonts.lato(
                  //   textStyle: TextStyle(fontSize: 15, color: Colors.grey[100]),
                  // ),
                  //style:const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            color: Colors.grey[200]!.withOpacity(0.7),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              task!.isCompleted == 1 ? "COMPLETED" : "TODO",
              // style: GoogleFonts.lato(
              //   textStyle: TextStyle(
              //       fontSize: 10,
              //       fontWeight: FontWeight.bold,
              //       color: Colors.white),
              // ),
              //style:const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ]),
      ),
    );
  }

  // _getBGClr(int no) {
  //   switch (no) {
  //     case 0:
  //       return Colors.blue;
  //     case 1:
  //       return Colors.pink;
  //     case 2:
  //       return Colors.yellowAccent;
  //     default:
  //       return Colors.blue;
  //   }
  // }
}