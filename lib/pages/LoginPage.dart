import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wanandroid_dev/bean/Api.dart';
import 'package:wanandroid_dev/bean/LoginResponseEntity.dart';
import 'package:wanandroid_dev/utils/HttpUtil.dart';
import 'package:wanandroid_dev/utils/SpUtil.dart';
import 'package:wanandroid_dev/app/Constant.dart';

import 'Register.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: new Text("登录"),
      ),
      body: buildContent(),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
                labelText: "用户名",
                hintText: "请输入用户名",
                prefixIcon: Icon(Icons.person),
                hintStyle: TextStyle(color: Colors.grey, fontSize: 13.0)),
            controller: usernameController,
          ),
          TextField(
            decoration: InputDecoration(
                labelText: "密码",
                hintText: "您的登录密码",
                prefixIcon: Icon(Icons.lock),
                hintStyle: TextStyle(color: Colors.grey, fontSize: 13.0)),
            controller: passwordController,
            obscureText: true, //指定密码类型
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: new RaisedButton(
                    child: Text("登录"),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      if(usernameController.text.length==0||passwordController.text.length==0){
                        Fluttertoast.showToast(msg:"用户名或密码不能为空");
                        return;
                      }
                      doLogin(usernameController.text, passwordController.text);
                    },
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, new MaterialPageRoute(
                  builder: (context)=>new Register()));
            },
            child: Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Column(
                children: <Widget>[
                  new Text(
                    "立即注册",
                    style: new TextStyle(color: Colors.blue, fontSize: 16),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void doLogin(var username, var password) async {
    FormData formData =
        new FormData.from({"username": username, "password": password});
    var response = await new HttpUtil().post(Api.LOGIN, data: formData);
    var item = new LoginResponseEntity.fromJson(response);
    if (item.errorCode == 0) {
      ///登录成功
      SpUtils.setString(Constant.spUserName, item.data.username);
      Navigator.pop(context);
    } else {
      print("========================================");
      Fluttertoast.showToast(
          msg: item.errorMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
