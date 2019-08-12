import 'package:flutter/material.dart';
import 'package:flutter_refresh/flutter_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wanandroid_dev/bean/SystemListItem.dart';
import 'package:wanandroid_dev/bean/SystemTreeEntity.dart';
import 'package:wanandroid_dev/bean/Api.dart';
import 'package:wanandroid_dev/utils/HttpUtil.dart';
import 'package:wanandroid_dev/utils/NavigatorUtil.dart';

///体系列表页面
class SystemListPage extends StatefulWidget {
  final List<SystemTreeDatachild> children;
  final String title;

  SystemListPage(this.children, this.title);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _SystemListPageState(children, title);
  }
}

class _SystemListPageState extends State<SystemListPage> {
  List<SystemTreeDatachild> children;
  String titleName;

  _SystemListPageState(this.children, this.titleName);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new DefaultTabController(
        length: children.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text(titleName),
            bottom: new TabBar(
                isScrollable: true,
                tabs: children.map((SystemTreeDatachild child) {
                  return new Tab(
                    text: child.name,
                  );
                }).toList()),
          ),
          body: new TabBarView(
            children: children.map((SystemTreeDatachild child) {
              return new ListPage(child.id);
            }).toList(),
          ),
        ));
  }
}

class ListPage extends StatefulWidget {
  final int cid;

  ListPage(this.cid);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _ListPageState(cid);
  }
}

class _ListPageState extends State<ListPage> {
  int cid;
  bool isLoading = true;
  List<SystemListItemDataData> data;
  int pageIndex = 0;
  bool isLoadMore = true;

  _ListPageState(this.cid);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    isLoadMore = true;
    getPageData();
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return isLoading
        ? new SpinKitCircle(
            itemBuilder: (_, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.grey),
              );
            },
          )
        : new Refresh(
            onHeaderRefresh: onHeaderRefresh,
            onFooterRefresh: onFooterRefresh,
            childBuilder: (BuildContext context,
                {ScrollController controller, ScrollPhysics physics}) {
              return new Container(
                child: new ListView.builder(
                    physics: physics,
                    controller: controller,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      var item = data[index];
                      var date = DateTime.fromMillisecondsSinceEpoch(
                          item.publishTime,
                          isUtc: true);
                      return new GestureDetector(
                        onTap: () {
                          NavigatorUtil.toDetails(context, item.link, item.title);
                        },
                        child: new Card(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text(
                                      item.author,
                                      style: new TextStyle(
                                          fontSize: 13.0, color: Colors.grey),
                                    ),
                                    new Text(
                                        "${date.year}年${date.month}月${date.day}日 ${date.hour}:${date.minute}",
                                        style: new TextStyle(
                                            fontSize: 13.0, color: Colors.grey))
                                  ],
                                ),
                                new Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Text(
                                    item.title,
                                    style: new TextStyle(
                                        color: Colors.black, fontSize: 15.0),
                                  ),
                                ),
                                new Text(
                                  "${item.author}/${item.chapterName}",
                                  style: new TextStyle(
                                      fontSize: 13.0, color: Colors.blue),
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

  Future<Null> onHeaderRefresh(){
    return Future.delayed(new Duration(seconds: 2),(){
      setState(() {
        pageIndex=0;
        this.getPageData();
      });
    });
  }

  Future<Null> onFooterRefresh() async{
    return new Future.delayed(new Duration(seconds: 2),(){
      setState(() {
        pageIndex+=1;
        getPageData();
      });
    });
  }

  ///获取每一个栏目的数据
  void getPageData() async {
    var response = await new HttpUtil().get(Api.KNOWLEDGE_LIST +
        pageIndex.toString() +
        "/json?cid=" +
        cid.toString());
    var item = new SystemListItem.fromJson(response);
    setState(() {
      isLoading = false;
      if (pageIndex == 0) {
        data = item.data.datas;
      } else {
        if (item.data.datas.length == 0) {
          Fluttertoast.showToast(msg: "我也是有底线的");
        } else {
          data.addAll(item.data.datas);
        }
      }
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
