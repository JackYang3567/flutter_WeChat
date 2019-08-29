import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:provide/provide.dart';
import 'package:wechat/pages/index_page.dart';
import 'package:wechat/provide/currentIndex.dart';
import 'package:wechat/provide/globalData.dart';
import 'package:wechat/provide/websocket.dart';
import 'package:wechat/common/style/style.dart' show AppColors;
import 'package:wechat/routers/routers.dart';
import 'package:wechat/routers/application.dart';

void main() { 
  var providers = Providers();
  var currentIndexProvide = CurrentIndexProvide();
  var globalDataProvide = GlobalDataProvide();
  var websocketProvide = WebSocketProvide(); 

  providers 
   ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide))
   ..provide(Provider<GlobalDataProvide>.value(globalDataProvide))
   ..provide(Provider<WebSocketProvide>.value(websocketProvide));

  runApp(ProviderNode(child:MyApp(),providers: providers));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   
    final router = Router();
    Routers.configureRouters(router);
    Application.router = router;
   
     Provide.value<WebSocketProvide>(context).init();
     return Container(
     
      child: MaterialApp(
        title: '相遇',
        theme: ThemeData.light().copyWith(
          primaryColor: Color(AppColors.PrimaryColor),
          cardColor: Color(AppColors.CardBgColor),
          backgroundColor: Color(AppColors.BackgroundColor),
        ),  
        home: IndexPage(),
      )
    );
   
  }
}

