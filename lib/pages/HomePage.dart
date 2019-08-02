import 'package:flutter/material.dart';
import 'package:wanandroid_dev/utils/HttpUtil.dart';
import 'package:wanandroid_dev/bean/Api.dart';
import 'package:wanandroid_dev/bean/BannerItem.dart' as bannerItem;
import 'package:banner_view/banner_view.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bannerItem.BannerData> bannerList = [];
  var bannerIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBannerList();
  }

  void getBannerList() async {
    var response = await new HttpUtil().get(Api.BANNER_LIST);
    var item = new bannerItem.BannerItem.fromJson(response);
    bannerList = item.data;
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
      body: buiildBanner(),
    );
  }

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
}
