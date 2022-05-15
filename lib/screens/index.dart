import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settelin/screens/group.dart';
import 'package:settelin/screens/home.dart';
import 'package:settelin/screens/notification.dart';
import 'package:settelin/screens/profile.dart';
import 'package:settelin/screens/reel.dart';

import '../constant/string.dart';
import 'custom_bottom_navigation.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _selectedItem = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    GroupPage(),
    ReelPage(),
    NotificationPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:  const Center(child: Align(alignment:Alignment.topLeft,child: Text(title,style: TextStyle(color: Colors.purple,fontSize: 26),))),
        actions: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.grey[100],
            child: IconButton(
              icon: const Icon(Icons.search,color: Colors.grey,size: 20,),
              tooltip: search,
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text(searchPart)));
              },
            ),
          ),
          const SizedBox(width: 10,),
          CircleAvatar(
            backgroundColor: Colors.grey[100],
            child: IconButton(
              icon: const Icon(Icons.mail_outline,color: Colors.grey,),
              tooltip: yourNotification,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text(notificationPart)));
              },
            ),
          ),
          const SizedBox(width: 10,),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        iconList: const [
          Icons.view_comfortable_sharp,
          Icons.group_work_outlined,
          Icons.video_collection_outlined,
          Icons.notifications_outlined,
          Icons.person_outline,
        ],
        onChange: (val) {
          setState(() {
            _selectedItem = val;
          });
        },
        defaultSelectedIndex: 0,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedItem),
      ),
    );
  }
}
