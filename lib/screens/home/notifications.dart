import 'package:data_project/provider/setting_provider.dart';
import 'package:data_project/screens/home/home.dart';
import 'package:data_project/screens/setting/setting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'detail_dialog.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List notifications = List.empty(growable: true);
  int newNoticesCount = 0;

  @override
  void initState(){
    super.initState();
    setState(() {
      notifications = context.read<SettingProvider>().notices;
      context.read<SettingProvider>().setHasNewNotice(false);
      newNoticesCount = context.read<SettingProvider>().newNoticesCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        title: Text("알림", style: TextStyle(fontWeight: FontWeight.bold,)),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new,),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingScreen()));},
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 28),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [BoxShadow(
                  color: Colors.grey.withOpacity(.6),
                  blurRadius: 6,
                  spreadRadius : 1,
                  offset: Offset(2, 4)
                ),],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.notifications_on,
                        size: 28,
                        color: Colors.deepPurple,
                      ),
                      SizedBox(width: 12),
                      Text(
                        "알림설정",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black87
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios),
                ]
              ),
            ),
          ),
          if (notifications.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("알림이 없습니다.")))
          else
            for(int i = notifications.length-1; i > -1; i--)
              InkWell(
                onTap: (){
                  if(notifications[i]["type"] == "tele"){
                    notificationDialog(i);
                  }else if (notifications[i]["type"] == "normal"){
                    int index = 0;
                    String id = notifications[i]["id"];
                    List<Map> details = context.read<SettingProvider>().details;
                    for (var detail in details) {
                      if(detail.containsValue(id)){
                        break;
                      }
                      index++;
                    }
                    if (index < details.length) {
                      detailDialog(context, index, details);
                    }else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("상세내역을 찾지 못했습니다."),
                          duration: Duration(seconds: 3), 
                          action: SnackBarAction(
                            label: 'Close',
                            onPressed: (){},
                          ),
                        )
                      );
                    }
                  }
                },
                child: Card(
                  margin: EdgeInsets.all(1),
                  child: Stack(
                    children:[Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notifications[i]['title'], 
                            style: TextStyle(
                              fontWeight: FontWeight.bold, 
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                            maxLines: 1,
                          ),
                          SizedBox(height: 4,),
                          Text(
                            notifications[i]['content'], 
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.justify,
                            maxLines: 2,
                          ),
                          SizedBox(height: 4,),
                          Text(
                            notifications[i]['date'],
                            style: TextStyle(
                              color: Color.fromARGB(255, 132, 132, 132),
                            ),
                          ),
                        ],
                      ),
                    ),
                    setBadge(),
                    ]
                  ),
                ),
              ),
          TextButton(
            onPressed: (){
              setState(() {
                context.read<SettingProvider>().clearNotice();
              });
            }, 
            child: Text("/test\ndel all",
              style: TextStyle(color: Colors.grey.shade400, 
                decoration: TextDecoration.underline
            ))
          )
        ]
      )
    );
  }

  setBadge(){
    if (newNoticesCount > 0){
      newNoticesCount--;
      return Positioned(
        right: 12,
        top: 12,
        child: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(4)
      )));
    }else {
      context.read<SettingProvider>().countNewNotice(false);
      return SizedBox.shrink();
    }
  }

  notificationDialog(int i) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog.fullscreen(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(
              onPressed: (){
                Navigator.pop(context);
              }, 
              icon: Icon(Icons.close)
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('텔레마케팅 데이터 판매', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('구매자'),
                      Text(notifications[i]["tmdata"]["buyer"]),
                    ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('연락처'),
                      Text(notifications[i]["tmdata"]["cotact"]),
                    ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('접수일시'),
                      Text(notifications[i]["date"]),
                    ],),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('상태'),
                      Text(notifications[i]["tmdata"]["state"]),
                    ],),
                ]),
            ),
          ]
        ),
      ),
    );
  }
}