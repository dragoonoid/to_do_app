import 'package:flutter/material.dart';
import 'package:to_do_app/services/theme_services.dart';

class InputFieldTaskPage extends StatelessWidget {
  final String title, hint;
  final TextEditingController controller;
  final Widget? widgt;
  final double size;
  const InputFieldTaskPage(
      {Key? key,
      required this.title,
      required this.hint,
      required this.controller,
      this.widgt,
      required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, top: 10, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:const  TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width * size,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    autofocus: false,
                    cursorColor: ThemeServices().theme == ThemeMode.dark
                        ? Colors.grey[100]
                        : Colors.grey[800],
                    readOnly: widgt == null ? false : true,
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: TextStyle(
                        color: ThemeServices().theme == ThemeMode.dark
                        ? Colors.grey[100]
                        : Colors.grey[800],
                      ),
                    ),
                  ),
                ),
                widgt==null?Container():Container(
                  child: widgt,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
