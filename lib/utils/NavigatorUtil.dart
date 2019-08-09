import 'package:flutter/material.dart';
import 'package:wanandroid_dev/pages/DetailsPage.dart';
class NavigatorUtil{
  static void pushReplacementNamed(BuildContext context,String routeName){
    Navigator.pushNamed(context, routeName);
  }

  ///详情页面
 static void toDetails(BuildContext context,String url, String title){
    Navigator.push(context, new MaterialPageRoute(builder: (context){
      return new DetailsPage(url,title);
    }));
 }
}