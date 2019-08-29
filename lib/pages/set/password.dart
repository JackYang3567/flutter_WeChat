import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:chatapp/services/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/rendering.dart';
import 'package:wechat/common/dioHttpSend.dart';
import 'package:wechat/common/config.dart';
import 'package:wechat/pages/sign/signIn.dart';
import 'package:wechat/common/toRootRoute.dart';


class PasswordChange extends StatefulWidget {
  @override
  _PasswordChangePageState createState()=> _PasswordChangePageState();
   
}

class _PasswordChangePageState extends State<PasswordChange> {
   Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  
   String _stateToken;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pass1Controller = TextEditingController();
  final TextEditingController _pass2Controller = TextEditingController();
  final TextEditingController _pass3Controller = TextEditingController();
  bool pwdShow1 = false; //密码是否显示明文
  bool pwdShow2 = false; //密码是否显示明文
  bool pwdShow3 = false; //密码是否显示明文

 
  @override
   void initState() {
    super.initState();
        _prefs.then((SharedPreferences prefs) {
          _stateToken = prefs.getString('token');
          return (prefs.getString('token') ?? null);
       });   
  }
 

Future<void> _changPassSuccess(ret) async{
    if( ret["err"] ==0){
        final SharedPreferences prefs = await _prefs;
        final token = null;
         prefs.setString("token", token).then((bool success) {                   
                     String msg ='修改成功，重新登录';
                     ToRootRoute.dialog(context,msg);
                     Navigator.push( context,
                        MaterialPageRoute(builder: (context) {
                            return SignIn();
                        })
                    );
          return token;
             
       });
    }else{
       //AlertDialog(content: Text(ret['msg']),);
      String msg ='修改密码失败：' + ret['msg'] +'!';
      ToRootRoute.dialog(context,msg);
    }
 }

 
  void failure(error) {
      print(error);
  } 

  void _toggleSubmit() {
     if( _formKey.currentState.validate()){
          final url ="/im/set/password" ;
          final formtData =  {
                    "pass1": _pass1Controller.text, 
                    "pass2": _pass2Controller.text,
                    "pass3": _pass3Controller.text,
                    "_agent_id": Config['agent_id'],
                    "_token": _stateToken
                    };
         
          print(formtData);
          DioHttpSend.post(url,params:formtData, success:_changPassSuccess );      
       }   
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
        title: Text("修改密码",style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(30.0),
                    height: 1.2,  
                    fontFamily: "Courier",
                  ),
                  ),
        actions: <Widget>[ 
           
           IconButton(
              icon: const Icon(Icons.check,color: Colors.green,size: 26.0,),
              onPressed: _toggleSubmit,
              
            ),  
            Padding(padding: EdgeInsets.only(right: 5),),
        ],        
      ),
     body: Container(
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
                        controller: _pass1Controller,
                        maxLength: 16,
                        decoration: InputDecoration(
                        border: new OutlineInputBorder(), // 边框样式  
                        labelText: '输入原密码',
                        hintText: '请输入原密码(6-16位)',
                        suffixIcon:  IconButton(                          
                                    icon: Icon(
                                        pwdShow1 ? Icons.visibility_off : Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        pwdShow1 = !pwdShow1;
                                      });
                                    },
                                  ),
                               
                        ),
                        
                        obscureText: !pwdShow1,
                        validator: (String value) {
                          if (value.isEmpty || value.length<6 || value.length>16 ) {
                            return '请输入原密码(6-16位)';
                          }
                          return null;
                        },
                      ),
                    ),
                ],
               ),

               Row(
                mainAxisSize: MainAxisSize.min,
                children: [  
                      new Expanded(
                      child: new    TextFormField(
                        controller: _pass2Controller,
                        maxLength: 16,
                        decoration: InputDecoration(
                         border: new OutlineInputBorder(), // 边框样式  
                        labelText: '输入新密码',
                        hintText: '请输入新密码(6-16位)',
                        suffixIcon:
                         IconButton(                          
                                    icon: Icon(
                                        pwdShow2 ? Icons.visibility_off : Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        pwdShow2 = !pwdShow2;
                                      });
                                    },
                                  ),
                        ),
                        
                        obscureText: !pwdShow2,
                        validator: (String value) {
                          if (value.isEmpty || value.length<6 || value.length>16 ) {
                            return '请输入新密码(6-16位)';
                          }
                          return null;
                        },
                      ),
                      ),
                   ],
                 ),

               Row(
                mainAxisSize: MainAxisSize.min,
                children: [  
                  new Expanded(
                      child: new  
                      TextFormField(
                        controller: _pass3Controller,
                        maxLength: 16,
                        decoration: InputDecoration(labelText: '确认新密码',
                        border: new OutlineInputBorder(), // 边框样式
                        hintText: '请确认新密码(6-16位)',
                        suffixIcon: IconButton(                          
                                    icon: Icon(
                                        pwdShow3 ? Icons.visibility_off : Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        pwdShow3 = !pwdShow3;
                                      });
                                    },
                                  ),
                        ),
                        
                        obscureText: !pwdShow3,
                        validator: (String value) {
                          if (value.isEmpty || value.length<6 || value.length>16 || value!=_pass2Controller.text ) {
                            return '请确认新密码(6-16位),并确定与新密码相同';
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