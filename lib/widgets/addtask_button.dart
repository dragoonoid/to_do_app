// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class AddTaskButton extends StatelessWidget {
  final String text;
  final Function()? ontap;
  const AddTaskButton({Key? key, required this.text, required this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 50,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.blue[800],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
            child: Text(
          text,
          style:const  TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
