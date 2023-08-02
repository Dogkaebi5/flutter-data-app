import 'package:data_project/provider/setting_provider.dart';
import 'package:data_project/screens/home/notifications.dart';
import 'package:data_project/screens/setting/setting.dart';
import 'package:data_project/widgets/widget_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool hasNewNotice = false;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    hasNewNotice = context.read<SettingProvider>().hasNewNotice;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        margin: EdgeInsets.only(bottom: 12, left: 8, right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [BoxShadow(
            color: Colors.black.withOpacity(.6),
            blurRadius: 6,
            spreadRadius : 1,
            offset: Offset(2, 4)
          ),],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            items:[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
              BottomNavigationBarItem(
                icon: (hasNewNotice) 
                  ?Stack(children: [
                    Icon(Icons.notifications),
                    Positioned(
                      top: 2,
                      right: 2,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    )
                  ],) 
                  :Icon(Icons.notifications),
                label: "알림"
              ),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: "설정")
            ],
          selectedItemColor: Colors.white,
          backgroundColor: Colors.deepPurple,
          currentIndex: currentIndex,
          unselectedItemColor: Colors.deepPurple.shade200,
          
          onTap: (index){
            switch(index){
              case 0 : break;
              case 1 : navPush(context, NotificationScreen());
              case 2 : navPush(context, SettingScreen());
            }
          },
        ),
      ),
    );
  }
}