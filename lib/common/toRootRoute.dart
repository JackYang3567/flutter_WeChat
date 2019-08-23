
import 'package:flutter/material.dart';
import 'package:wechat/provide/currentIndex.dart';
import 'package:wechat/pages/index_page.dart';
import 'package:provide/provide.dart';

class ToRootRoute {
 static PageRouteBuilder _homeRoute = new PageRouteBuilder(
   pageBuilder: (BuildContext context, _, __) {
    Provide.value<CurrentIndexProvide>(context).changeIndex(0);
     return IndexPage();
   }, 
 );
 
 static goHome(context) {
    return  Navigator.pushAndRemoveUntil(context, _homeRoute, (Route<dynamic> r) => false);
   }

 static dialog(context,msg){
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(msg),
                 actions: <Widget>[              
                    new FlatButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: new Text('确定', style: TextStyle(color: Colors.green))),
                   
                    Padding(padding:  EdgeInsets.fromLTRB(90, 0, 20, 0),),
                   
                    new FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: new Text('取消', style: TextStyle(color: Colors.green))),
                  ],
              );
      });
  } 
}