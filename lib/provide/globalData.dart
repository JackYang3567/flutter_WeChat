import 'package:flutter/material.dart';
import 'package:wechat/common/config.dart';

class GlobalDataProvide with ChangeNotifier{

  // 代理客户id 
	int	agentId = 0;

	// http 服务端地址 
	String httpUrl=  Config['http_url'];

  // 静态文件存放地址 
	String staticUrl=  Config['static_url'];

	// socket 服务端地址 
	String	socketUrl=  Config['socket_url'];
			
	// socket 连接状态 
	int	socketState= 0;

	// 好友申请通知 
	int	newFriendTipsNum= 0;

	// 群认证通知 
	int	newGroupTipsNum= 0;

	// 朋友圈通知 
	int	noReaderCircle= 0;

	// 朋友圈消息未读数 
	int	noReaderCircleChatNum= 0;

	// 缓存的数据 
	var	cache = {
      	// 个人头像缓存数据 
				'localPhoto': '',
			};

	// 用户信息 */
	var	_userInfo = {
				'id': 0,
				'nickname': '',
				'username': '',
				'photo': 'default_man/70.jpg',
				'doodling': '',
				'circleImg': 'default_circle_img.jpg?_=3.1415926',
			};
  get userInfo => _userInfo;
  void changeUserInfo(var newInfo){
         _userInfo = newInfo;
       notifyListeners();
  }



}