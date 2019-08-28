import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupChat extends StatelessWidget {
  static const String routeName = "/groupChat";

  final data;
  GroupChat({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          /// 左边图标，视情况而定，自己穿参数
          icon: Icon(Icons.arrow_back_ios,size: 20.0,),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.grey[200],
        elevation: .0,
        centerTitle: true,
       
        title: Text("选择联系人", style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(30.0),
                    height: 1.2,  
                    fontFamily: "Courier",
                  ),
                  ),
         actions: <Widget>[            
           IconButton(
              icon: const Icon(Icons.check,color: Colors.green,size: 26.0,),
              onPressed: (){ //_toggleSubmit
              },              
            ),  
            Padding(padding: EdgeInsets.only(right: 5),),
        ],                  
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              data ?? "发起群聊",
            ),
            FlatButton(
              child: Text("发起群聊 "),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}