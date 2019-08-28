import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:wechat/pages/chat_detail_page.dart';

Handler chatDetailHandler = Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
    final index = params['index'].first;
    final type = params['type'].first;
    final userId = params['userId'].first;
    print('message>detail title is ${index}');
    final inde = int.parse(index);
    final typ = int.parse(type);
   
    return ChatDetailPage(inde,typ,userId);
  }
);