import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:chatapp/services/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/rendering.dart';
import 'package:wechat/common/dioHttpSend.dart';
import 'package:wechat/common/config.dart';
import 'package:wechat/common/toRootRoute.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: .0,
        centerTitle: true,
        title: Text("注册",style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(30.0),
                    height: 1.2,  
                    fontFamily: "Courier",
                  ),
                  ),
      ),
      body: new SingleChildScrollView(
            child: new ConstrainedBox(
              constraints: new BoxConstraints(
                minHeight: 120.0,
              ),

              child: new SignUpPage(),
            ),
          ),
    );    
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState()=> _SignUpPageState();
   
}


class _SignUpPageState extends State<SignUpPage> {
 Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String> _token;
  

  final _formKey = GlobalKey<FormState>();
  final _userNameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  bool _showLoading = false;
  bool pwdShow = false; //密码是否显示明文
  bool clearText = false; //清除文本
  bool _nameAutoFocus = true;
/*
  Future _signupRequest() async {
    return Future.delayed(Duration(seconds: 3), () {
      //do nothing
      print('登录成功');
    });
  }
*/

Future<void> _signinSuccess(ret) async{
    final SharedPreferences prefs = await _prefs;
    if( ret["err"] ==0){
        final  String token= ret['data']['token'];
          setState(() {              
              _token = prefs.setString("token", token).then((bool success) {
                print("===6666===");
                ToRootRoute.goHome(context);
                return ;
              });
          });
    }
 }
  void failure(error) {
      print(error);
  } 

  void _toggleSubmit() {
     if (_formKey.currentState.validate()) {
         
          final url ="/im/in/reg" ;
          final formtData =  {
                      "username": _userNameTextController.text, 
                      "password": _passwordTextController.text,
                      "_agent_id": Config['agent_id'],
                      "_token": ""
                      };
         DioHttpSend.post(url,formtData, _signinSuccess, failure);
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
            
               Text("输入您的注册信息",
                style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      height: 3.5,  
                      fontFamily: "Courier",
                    )
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
                      height: 1.2,  
                      fontFamily: "Courier",
                    ),
                    
                  ),
                   Padding(
                   padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
                  ),
                  new Expanded(
                      child: new TextFormField(
                     // autofocus: _nameAutoFocus,
                      controller: _userNameTextController,
                      decoration: InputDecoration(
                      labelText: '手机号/相遇号(6-16位字母/数字)',
                      hintText: '请输入手机号/相遇号(6-16位字母/数字)',
                        
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
                          return '请输入手机号/相遇号(6-16位字母/数字)';
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
                    height: 1.2,  
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
                       controller: _passwordTextController,
                       autofocus: !_nameAutoFocus,
                       decoration: InputDecoration(
                        labelText: '密码(6-16位)',
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
                    padding: EdgeInsets.only(left: 280.0 ,top:48.0),
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
                onPressed: _toggleSubmit,
                
                child: Text(
                  '注册',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                color: Colors.blue,
             
              ),
            )
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
              color: Colors.red,
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