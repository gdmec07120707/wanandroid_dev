import 'package:flutter/material.dart';
import 'package:wanandroid_dev/utils/HttpUtil.dart';
import 'package:wanandroid_dev/bean/Api.dart';
import 'package:wanandroid_dev/bean/BannerItem.dart' as bannerItem;
import 'package:wanandroid_dev/bean/HomeItem.dart' as homeItem;
import 'package:banner_view/banner_view.dart';
import 'package:flutter_refresh/flutter_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bannerItem.BannerData> bannerList = [];
  List<homeItem.HomeItemDataData> homeList = [];
  var bannerIndex = 0;
  int pageIndex = 0;
  final int headerCount = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBannerList();
    getHomeList();
  }

  void getBannerList() async {
    var response = await new HttpUtil().get(Api.BANNER_LIST);
    var item = new bannerItem.BannerItem.fromJson(response);
    bannerList = item.data;
    setState(() {});
  }

  void getHomeList() async {
    var response = await new HttpUtil()
        .get(Api.HOME_LIST + pageIndex.toString() + "/json");
    var item = new homeItem.HomeItem.fromJson(response);
    if (pageIndex == 0) {
      homeList = item.data.datas;
    } else {
      if (item.data.datas.length == 0) {
      } else {
        homeList.addAll(item.data.datas);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: new Text('玩安卓'),
      ),
      body: buildCustomScrollView(),
    );
  }

  ///构建banner图
  Widget buiildBanner() {
    return new Container(
      padding: EdgeInsets.all(5),
      child: bannerList.length > 0
          ? new BannerView(
              bannerList.map((bannerItem.BannerData item) {
                return new GestureDetector(
                    onTap: () {},
                    child: new Image.network(
                      item.imagePath,
                      fit: BoxFit.cover,
                    ));
              }).toList(),
              cycleRolling: false,
              autoRolling: true,
              indicatorMargin: 8.0,
              intervalDuration: Duration(seconds: 3),
              onPageChanged: (index) {
                bannerIndex = index;
              },
            )
          : new Container(),
      width: double.infinity,
      height: 250.0,
    );
  }

  ///构建商品列表
  Widget buildList(homeItem.HomeItemDataData item) {
    return new Card(
      child: new InkWell(
        onTap: () {},
        child: new ListTile(
          title: new Row(
            children: <Widget>[
              new Text(
                item.author,
                textAlign: TextAlign.left,
                style: new TextStyle(color: Colors.grey, fontSize: 13),
              ),
              new Text(
                item.niceDate,
                textAlign: TextAlign.right,
                style: new TextStyle(color: Colors.grey, fontSize: 13),
              )
            ],
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          subtitle: new Column(
            children: <Widget>[
              new Text(
                item.title,
                textAlign: TextAlign.left,
                style: new TextStyle(color: Colors.black, fontSize: 15),
              ),
              new Text(
                item.superChapterName + "/" + item.chapterName,
                style: new TextStyle(color: Colors.blue, fontSize: 13),
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      ),
    );
  }

  Widget buildCustomScrollView() {
    return new Refresh(
      onFooterRefresh: onFooterRefresh,
      onHeaderRefresh: onHeaderRefresh,
      childBuilder: (BuildContext context,
          {ScrollController controller, ScrollPhysics physics}) {
        return new Container(
          child: new ListView.builder(
              physics: physics,
              controller: controller,
              itemCount: homeList.length + headerCount,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return buiildBanner();
                } else {
                  return buildList(homeList[index - headerCount]);
                }
              }),
        );
      },
    );
  }

  ///下拉刷新
  Future<Null> onHeaderRefresh() {
    return new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        pageIndex = 0;
        bannerList.clear();
        homeList.clear();
        this.getBannerList();
        this.getHomeList();
      });
    });
  }

  ///上拉加载更多
  Future<Null> onFooterRefresh() async {
    return new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        pageIndex += 1;
        this.getHomeList();
      });
    });
  }
}
