import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class DetailsPage extends StatefulWidget {
  final String url;
  final String title;

  DetailsPage(this.url, this.title);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new DetailsPageState(this.url, this.title);
  }
}

class DetailsPageState extends State<DetailsPage> {
  final String url;
  final String titleName;
  bool isLoad = true;
  final flutterWebViewPlugin = new FlutterWebviewPlugin();

  DetailsPageState(this.url, this.titleName);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterWebViewPlugin.onStateChanged.listen((state){
      if(state.type==WebViewState.finishLoad){
        setState(() {
          isLoad = false;
        });
      }else{
        setState(() {
          isLoad = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new WebviewScaffold(
      url: url,
      appBar: AppBar(
        elevation: 0,
        title: new Text(titleName),
      ),
      withJavascript: true,
      withLocalStorage: true,
      withZoom: false,
    );
  }
}
