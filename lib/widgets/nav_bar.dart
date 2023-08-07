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
        margin: const EdgeInsets.only(bottom: 12, left: 8, right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 1).withOpacity(.6),
            blurRadius: 6,
            spreadRadius : 1,
            offset: const Offset(2, 4)
          ),],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            items:[
              const BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
              BottomNavigationBarItem(
                icon: (hasNewNotice) 
                  ?Stack(children: [
                    const Icon(Icons.notifications),
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
                  :const Icon(Icons.notifications),
                label: "알림"
              ),
              const BottomNavigationBarItem(icon: Icon(Icons.settings), label: "설정")
            ],
          selectedItemColor: const Color.fromRGBO(255, 255, 255, 1),
          backgroundColor: const Color.fromRGBO(103, 58, 183, 1),
          currentIndex: currentIndex,
          unselectedItemColor: const Color.fromRGBO(179, 157, 219, 1),
          
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