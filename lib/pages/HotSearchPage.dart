import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wanandroid_dev/bean/Api.dart';
import 'package:wanandroid_dev/bean/HotSearchKey.dart';
import 'package:wanandroid_dev/bean/HotSearchFriend.dart';
import 'package:wanandroid_dev/utils/HttpUtil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wanandroid_dev/utils/NavigatorUtil.dart';

class HotSearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _HotSearchPage();
  }
}

class _HotSearchPage extends State<HotSearchPage> {
  bool isLoading = true;
  List<HotSearchKeyData> hotKeyList;
  List<HotSearchFriendData> hotFriendList;
  final controller = TextEditingController();
  final random = new Random();
  List<Color> colors = [
    Colors.blue,
    Colors.deepOrange,
    Colors.amber,
    Colors.pink[200],
    Colors.green,
    Colors.purple,
    Colors.pink,
    Colors.teal
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    getList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: new Text("玩安卓"),
      ),
      body: buildCustomScrollView() ,
    );
  }

  ///获取数据
  void getList() async {
    var hotKeyResponse = await new HttpUtil().get(Api.HOT_WORD);
    var item = new HotSearchKey.fromJson(hotKeyResponse);
    var hotFriendResponse = await new HttpUtil().get(Api.HOT_FRIEND);
    var hotFriendItem = new HotSearchFriend.fromJson(hotFriendResponse);

    setState(() {
      isLoading = false;
      hotKeyList = item.data;
      isLoading = false;
      hotFriendList = hotFriendItem.data;
    });
  }

  Widget buildCustomScrollView() {
    return isLoading
        ?SpinKitCircle(
            itemBuilder: (_, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.grey
                ),
              );
            },
          )
        : new Container(
            child: new ListView.builder(
                itemCount: 20,
                itemBuilder: (BuildContext context,int index){
                   if(index==0){
                     return buildSearch();
                   }else if(index==1){
                     return buildTitle("大家都在搜");
                   }else if(index==2){
                     return buildKeyList();
                   }else if(index == 3){
                     return buildTitle("常用网站");
                   }else if(index == 4){
                     return buildFriendList();
                   }
                }
            ),
    );
  }

  ///搜索框控件
  Widget buildSearch() {
    return new Container(
      padding: EdgeInsets.only(left: 5.0, top: 3.0, right: 5.0, bottom: 2.0),
      width: 200,
      height: 50,
      child: new Row(
        children: <Widget>[
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 40, maxWidth: 300),
              child: TextField(
                controller: controller,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                    border: new OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                    hintText: "请输入关键字搜索",
                    hintStyle: new TextStyle(
                        fontSize: 14, color: Color.fromARGB(50, 0, 0, 0))),
                style: new TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
            flex: 3,
          ),
          Expanded(
            child: FlatButton(
              onPressed: () {
                NavigatorUtil.toSearchResult(context, controller.text);
              },
              padding:
                  EdgeInsets.only(left: 5.0, top: 3.0, right: 5.0, bottom: 2.0),
              color: Colors.blue,
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              child: new Text("搜索"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
            ),
            flex: 1,
          )
        ],
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }

  ///标题控件
  Widget buildTitle(String title) {
    return new Container(
      padding: EdgeInsets.only(
        left: 10.0,
        top: 5.0,
        right: 5.0,
        bottom: 5.0,
      ),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: new TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }

  ///生成0-7的随机数
  int randomNum() {
    return random.nextInt(7);
  }

  ///构建热搜关键词
  Widget buildKeyList() {
    return new Container(
        decoration: new BoxDecoration(color: Colors.grey[300]),
        margin: EdgeInsets.only(left: 0, top: 2.0, right: 0, bottom: 2.0),
        child: new Wrap(
          children: hotKeyList.map((item) {
            return new GestureDetector(
              onTap: () {
                ///热搜被点击
                NavigatorUtil.toSearchResult(context, item.name);
              },
              child: Container(
                decoration: new BoxDecoration(
                    color: colors[randomNum()],
                    borderRadius: BorderRadius.circular(15)),
                padding: EdgeInsets.only(
                    left: 10.0, top: 5.0, right: 10.0, bottom: 5.0),
                margin: EdgeInsets.only(
                    left: 5.0, top: 5.0, right: 5.0, bottom: 5.0),
                child: Text(
                  item.name,
                  style: new TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),

            );
          }).toList(),
        ));
  }

  ///构建常用网站
  Widget buildFriendList() {
    return new Container(
      decoration: new BoxDecoration(color: Colors.grey[300]),
      margin: EdgeInsets.only(left: 0.0, right: 0.0, bottom: 2.0, top: 2.0),
      child: new Wrap(
        children: hotFriendList.map((item) {
          return new GestureDetector(
            onTap: () {
              NavigatorUtil.toDetails(context, item.link,item.name);
            },
            child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              padding: EdgeInsets.only(
                  left: 10.0, right: 10.0, bottom: 5.0, top: 5.0),
              margin:
                  EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0, top: 5.0),
              child: Text(
                item.name,
                style: new TextStyle(color: colors[randomNum()], fontSize: 16),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
