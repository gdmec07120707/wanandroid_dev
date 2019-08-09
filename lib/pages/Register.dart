import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wanandroid_dev/bean/UserInfoItem.dart';
import 'package:wanandroid_dev/utils/HttpUtil.dart';
import 'package:wanandroid_dev/bean/Api.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RegisterState();
  }
}

class RegisterState extends State<Register> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController rePasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text("注册"),
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
                hintText: "输入登录密码",
                prefixIcon: Icon(Icons.lock),
                hintStyle: TextStyle(color: Colors.grey, fontSize: 13.0)),
            controller: passwordController,
            obscureText: true, //指定密码类型
          ),
          TextField(
            decoration: InputDecoration(
                labelText: "密码",
                hintText: "再次输入重复密码",
                prefixIcon: Icon(Icons.lock),
                hintStyle: TextStyle(color: Colors.grey, fontSize: 13.0)),
            controller: rePasswordController,
            obscureText: true, //指定密码类型
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: new RaisedButton(
                    child: Text("注册"),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      if (usernameController.text.length == 0 ||
                          passwordController.text.length == 0 ||
                          rePasswordController.text.length==0) {
                        Fluttertoast.showToast(msg: "用户名或密码不能为空");
                        return;
                      }
                      if(passwordController.text.toString()!=rePasswordController.text.toString()){
                        Fluttertoast.showToast(msg: "输入的密码不一致");
                        return;
                      }
                      doRegister(usernameController.text,
                          passwordController.text, rePasswordController.text);
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void doRegister(String username, String password, String repassword) async {
    FormData formData = new FormData.from({"username":username,"password":password,"repassword":repassword});
    var response = await new HttpUtil().post(Api.REGISTER,data: formData);
    var item = new UserInfoItem.fromJson(response);
    if(item.errorCode==0){
      Fluttertoast.showToast(msg: "注册成功");
      Navigator.pop(context);
    }else{
      Fluttertoast.showToast(msg: "错误"+item.errorMsg.toString());
    }
  }
}
