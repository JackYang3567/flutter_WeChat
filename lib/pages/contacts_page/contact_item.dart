//import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
//import 'package:flutter/material.dart' as prefix1;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/contacts.dart';
import '../../common/style/style.dart';
import 'package:wechat/pages/friend/apply_list.dart';
import 'package:wechat/pages/friend/group_chat_list.dart';
import 'package:wechat/pages/friend/group_auth.dart';

class ContactItem extends StatelessWidget {
  ContactItem(this.contactItemData,this.isGroupTitle)
  :assert(contactItemData != null);

  bool isGroupTitle;
  final Contact contactItemData;

  void _loadRoute(context,name){
     switch(name){
              case "群聊":
                  Navigator.push( context,
                          MaterialPageRoute (builder:  ( context) {
                             return GroupChatList();
                        }) 
                    );
                  break;
               case "群认证":
                  Navigator.push( context,
                          MaterialPageRoute (builder:  ( context) {
                             return GroupAuth();
                        }) 
                    );
                  break;
               case "新的朋友":
                 Navigator.push( context,
                          MaterialPageRoute (builder:  ( context) {
                             return ApplyList();
                        }) 
                    );
                break;

                default:

                  break;
            }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        groupTitle(),
        InkWell(
          child: Row(
            children: <Widget>[
              avatar(),
              title()
            ],
          ),
          onTap: (){
           _loadRoute(context,contactItemData.name);
          },
        )
      ],
    );
  }

  Widget groupTitle(){
    if(isGroupTitle){
      return Container(
        child: Text(contactItemData.nameIndex,style: TextStyle(color: Color(AppColors.ContactGroupTitleText)),),
        height: ScreenUtil().setHeight(50.0),
        width: ScreenUtil().setWidth(750.0),
        padding: EdgeInsets.only(left: ScreenUtil().setWidth(25.0)),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Color(AppColors.ContactGroupTitleBg),
          border: BorderDirectional(
            top: BorderSide(width: ScreenUtil().setHeight(0.5),color:Color(AppColors.DividerColor)),
            bottom: BorderSide(width: ScreenUtil().setHeight(0.5),color:Color(AppColors.DividerColor))
          )
        ),
      );
    }else{
     return Container();
    }
  }
  Widget clipRRectImg(){
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: contactItemData.isAvatarFromNet() ?  Image.network(contactItemData.avatar,scale: 1.0,) : Image.asset(contactItemData.avatar),
    );
  } 
  Widget avatar(){
    return Container(
      margin: EdgeInsets.only(left: ScreenUtil().setWidth(25.0),right: ScreenUtil().setWidth(25.0),top:ScreenUtil().setWidth(15.0),bottom:ScreenUtil().setWidth(15.0)),
     // margin: EdgeInsets.only(left:ScreenUtil().setWidth(20.0)),
      width: ScreenUtil().setWidth(75.0),
      height: ScreenUtil().setHeight(75.0),
      child: clipRRectImg(),
      /*
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.black12,
      ),*/
    );
  }
  Widget title(){
    return Expanded(
      child: Container(
        height: ScreenUtil().setHeight(80.0),
        child: Text(contactItemData.name,style: TextStyle(fontSize: ScreenUtil().setSp(30.0),color: Colors.black,fontWeight: FontWeight.w400),),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: ScreenUtil().setHeight(0.5),color: Color(AppColors.DividerColor))
          )
        )
      ),
    );
  }
}