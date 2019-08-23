//import 'dart:io'; // 网络请求
//import 'dart:convert'; // 数据解析
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:chatapp/services/authentication.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/rendering.dart';


import 'package:wechat/pages/sign/signUp.dart';
import 'package:wechat/common/dioHttpSend.dart';

import 'package:wechat/common/config.dart';
import 'package:wechat/common/toRootRoute.dart';
//import '../../../config/httpHeaders.dart';
//import 'package:chatapp/services/authentication.dart';



void main() {
  debugPaintSizeEnabled = true;
  runApp(new SignIn());
}
 


class SignIn extends StatelessWidget {
  // This widget is the root of your application.
  
 // final BaseAuth auth;
  //final VoidCallback onSignedIn;
   
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
         theme: new ThemeData(
           primaryColor: Colors.grey[200],
        ),
        title: '登录',
        home: Scaffold(
          appBar: AppBar(
             elevation: .0,
            centerTitle: true,
            title: Text('登录',style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(30.0),
                   
                    fontFamily: "Courier",
                  ),
                   ),
          ),
          body: new SingleChildScrollView(
            child: new ConstrainedBox(
              constraints: new BoxConstraints(
                minHeight: 120.0,
              ),

              child: new LoginHomePage(),
            ),
          ),
        ));
  }
}

class LoginHomePage extends StatefulWidget {
  @override
  _LoginHomePageState createState()=> _LoginHomePageState();
   
}

class _LoginHomePageState extends State<LoginHomePage> {
  FocusNode _focusNode = new FocusNode();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String> _token;
  final _formKey = GlobalKey<FormState>();
  final _userNameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  bool _showLoading = false;
  bool pwdShow = false; //密码是否显示明文
  bool clearText = false; //清除文本
  bool _nameAutoFocus = true;



  @override
  void initState() {
    
    super.initState();
    
      //_focusNode.addListener(_focusNodeListener);
      // _token = _prefs.then((SharedPreferences prefs) {
      //   return (prefs.getString('token') ?? null);
     // });
  }
/*
  @override
    void dispose(){
        _focusNode.removeListener(_focusNodeListener);  // 页面消失时必须取消这个listener！！
        super.dispose();
    }
 
    Future<Null> _focusNodeListener() async {  // 用async的方式实现这个listener
        if (_focusNode.hasFocus){
            print('TextField got the focus');
        } else {
            print('TextField lost the focus');
        }
    }
*/
  void failure(error) {
      print(error);
  } 

  
 Future<void> _loginSuccess(ret) async{
   
    final SharedPreferences prefs = await _prefs;
    if( ret["err"] ==0){
        final  String token= ret['data']['token'];
          setState(() {              
              _token = prefs.setString("token", token).then((bool success) {
                  ToRootRoute.goHome(context);
                  return token;
              });
          });
    }
    else{
        String msg = ret['msg'] +'!';
        ToRootRoute.dialog(context,msg);
    }
 }

 
  void _toggleSubmit() {
        
     if (_formKey.currentState.validate()) {
        print("====过关====");
        final url ="/im/in/login" ;
        final formtData =  {
                  "username": _userNameTextController.text, 
                  "password": _passwordTextController.text,
                  "_agent_id": Config['agent_id'],
                  "_token": ""
                  };
        DioHttpSend.post(url,formtData, _loginSuccess, failure);
     }
     else{
       print("====验证不过关====");
     }
            
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> childrens = [];
    final _mainConatiner = Container(
      padding: EdgeInsets.fromLTRB(10.0,60.0, 10.0, 0),
      child: Form(
        
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[            
               Image.asset(
                  'assets/images/app.png',
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.fitHeight,
                ),
           
            Padding(
              padding: EdgeInsets.only(top:60.0),
            ),

            Row(
                mainAxisSize: MainAxisSize.min,
                children: [                 
                  Padding(
                   padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  ),
               
                  new Text(
                      '帐号',
                    style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                   
                    fontFamily: "Courier",
                  ),
                    
                  ),
                   Padding(
                   padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
                  ),
                  new Expanded(
                      child: new TextFormField(
                     // focusNode: _focusNode, 
                     // autofocus: _nameAutoFocus,
                      controller: _userNameTextController,
                      decoration: InputDecoration(
                      labelText: '手机号/相遇号(6-16位字母/数字)',
                      hintText: '手机号/相遇号(6-16位字母/数字)',
                      suffixIcon: IconButton(                         
                          icon: Icon(                           
                             Icons.clear ,
                            ),
                          onPressed: () {                                                   
                            setState(() {
                              clearText = !clearText;
                            }); 
                            _userNameTextController.text = '';                           
                          },                         
                        ),
                      ),
                     
                      validator: (String value) {
                        if (value.trim().isEmpty || value.trim().length<6 || value.trim().length>16) {
                          return '请输入帐号';
                        }
                        return null;
                      },
                      
                    ),

                    
                  ),
                  
                ],
              ),

           
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),

            Row(
                children: [
                   Padding(
                   padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  ),
                  new Text('密码',
                   style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                   
                    fontFamily: "Courier",
                   // background: new Paint()..color=Colors.yellow,
                   // decoration:TextDecoration.underline,
                    //decorationStyle: TextDecorationStyle.dashed
                  ),
                  ),

                    Padding(
                     padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
                    ),
                  new Expanded(
                    child: new TextFormField(
                      // focusNode: _focusNode, 
                       controller: _passwordTextController,
                       autofocus: !_nameAutoFocus,
                       decoration: InputDecoration(
                        labelText: '请输入密码(6-16位)',
                        hintText: '请输入密码(6-16位)',
                       // prefixIcon: Icon(Icons.lock),
                       
                        suffixIcon: IconButton(
                          
                          icon: Icon(
                              pwdShow ? Icons.visibility_off : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              pwdShow = !pwdShow;
                            });
                          },
                        ),
                        ),

                      obscureText: !pwdShow,
                      validator:  ( String value) {
                        if (value.trim().isEmpty || value.trim().length<6 || value.trim().length>16) {
                          return '请输入密码(6-16位)';
                        }
                          return null;
                      },                       
                    ),
                  ),
                ],
              ),
           
            Padding(
              padding: EdgeInsets.only(top: 30.0),
            ),
            Row(
                children: [ 
                  Padding(
                    padding: EdgeInsets.only(left: 280.0),
                  ),
                  FlatButton(
                    child: Text(
                        "快速注册 >>",
                        textAlign: TextAlign.left,
                        style: TextStyle( fontSize: 14.0,color: Colors.red,)
                    ),
                    onPressed: () {
                       //导航到新路由   
                      Navigator.push( context,
                          MaterialPageRoute (builder:  ( context) {
                             return SignUp();
                          }) 
                      );
                    },
                    ),
                ]
               ),

            Padding(
              padding: EdgeInsets.only(top: 30.0),
            ),
            SizedBox(
              width: double.infinity,
              height: 50.0,
              
              child: RaisedButton(
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                onPressed:  _toggleSubmit ,                
                child: Text(
                  '登录',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                color: Colors.blue,             
              ),
            ),            
          ],
        ),
      ),
    );
    final _loadingContainer = Container(
        constraints: BoxConstraints.expand(),
        color: Colors.black12,
        child: Center(
          child: Opacity(
            opacity: 0.9,
            child: SpinKitWave(
              color: Colors.green,
              size: 50.0,
            ),
          ),
        ));
    childrens.add(_mainConatiner);

    if (_showLoading) {
      childrens.add(_loadingContainer);
    }
    return Stack(
      children: childrens,
    );
  }
}

