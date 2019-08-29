import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:wechat/provide/currentIndex.dart';
import 'package:wechat/pages/message_page.dart';
import 'package:wechat/pages/contacts_page.dart';
import 'package:wechat/pages/discover_page.dart';
import 'package:wechat/pages/my/mine_page.dart';
import 'package:wechat/common/style/style.dart' show ICons,AppColors;
import 'package:wechat/pages/friend/addfriend.dart';
import 'package:wechat/pages/friend/groupchat.dart';
import 'package:wechat/common/waiting.dart';
import 'package:wechat/pages/sign/signIn.dart';
// import '../constants.dart' show Constants;

enum ActionItems{
  GROUP_CHAT, ADD_FRIEND, QR_SCAN, PAYMENT, HELP
}

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

final List<Widget> toPages = [ GroupChat(), AddFriend()];

class IndexPage extends StatefulWidget { 
 //// IndexPage({this.token});
 // final String token;
  @override
   _IndexPage createState() => _IndexPage();
}

class _IndexPage extends State<IndexPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String> _token;
  AuthStatus authStatus = AuthStatus.NOT_LOGGED_IN;
  
   @override
   void initState() {
    super.initState();
       _token = _prefs.then((SharedPreferences prefs) {
           setState(() {
              authStatus =
                 prefs.getString('token') == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
           });
          return (prefs.getString('token') ?? null);
       });   
  }
