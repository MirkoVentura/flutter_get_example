import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_todo_app/screens/home_screen.dart';

void main() async {
  await GetStorage.init();
  runApp(
      const GetMaterialApp(debugShowMaterialGrid: false, home: HomeScreen()));
}
