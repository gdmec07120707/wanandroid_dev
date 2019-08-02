import 'package:flutter/material.dart';
import './pages/HomePage.dart';
class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _MainPageState();
  }

}
class _MainPageState extends State<MainPage>{
  int _selectIndex = 0;
  List<Widget> pageData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageData = new List();
    pageData
      ..add(HomePage())
      ..add(HomePage())
      ..add(HomePage())
      ..add(HomePage())
      ..add(HomePage());

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: IndexedStack(
        index: _selectIndex,
        children: pageData,
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(icon: Icon(Icons.home),title: Text('首页')),
            new BottomNavigationBarItem(icon: Icon(Icons.layers),title: Text('体系')),
            new BottomNavigationBarItem(icon: Icon(Icons.search),title: Text('热搜')),
            new BottomNavigationBarItem(icon: Icon(Icons.folder),title: Text('项目')),
            new BottomNavigationBarItem(icon: Icon(Icons.person),title: Text('我的')),
          ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectIndex,
        fixedColor: Colors.blue,
        onTap: (index){
            setState(() {
              _selectIndex = index;
            });
        },
      ),
    );
  }
}