import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wanandroid_dev/bean/Api.dart';
import 'package:wanandroid_dev/bean/HomeItem.dart';
import 'package:wanandroid_dev/utils/CommonUtil.dart';
import 'package:wanandroid_dev/utils/HttpUtil.dart';
import 'package:wanandroid_dev/bean/ProjectTree.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_refresh/flutter_refresh.dart';
import 'package:wanandroid_dev/utils/NavigatorUtil.dart';

class ProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _ProjectPage();
  }
}

class _ProjectPage extends State<ProjectPage> {
  List<ProjectTreeData> projectTreeList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTitleData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new DefaultTabController(
        length: projectTreeList.length,
        child: new Scaffold(
          appBar: AppBar(
            title: new Text("玩安卓"),
            bottom: new TabBar(
              isScrollable: true,
              tabs: projectTreeList.map((ProjectTreeData child) {
                return new Tab(
                  text: child.name,
                );
              }).toList(),
            ),
          ),
          body: new TabBarView(
              children: projectTreeList.map((ProjectTreeData child) {
            return new ListPage(cid: child.id);
          }).toList()),
        ));
  }

  void getTitleData() async {
    var response = await new HttpUtil().get(Api.PROJECT_TREE);
    var item = new ProjectTree.fromJson(response);
    setState(() {
      projectTreeList = item.data;
    });
  }
}

class ListPage extends StatefulWidget {
  final int cid;

  const ListPage({Key key, this.cid}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListPage(cid);
  }
}

class _ListPage extends State<ListPage> {
  final int cid;
  int pageIndex = 1;
  bool isLoading = true;
  List<HomeItemDataData> data = [];

  _ListPage(this.cid);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    getPageData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return isLoading
        ? SpinKitCircle(
            itemBuilder: (_, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.grey),
              );
            },
          )
        : new Refresh(
            onHeaderRefresh: onHeadRefresh,
            onFooterRefresh: onFooterRefresh,
            childBuilder: (BuildContext context,
                {ScrollController controller, ScrollPhysics, physics}) {
              return new Container(
                child: new ListView.builder(
                    controller: controller,
                    physics: physics,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      var item = data[index];
                      var date = DateTime.fromMillisecondsSinceEpoch(
                          item.publishTime,
                          isUtc: true);
                      return new GestureDetector(
                        onTap: () {
                          ///跳转到详情
                          NavigatorUtil.toDetails(context, item.link, item.title);
                        },
                        child: new Card(
                          child: new Padding(
                            padding: EdgeInsets.all(10.0),
                            child: new Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Image.network(
                                  item.envelopePic,
                                  fit: BoxFit.cover,
                                  width: 80.0,
                                  height: 130.0,
                                ),
                                new Container(
                                  width: CommonUtil.getScreenWidth(context) -
                                      130.0,
                                  height: 130.0,
                                  margin: EdgeInsets.only(left: 8.0),
                                  child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Text(
                                        item.title,
                                        style: new TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16.0),
                                        maxLines: 2,
                                      ),
                                      new Text(
                                        item.desc,
                                        style: new TextStyle(
                                            color: Colors.grey, fontSize: 14.0),
                                        maxLines: 3,
                                      ),
                                      new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          new Text(
                                            item.author,
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                            style: new TextStyle(
                                                color: Colors.blue,
                                                fontSize: 12.0),
                                          ),
                                          new Text(
                                            "${date.year}年${date.month}月${date.day}日${date.hour}:${date.minute}",
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                            style: new TextStyle(
                                                color: Colors.blue,
                                                fontSize: 11.0),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            },
          );
  }

  ///获取网络数据
  void getPageData() async {
    var response = await new HttpUtil().get(Api.PROJECT_LIST +
        pageIndex.toString() +
        "/json?cid=" +
        cid.toString());
    var item = new HomeItem.fromJson(response);
    setState(() {
      isLoading = false;
      if (pageIndex == 1) {
        data = item.data.datas;
      } else {
        if (item.data.datas.length == 0) {
          Fluttertoast.showToast(
              msg: "无更多数据",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 2,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          data.addAll(item.data.datas);
        }
      }
    });
  }

  ///下拉刷新
  Future<Null> onHeadRefresh() {
    return Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        pageIndex = 1;
        //data.clear();
        this.getPageData();
      });
    });
  }

  ///加载更多
  Future<Null> onFooterRefresh() {
    return Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        pageIndex += 1;
        this.getPageData();
      });
    });
  }

  bool get wanKeepAlive => true;
}
