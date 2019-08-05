import 'package:flutter/material.dart';
import 'package:wanandroid_dev/bean/Api.dart';
import 'package:wanandroid_dev/utils/HttpUtil.dart';
import 'package:wanandroid_dev/bean/SystemTreeEntity.dart';

class SystemPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _SystemPageState();
  }
}

class _SystemPageState extends State<SystemPage> {
  List<SystemTreeData> systemList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSystemList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: new Text('玩安卓'),
      ),
      body: new Container(
        child: new ListView.builder(
            itemCount: systemList.length,
            itemBuilder: (BuildContext context, int index) {
              return buildList(systemList[index]);
            }),
      ),
    );
  }

  ///获取体系数据
  void getSystemList() async {
    var response = await new HttpUtil().get(Api.KNOWLEDGE_TREE);
    var item = SystemTreeEntity.fromJson(response);
    systemList = item.data;
    setState(() {});
  }

  Widget buildList(SystemTreeData item) {
    return new Card(
      child: new InkWell(
        onTap: () {},
        child: new ListTile(
          title: new Row(
            children: <Widget>[
              new Text(
                item.name,
                textAlign: TextAlign.left,
                style: new TextStyle(color: Colors.black, fontSize: 15),
              ),
            ],
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
          subtitle: new Wrap(
            children: <Widget>[
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: item.children.map((data) {
                  return new Container(
                    margin:
                        EdgeInsets.only(left: 0, right: 10, bottom: 0, top: 3),
                    child: Text(
                      data.name,
                      style: new TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
