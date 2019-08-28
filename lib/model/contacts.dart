import 'package:flutter/material.dart';


//import 'package:wechat/common/dioHttpSend.dart';
//import 'package:wechat/common/config.dart';



class Contact{
  String avatar;
  String name;
  int userId;
  String nameIndex;
  VoidCallback onPressed;



  bool isAvatarFromNet(){
    if(this.avatar.indexOf('http') == 0 || this.avatar.indexOf('https') == 0) {
      return true;
    }
    return false;
  }

  Contact({
    this.avatar,
    this.name,
    this.userId,
    this.nameIndex,
    this.onPressed,
  }): assert(avatar != null),
      assert(name != null);

  static  List<Contact> contacts =[
    new Contact(
      avatar: 'http://http.767717.com:881/static/photo/user/4/70.jpg?_=0.9984976968558277',
      name: 'Maurice Sutton',
      userId: 4,
      nameIndex: 'M',
    ),
    new Contact(
      avatar: 'https://randomuser.me/api/portraits/women/76.jpg',
      name: 'Jerry',
      userId: 4,
      nameIndex: 'J',
    ),
    new Contact(
      avatar: 'https://randomuser.me/api/portraits/women/17.jpg',
      name: 'Dangdang',
       userId: 6,
      nameIndex: 'D',
    ),
    new Contact(
      avatar: 'https://randomuser.me/api/portraits/women/55.jpg',
      name: 'Teddy',
       userId: 7,
      nameIndex: 'T',
    ),
    new Contact(
      avatar: 'https://randomuser.me/api/portraits/women/11.jpg',
      name: 'Steave',
       userId: 22,
      nameIndex: 'S',
    ),
    new Contact(
      avatar: 'https://randomuser.me/api/portraits/women/65.jpg',
      name: 'Vivian',
       userId: 23,
      nameIndex: 'V',
    ),
    new Contact(
      avatar: 'https://randomuser.me/api/portraits/women/50.jpg',
      name: 'Mary',
       userId: 24,
      nameIndex: 'M',
    ),
    new Contact(
      avatar: 'https://randomuser.me/api/portraits/women/91.jpg',
      name: 'David',
       userId: 2,
      nameIndex: 'D',
    ),
    new Contact(
      avatar: 'https://randomuser.me/api/portraits/women/60.jpg',
      name: 'Bob',
       userId: 3,
      nameIndex: 'B',
    ),
    new Contact(
      avatar: 'https://randomuser.me/api/portraits/men/60.jpg',
      name: 'Jeff Green',
       userId: 4,
      nameIndex: 'J',
    ),
    new Contact(
      avatar: 'http://http.767717.com:881/static/photo/user/14/50.jpg?_=0.15341350084216288',
      name: 'Adam',
       userId: 4,
      nameIndex: 'A',
    ),
    new Contact(
      avatar: 'https://randomuser.me/api/portraits/men/7.jpg',
      name: 'Michel',
       userId: 4,
      nameIndex: 'M',
    ),
    new Contact(
      avatar: 'https://randomuser.me/api/portraits/men/35.jpg',
      name: 'Green',
       userId: 4,
      nameIndex: 'G',
    ),
    new Contact(
      avatar: 'https://randomuser.me/api/portraits/men/64.jpg',
      name: 'Jack Ma',
       userId: 4,
      nameIndex: 'J',
    ),
    new Contact(
      avatar: 'https://randomuser.me/api/portraits/men/86.jpg',
      name: 'Tom',
       userId: 4,
      nameIndex: 'T',
    ),
    new Contact(
      avatar: 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537868900176&di=ddbe94a75a3cc33f880a5f3f675b8acd&imgtype=0&src=http%3A%2F%2Fs2.sinaimg.cn%2Fmw690%2F003wRTwMty6IGZWzd2p31',
      name: '张伟',
       userId: 4,
      nameIndex: 'Z',
    ),
    new Contact(
      avatar: 'https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1537858866&di=fe35e4465c73122f14e1c9475dd68e47&src=http://a2.att.hudong.com/63/26/01300001128119143503262347361.jpg',
      name: '张益达',
       userId: 4,
      nameIndex: 'Z',
    ),
    new Contact(
      avatar: 'http://http.767717.com:881/static/photo/user/7/70.jpg?_=0.9984976968558277',
      name: '01234',
      userId: 4,
      nameIndex: '#',
       onPressed: (){
        print('01234');
      },
    ),
  ];
}

class ContactEventItem{
  String avatar;
  String name;
  int userId;
  VoidCallback onPressed;

  ContactEventItem({
    @required this.avatar,
    @required this.name,
    @required this.userId,
   // @required this.onPressed,
  });
}