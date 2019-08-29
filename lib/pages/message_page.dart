import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wechat/common/dioHttpSend.dart';
import 'package:wechat/common/config.dart';
//import 'package:wechat/common/dioHttpSend.dart';

//import 'package:wechat/common/config.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wechat/common/style/style.dart' show AppColors;
import 'package:wechat/pages/message_page/conversation_item.dart';
import 'package:wechat/model/conversation.dart';
import 'package:wechat/provide/websocket.dart';

enum Device{
  MAC, WIN
}

class _DeviceinfoItem extends StatelessWidget {
   _DeviceinfoItem({this.device:Device.MAC});
   final Device device;

    String get devicename {
    return device == Device.WIN ? 'Windows' : 'Mac';
   }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      // color: Color(AppColors.DeviceInfoItemBg),
      decoration: BoxDecoration(
        color: Color(AppColors.DeviceInfoItemBg),
        border: Border(
          bottom:BorderSide(width: 0.5,color: Color(AppColors.DividerColor))
        )
      ),
     /* child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: ScreenUtil().setWidth(30),),
          device == Device.WIN ? new Icon(ICons.WINDOWS,size: ScreenUtil().setSp(40.0),):new Icon(ICons.MAC,size: ScreenUtil().setSp(40.0),),
          SizedBox(width: ScreenUtil().setWidth(50),),
          Text('$devicename 微信已登陆,手机通知已关闭',style: TextStyle(fontSize: ScreenUtil().setSp(24.0),color: Color(AppColors.DeviceInfoItemText),))
        ],
      ),
      */
    );
  }
}

class MessagePage extends StatefulWidget {
  
  _MessagePagePageState createState() => new _MessagePagePageState();
}

class _MessagePagePageState extends State<MessagePage> {
   Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String _stateToken;
  dynamic chatLists ;

  Future<void> _chatListSuccess(ret ) async{
      if( ret["err"] ==0){           
            setState(() {  
                chatLists =ret['data']; 
                Conversation.mockConversations.clear();
                   chatLists.forEach((chat) {
                     var item =  new Conversation(
                        avatar: 'http://http.767717.com:881/static/photo/'+ chat['photo_path'],
                        title: chat['show_name'],
                        des: chat['last_msg'],
                        updateAt: chat['time'].toString(),
                        isMute: false,
                        unreadMsgCount: chat['no_reader_num'],
                        groupId: 000000,
                        userId:chat['list_id'],
                        type: chat['type']
                      );
                     Conversation.mockConversations.add(item);
                  }); 
                 
                 
            });
      }
  }
  @override
  void initState(){
    super.initState();
         _prefs.then((SharedPreferences prefs) {
            _stateToken = prefs.getString('token');
            final url ="/im/get/chatList" ;
            Object formtData =  {
                      "_agent_id": Config['agent_id'],
                      "_token": _stateToken
                  };
                  print(_stateToken);
            DioHttpSend.post(url,params:formtData, success:_chatListSuccess);
     });   
  }
  
  void failure(error) {
     // print(error);
  } 
  @override
  
  Widget build(BuildContext context) {
    
    return  Provide<WebSocketProvide>(
      builder: (context,child,val){
        var messageList = Provide.value<WebSocketProvide>(context).messageList;
        var length = Conversation.mockConversations.length + 1 + messageList.length;        

        return Container(
          child: ListView.builder(
            itemBuilder:  (BuildContext context, int index){
              if(index == 0){
                return _DeviceinfoItem();
              } else if (index < Conversation.mockConversations.length + 1){
                return ConversationItem(Conversation.mockConversations[index - 1],index-1,0);
              }else {
                var inde = index - 1 - Conversation.mockConversations.length;
               return ConversationItem(messageList[inde],inde,1); //====
              }
            },
            itemCount: length ,
          )
        );
      }
    );
  }
}