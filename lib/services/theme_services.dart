import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
class ThemeServices{
   final _box=GetStorage();
   final _key='isDarkMode';
  bool loadtheme(){
    return _box.read(_key)==true?true:false;
  }
  ThemeMode get theme{
    return loadtheme()?ThemeMode.dark:ThemeMode.light;
  }
  void switchTheme(){
    if(loadtheme()==true){
      _box.write(_key, false);
      Get.changeThemeMode(ThemeMode.light);
    }
    else{
      _box.write(_key, true);
      Get.changeThemeMode(ThemeMode.dark);
    }
  }
}