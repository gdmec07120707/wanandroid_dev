import 'package:flutter/material.dart';
class NavigatorUtil{
  static void pushReplacementNamed(BuildContext context,String routeName){
    Navigator.pushNamed(context, routeName);
  }
}