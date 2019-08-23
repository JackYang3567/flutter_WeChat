import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:chatapp/pages/chat/chat.dart';

class MyDetails extends StatelessWidget {
  static const String routeName = "/myDetails";

  final data;
  MyDetails({this.data});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: new IconButton(
          /// 左边图标，视情况而定，自己穿参数
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.grey[200],
        elevation: .0,
        title: Text("个人信息",style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(30.0),
                    height: 1.2,  
                    fontFamily: "Courier",
                  ),
                  ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              data ?? "添加好友",
            ),
            FlatButton(
              child: Text("添加好友 "),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}