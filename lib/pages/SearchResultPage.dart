import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_refresh/flutter_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wanandroid_dev/bean/Api.dart';
import 'package:wanandroid_dev/bean/HomeItem.dart';
import 'package:wanandroid_dev/utils/HttpUtil.dart';
import 'package:wanandroid_dev/utils/NavigatorUtil.dart';

class SearchResultPage extends StatefulWidget {
  final String searchKey;

  SearchResultPage(this.searchKey);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _SearchResultPageState(searchKey);
  }
}

class _SearchResultPageState extends State<SearchResultPage> {
  String searchKey;
  int pageIndex = 0;
  List<HomeItemDataData> resultList = [];

  _SearchResultPageState(this.searchKey);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSearchList();
  }

  //获取搜索结果
  void getSearchList() async {
    FormData formData = new FormData.from({"k": searchKey});
    var response = await new HttpUtil()
        .post(Api.SEARCH_WORD + pageIndex.toString() + "/json", data: formData);
    var item = new HomeItem.fromJson(response);
    if (pageIndex == 0) {
      resultList = item.data.datas;
    } else {
      if (item.data.datas.length == 0) {
        resultList.addAll(item.data.datas);
      } else {
        Fluttertoast.showToast(msg: "我也是有底线的");
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: new Text(searchKey),
      ),
      body: buildCustomScrollView(),
    );
  }

  Widget buildCustomScrollView() {
    return new Refresh(
      onHeaderRefresh: onHeaderRefresh,
      onFooterRefresh: onFooterRefresh,
      childBuilder: (BuildContext context,
          {ScrollController controller, ScrollPhysics physics}) {
        return new Container(
          child: new ListView.builder(
              controller: controller,
              physics: physics,
              itemCount: resultList.length,
              itemBuilder: (BuildContext context, int index) {
                return buildList(resultList[index]);
              }),
        );
      },
    );
  }

  Widget buildList(HomeItemDataData item) {
    return Card(
      child: new InkWell(
        onTap: () {
          NavigatorUtil.toDetails(context, item.link, item.title);
        },
        child: new ListTile(
          title: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(item.author,
                  textAlign: TextAlign.left,
                  style: new TextStyle(color: Colors.grey, fontSize: 13)),
              new Text(item.niceDate,
                  style: new TextStyle(color: Colors.blue, fontSize: 13))
            ],
          ),
          subtitle: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            new Text(item.title,
                textAlign: TextAlign.left,
                style: new TextStyle(color: Colors.black, fontSize: 15)),
            new Text(item.superChapterName + "/" + item.chapterName,
                style: new TextStyle(color: Colors.blue, fontSize: 13)),
          ]),
        ),
      ),
    );
  }

  // 顶部刷新
  Future<Null> onHeaderRefresh() {
    return new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        pageIndex = 0;
        this.getSearchList();
      });
    });
  }

// 底部刷新
  Future<Null> onFooterRefresh() async {
    return new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        pageIndex += 1;
        this.getSearchList();
      });
    });
  }
}
