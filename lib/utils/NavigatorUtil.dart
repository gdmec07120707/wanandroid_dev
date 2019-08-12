import 'package:flutter/material.dart';
import 'package:wanandroid_dev/pages/DetailsPage.dart';
import 'package:wanandroid_dev/bean/SystemTreeEntity.dart';
import 'package:wanandroid_dev/pages/SearchResultPage.dart';
import 'package:wanandroid_dev/pages/SystemListPage.dart';
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

 ///体系列表页面
 static void toSystemList(BuildContext context,List<SystemTreeDatachild> list,String title){
    Navigator.push(context, new MaterialPageRoute(builder: (context){
      return new SystemListPage(list,title);
    }));
 }

 ///搜索结果页面
 static void toSearchResult(BuildContext context,String key){
    Navigator.push(context, new MaterialPageRoute(builder: (context){
      return new SearchResultPage(key);
    }));
 }
}