/*
  void _onLoggedIn() {
       setState(() {
         authStatus = AuthStatus.LOGGED_IN;
       });
  }
*/
  _buildPopupMenuItem(Widget icon, String title){
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 12),
          child: icon,
        ),
        Text(title,style: TextStyle(color: Color(AppColors.AppBarPopupMenuTextColor)),)
      ],
    );
  }

  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      // icon: Icon(CupertinoIcons.home),
      icon: new Icon(ICons.MESSAGE_ACTIVE),
      title: Text('会话',style: TextStyle(fontSize: 14.0)),
      //activeIcon: new Icon(ICons.MESSAGE_ACTIVE)
    ),
    BottomNavigationBarItem(
      icon: new Icon(ICons.ADDRESSLIST),
      title: Text('通讯录',style: TextStyle(fontSize: 14.0)),
      activeIcon: new Icon(ICons.ADDRESSLIST_ACTIVE)
    ),
    BottomNavigationBarItem(
      icon: new Icon(ICons.DISCOVER),
      title: Text('游戏',style: TextStyle(fontSize: 14.0)),
      activeIcon: new Icon(ICons.DISCOVER_ACTIVE)
    ),
    BottomNavigationBarItem(
      icon: new Icon(ICons.MINE),
      title: Text('我',style: TextStyle(fontSize: 14.0)),
      activeIcon: new Icon(ICons.MINE_ACTIVE)
    )
  ];

  final List<Widget> tabBodies = [
    MessagePage(),
    ContactsPage(),
    DiscoverPage(),
    MinePage()
  ];

  
  _buildBody(BuildContext context, PageController _pageController, int index) {
    
   return PageView.builder(
        itemBuilder: (BuildContext context, int index){
          return tabBodies[index];
        },
        controller: _pageController,
        itemCount: tabBodies.length,
        onPageChanged: (int index){
            Provide.value<CurrentIndexProvide>(context).changeIndex(index);
        },
      );
 }

 _buildBottomNavigationBar(BuildContext context, PageController _pageController,int currentIndex, int index){
     return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              fixedColor: Color(AppColors.TabIconActive),
            
              items: bottomTabs,
              onTap: (index){
                Provide.value<CurrentIndexProvide>(context).changeIndex(index);
                _pageController.animateToPage(index,duration: Duration(milliseconds: 10),curve: Curves.easeInOut);
              },
             
            );
 }

 _buildGamePageTopBar(BuildContext context, PageController _pageController,int currentIndex){
    return WillPopScope(
          child: Scaffold(
            bottomNavigationBar: _buildBottomNavigationBar(context, _pageController, currentIndex, currentIndex),
              body:  _buildBody(context,  _pageController, currentIndex) ,                  
          ),
            onWillPop: (){ return _dialogExitApp(context);},
        );    
 }

 _buildMePageTopBar(List _title, BuildContext context, PageController _pageController,int currentIndex){
    return WillPopScope(
                child: Scaffold(
                  appBar: AppBar(
                    title: Text( _title[currentIndex] ,
                    style: TextStyle(fontSize: ScreenUtil().setSp(30.0),color: Color(AppColors.APPBarTextColor),),),
                    elevation: 0.0, //去掉appBar阴影
                    brightness: Brightness.light,
                    backgroundColor: Colors.white,
                    actions: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 2.0),
                        child: IconButton(
                          icon: Icon(Icons.photo_camera,color: Color(AppColors.APPBarTextColor),),
                          onPressed: (){
                            print('点击了搜索按钮');
                          },
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
                  bottomNavigationBar: _buildBottomNavigationBar(context, _pageController, currentIndex, currentIndex),
                   body:  _buildBody(context,  _pageController, currentIndex) ,                  
                ),
                  onWillPop: (){ return _dialogExitApp(context);},
              );
 }
 

 _buildCahtAndMailListPageTopBar(List _title, BuildContext context, PageController _pageController,int currentIndex){
    return WillPopScope(      
            child: Scaffold(          
            appBar: AppBar(
              title: Text( _title[currentIndex] ,style: TextStyle(fontSize: ScreenUtil().setSp(30.0),color: Color(AppColors.APPBarTextColor),),),
              elevation: 0.0, //去掉appBar阴影
              brightness: Brightness.light,
              backgroundColor: Color(AppColors.PrimaryColor),
              actions: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 16.0),
                  child: IconButton(
                    icon: Icon(ICons.SEARCH,color: Color(AppColors.APPBarTextColor),),
                    onPressed: (){
                      print('点击了搜索按钮');
                    },
                  ),
                ),
                Theme(
                  data: ThemeData(
                    cardColor: Color(AppColors.APPCardColor)
                    
                  ),
                  
                  child: PopupMenuButton(
                     
                    icon: Icon(ICons.ADD,color: Color(AppColors.APPBarTextColor),),
                    
                    itemBuilder: 
                    
                     (BuildContext context){
                   
                      //return <PopupMenuItem<ActionItems>>[
                      return <PopupMenuEntry<ActionItems>>[
                        PopupMenuItem(
                          child: _buildPopupMenuItem(Icon(ICons.GROUP_CHAT,size: 20.0,color: Color(AppColors.AppBarPopupMenuTextColor),),'发起群聊'),
                          value: ActionItems.GROUP_CHAT,
                        ),
                          PopupMenuDivider( height: 1.0, ),
                        PopupMenuItem(
                          child: _buildPopupMenuItem(Icon(ICons.ADD_FRIEND,size: 20.0,color: Color(AppColors.AppBarPopupMenuTextColor)),'添加朋友'),
                          value: ActionItems.ADD_FRIEND,
                        ),
                          PopupMenuDivider( height: 1.0, ),
                        PopupMenuItem(
                          child: _buildPopupMenuItem(Icon(ICons.QR_SCAN,size: 20.0,color: Color(AppColors.AppBarPopupMenuTextColor)),'扫一扫'),
                          value: ActionItems.QR_SCAN,
                        ),
                        /*
                        PopupMenuItem(
                          child: _buildPopupMenuItem(Icon(ICons.PAYMENT,size: 20.0,color: Color(AppColors.AppBarPopupMenuTextColor)),'收付款'),
                          value: ActionItems.PAYMENT,
                        ),
                        
                        PopupMenuItem(
                          child: _buildPopupMenuItem(Icon(ICons.HELP,size: 20.0,color: Color(AppColors.AppBarPopupMenuTextColor)),'帮助与反馈'),
                          value: ActionItems.HELP,
                        )*/
                      ];
                    },
                    onSelected: (selected){  
                      switch ( selected) { 
                          case ActionItems.GROUP_CHAT: 
                              //导航到新路由 :发起群聊  
                                Navigator.push( context,
                                    MaterialPageRoute(builder: (context) {
                                        return GroupChat();
                                    })
                                );
                              break;
                          case ActionItems.ADD_FRIEND:
                                //导航到新路由 :添加好友  
                                Navigator.push( context,
                                    MaterialPageRoute(builder: (context) {
                                        return AddFriend();
                                    })
                                );                    
                              break;
                      }
                     
                    },
                  ),
                )
              ], 
            ),
            backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
            bottomNavigationBar: _buildBottomNavigationBar(context, _pageController, currentIndex, currentIndex),
            body:  _buildBody(context,  _pageController, currentIndex) ,
             
          ),
          onWillPop: (){
            return _dialogExitApp(context);
          },          
        );
 }

  /// 单击提示退出
  Future<bool> _dialogExitApp(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
      content: new Text('确定要退出应用?'),
      actions: <Widget>[
        new FlatButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: new Text('取消', style: TextStyle(color: Colors.black54))),
        new FlatButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: new Text('确定', style: TextStyle(color: Colors.black54)))
      ],
    ));
  }
  @override
  Widget build(BuildContext context) {
    final List<String> _title = ["会话", "通讯录", "游戏", " "];
    final _pageController = PageController(initialPage:  Provide.value<CurrentIndexProvide>(context).currentIndex);

    ScreenUtil.instance = ScreenUtil(width: 750,height:1334)..init(context);//初始化屏幕分辨率

     switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return BuildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
         return SignIn();
       
        break;
      case AuthStatus.LOGGED_IN:
         if ( _token != null) {
            return Provide<CurrentIndexProvide>(
              builder: (context,child,val){
                int currentIndex = Provide.value<CurrentIndexProvide>(context).currentIndex;

            switch (currentIndex) {
                
                case 2:
                    return _buildGamePageTopBar(context,  _pageController, currentIndex);              
                    break;
                case 3:
                    return _buildMePageTopBar(_title,  context,  _pageController, currentIndex);
                    break;
                default:
                    return _buildCahtAndMailListPageTopBar( _title,  context,  _pageController, currentIndex);
                }
              },
            );
       } else return BuildWaitingScreen();
          break;
      default:
         return BuildWaitingScreen();
    }
  }
}