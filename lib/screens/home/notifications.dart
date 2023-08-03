import 'package:data_project/provider/setting_provider.dart';
import 'package:data_project/widgets/widget_style.dart';
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
  bool isNoticeService = false;
  bool isNoticeMarketing = false;
  bool isNoticePermit = false;

  void setIsNotice(){
    setState(() {
      isNoticePermit = !isNoticePermit;
    });
    context.read<SettingProvider>().setNoticeService(isNoticePermit);
    context.read<SettingProvider>().setNoticeMarket(isNoticePermit);
  }

  @override
  void initState(){
    super.initState();
    setState(() {
      notifications = context.read<SettingProvider>().notices;
      context.read<SettingProvider>().setHasNewNotice(false);
      newNoticesCount = context.read<SettingProvider>().newNoticesCount;
      isNoticeService = context.read<SettingProvider>().isNotice[0];
      isNoticeMarketing = context.read<SettingProvider>().isNotice[1];
      isNoticePermit = (isNoticeService && isNoticeMarketing)?true:false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(title: Text("알림")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => setIsNotice(),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                padding: EdgeInsets.symmetric(horizontal: isNoticePermit? 20 : 40),
                height: isNoticePermit ? 40 : 100,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [greyShadow],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.notifications_on,
                      size: 28,
                      color: isNoticePermit? Colors.deepPurple : Colors.grey,
                    ),
                    SizedBox(width: 12),
                    Text("알림설정",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: isNoticePermit? Colors.black87 : Colors.black54
                      ),
                    ),
                    Spacer(),
                    Switch(
                      value: isNoticePermit, 
                      onChanged: (value) => setIsNotice()
                    )
                  ],
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
                        if(detail.containsValue(id)){ break; }
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
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                              style: fontSmallGrey,
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
              onPressed: () => setState(() => context.read<SettingProvider>().clearNotice()),
              child: Text("/test\ndel all", style: testBtnStyle)
            )
          ]
        ),
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
                  Text('텔레마케팅 데이터 판매', style: fontSmallTitle),
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