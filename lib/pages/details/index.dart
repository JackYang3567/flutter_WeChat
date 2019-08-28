import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wechat/common/dioHttpSend.dart';
import 'package:wechat/common/config.dart';

import 'package:wechat/routers/application.dart';
import 'package:wechat/pages/component/full_with_icon_button.dart';
import 'package:wechat/common/style/style.dart' show ICons,AppColors;

class ContactIndex extends StatefulWidget {
  ContactIndex({this.contactItemData });
   dynamic contactItemData;
  _ContactIndexPageState createState() => new _ContactIndexPageState();
}

class _ContactIndexPageState extends State<ContactIndex> {

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String _stateToken;
  dynamic retData ;

  Future<void> _userInfoSuccess(ret ) async{
      if( ret["err"] ==0){           
            setState(() {  
                retData =ret['data']; 
                print(retData);
            });
      }
  }
  @override
  void initState(){
    super.initState();
     
         _prefs.then((SharedPreferences prefs) {
            _stateToken = prefs.getString('token');
            final url ="/im/get/details" ;
            Object formtData =  {
                      "in":0,
                      "user_id":  widget.contactItemData.userId,
                      "_agent_id": Config['agent_id'],
                      "_token": _stateToken
                  };
                  print(_stateToken);
            DioHttpSend.post(url,formtData, _userInfoSuccess, failure);
       });   
  }
  void failure(error) {
     // print(error);
  } 
  Widget build(BuildContext context) {

   // print(retData);
    return MaterialApp(
      home:  Scaffold(
      appBar: AppBar(
         leading: new IconButton(
          /// 左边图标，视情况而定，自己穿参数
          icon: Icon(Icons.arrow_back_ios,size: 20.0,),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromRGBO(255, 255, 255, 255),
        elevation: .0,
        centerTitle: true,
        title: Text("",style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(30.0),
                    height: 1.2,  
                    fontFamily: "Courier",
                  ),
                  ),
                  
         actions: <Widget>[            
           IconButton(
              icon: const Icon(Icons.more_horiz,color: Colors.black,size: 26.0,),
              onPressed: (){},              
            ),  
            Padding(padding: EdgeInsets.only(right: 5),), 
         ],     
             
      ),
      body:   Container( 
        
          padding: EdgeInsets.fromLTRB(15.0,20.0, 10.0, 0),
                      child: Column(
                       
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                       children: <Widget>[ 
                         
                              Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  
                                    children: <Widget>[
                                     
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5.0),
                                        child: Image.network( "${Config['static_url']}/static/photo/${retData['photo']}",width:ScreenUtil().setWidth(120.0),height:ScreenUtil().setWidth(120.0)),
                                      ),
                                   
                                     
                                      Expanded(
                                        child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(left: ScreenUtil().setWidth(30.0)),
                                              child:  Text(retData["nickname"],style: TextStyle(color: Color(AppColors.HeaderCardTitleText),fontSize: ScreenUtil().setSp(40.0)),),
                                            ),
                                            SizedBox(
                                              height: ScreenUtil().setWidth(15.0),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(left: ScreenUtil().setWidth(30.0)),
                                              child:  Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text('昵称：',style:TextStyle(color: Color(AppColors.HeaderCardDesText),fontSize: ScreenUtil().setSp(24.0)),),
                                                        Text("me.account",style:TextStyle(color: Color(AppColors.HeaderCardDesText),fontSize: ScreenUtil().setSp(24.0)),),
                                                      ],
                                                    ),
                                                    
                                                  ),
                                                
                                                ],
                                                
                                              )
                                            ),
                                          ],
                                        ),                
                                      )
                                     
                                    ],
                                  ),
                              
                                
                              
                                  SizedBox(
                                    height: ScreenUtil().setHeight(30.0),
                                  ),
                                  FullWithIconButton(
                                    iconPath: 'assets/images/ic_social_circle.png',
                                    title: '设置备注和标注',
                                    showDivider: false, 
                                    onPressed: (){},
                                  ),
                                
                                  
                                  SizedBox(
                                    height: ScreenUtil().setHeight(20.0),
                                  ),
                                  FullWithIconButton(
                                    iconPath: 'assets/images/ic_settings.png',
                                    title: '个性签名',
                                    showDivider: false,
                                    description: '账号保护',
                                    onPressed: (){},
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(20.0),
                                  ),
                                  FullWithIconButton(
                                    iconPath: 'assets/images/ic_settings.png',
                                    title: '朋友圈',
                                    showDivider: false,
                                    description: '账号保护',
                                    onPressed: (){},
                                  ),

                                  SizedBox(
                                    height: ScreenUtil().setHeight(20.0),
                                  ),
                                  FullWithIconButton(
                                   
                                    iconPath: 'assets/images/ic_settings.png',
                                    title: '来源',
                                    showDivider: false,
                                    description: '账号保护',
                                    onPressed: (){},
                                  ),

                                  SizedBox(
                                    height: ScreenUtil().setHeight(20.0),
                                    
                                  ),
                                                                  

                                  FlatButton.icon(
                                      color: Colors.white,
                                      icon: Icon(ICons.MESSAGE,size: 20,),
                                      label: Text("发消息",style: TextStyle(fontSize: 16.0),),
                                      onPressed: () {
                                          Application.router.navigateTo(context, '/chatdetail?index=1&type=1');
                                      },
                                  ),
                                 
                                   
                              ], 
                   ),
       ),
    ),
     );
  }
}
