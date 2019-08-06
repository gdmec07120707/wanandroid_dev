import 'package:flutter/material.dart';
import 'package:wanandroid_dev/utils/CommonUtil.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MinePage();
}

class _MinePage extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: new Text("我的"),
        elevation: 0,
      ),
      body: buildContent(),
    );
  }

  Widget buildContent() {
    return new Column(
      children: <Widget>[
        new Container(
          width: CommonUtil.getScreenWidth(context),
          height: 180,
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(top: 30, bottom: 15),
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('images/head.jpg'))),
                ),
                new Text(
                  "用户名",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
          ),
          decoration: new BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: const [Colors.blue, Colors.greenAccent])),
        ),
        new GestureDetector(
          onTap: () {},
          child: Container(
            decoration: new BoxDecoration(color: Colors.grey[300]),
            margin:
                EdgeInsets.only(left: 0.0, top: 20.0, right: 0.0, bottom: 0.0),
            padding: EdgeInsets.all(10),
            child: new Row(
              children: <Widget>[
                new Text("我的收藏"),
                new Icon(Icons.keyboard_arrow_right)
              ],
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
        ),
        new GestureDetector(
          onTap: () {},
          child: Container(
            decoration: new BoxDecoration(color: Colors.grey[300]),
            margin:
                EdgeInsets.only(left: 0.0, top: 1.0, right: 0.0, bottom: 0.0),
            padding: EdgeInsets.all(10),
            child: new Row(
              children: <Widget>[
                new Text("清除数据"),
                new Icon(Icons.keyboard_arrow_right)
              ],
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
        ),
        new GestureDetector(
          onTap: () {},
          child: Container(
            decoration: new BoxDecoration(color: Colors.grey[300]),
            margin:
                EdgeInsets.only(left: 0.0, top: 1.0, right: 0.0, bottom: 0.0),
            padding: EdgeInsets.all(10),
            child: new Row(
              children: <Widget>[
                new Text("关于项目"),
                new Icon(Icons.keyboard_arrow_right)
              ],
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
        ),
        new GestureDetector(
          onTap: () {},
          child: Container(
            alignment: Alignment(0.0, 0.0),
            margin:
                EdgeInsets.only(left: 0.0, top: 40.0, right: 0.0, bottom: 0.0),
            width: 100,
            height: 40,
            decoration: new BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(10.0)),
            child: new Text(
              "登录/注册",
              style: new TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        )
      ],
    );
  }
}
