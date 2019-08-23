import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:chatapp/pages/chat/chat.dart';

class AddFriend extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();
  
  final data;
  AddFriend({this.data});
 
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
        title: Text("添加好友",style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(30.0),
                    height: 1.2,  
                    fontFamily: "Courier",
                  ),
                  ),
      ),
      body:  Container(
      padding: EdgeInsets.fromLTRB(10.0,20.0, 10.0, 0),

      child:  Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
               Row(
                mainAxisSize: MainAxisSize.min,
                children: [  
                    new Expanded(
                      child: new   TextFormField(
                        controller: _searchController,
                        autofocus: false, //自动获取焦点
                        maxLength: 32,
                       
                       
                        decoration: InputDecoration(
                              border: new OutlineInputBorder(), // 边框样式  
                              labelText: '好友的用户名/邮箱/手机',
                              hintText: '好友的用户名/邮箱/手机',
                              prefixIcon: IconButton(                          
                                          icon: Icon( Icons.search ),
                                          onPressed: () {},
                                        ),
                              ),
                       
                        validator: (String value) {
                          if (value.isEmpty || value.length<6 || value.length>32 ) {
                            return '好友的用户名/邮箱/手机)';
                          }
                          return null;
                        },
                      ),
                     ),
                    ],
                  ),
                 
                 ],
              ),
      ),
     ),
    );
  }
}