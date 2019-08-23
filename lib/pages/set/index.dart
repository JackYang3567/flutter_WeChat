import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wechat/pages/component/full_with_icon_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wechat/pages/sign/signIn.dart';
import 'package:wechat/pages/set/password.dart';
//import 'package:chatapp/pages/chat/chat.dart';


class SetIndex extends StatefulWidget {
  @override
  _SetIndexePageState createState()=> _SetIndexePageState();
   
}

class _SetIndexePageState extends State<SetIndex> {
  
 Future<void> _signOut() async{
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      Future<String> _token;
           final token = null;
            setState(() {              
                _token = prefs.setString("token", token).then((bool success) {
                    print(prefs.getString('token'));
                   return token;
                });
       });
 }

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
        title: Text("设置",style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(30.0),
                    height: 1.2,  
                    fontFamily: "Courier",
                  ),
                  ),
      ),
      body: Center(
        child: Column(
      children: <Widget>[
    
        SizedBox(
          height: ScreenUtil().setHeight(40.0),
        ),
         FullWithIconButton(
          iconPath: 'assets/images/changepass.png',
          title: '修改登录密码',
          showDivider: false, 
          onPressed: (){
            //导航到新路由 :修改登录密码  
             Navigator.push( context,
                  MaterialPageRoute(builder: (context) {
                      return PasswordChange();
                  })
              ); 
          },
        ),
       
        
        SizedBox(
          height: ScreenUtil().setHeight(40.0),
        ),
        Padding(
              padding: EdgeInsets.fromLTRB( 20, 30.0,20,0),
            ),
        SizedBox(
              width: 380.0,
              height: 50.0,              
              child: RaisedButton(
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                color: Colors.red[300],
                highlightColor: Colors.red,
                splashColor: Color(0xffff0000),                            
                child: Text(  '退出登录',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                onPressed: (){
                      _signOut();
                      //导航到新路由 :朋友圈  
                     Navigator.push( context,
                        MaterialPageRoute(builder: (context) {
                            return SignIn();
                        })
                    );
                },
              ),
            ),
      ],
      ),
      ),
    );
  }
}

