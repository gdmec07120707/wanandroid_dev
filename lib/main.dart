import 'package:flutter/material.dart';
import 'package:wanandroid_dev/stu/InheritedWidgetTestRoute.dart';
import 'MainPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: '玩安卓',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: InheritedWidgetTestRoute(),
    );
  }

}

