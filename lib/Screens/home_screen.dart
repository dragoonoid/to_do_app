import 'package:flutter/material.dart';
import 'package:to_do_app/services/theme_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        child: const Text('Theme data',style: TextStyle(fontSize: 20),),
      ),
    );
  }
}

_appBar(){
  return AppBar(
    leading: GestureDetector(
      onTap: (){
        ThemeServices().switchTheme();
      },
      child:const Icon(Icons.nightlight_round,size: 20,),
    ),
    actions: const [
      Icon(Icons.person,size: 20,),
      SizedBox(width:20),
    ],
  );
}