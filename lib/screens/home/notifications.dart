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
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(title: const Text("알림")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => setIsNotice(),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                padding: EdgeInsets.symmetric(horizontal: isNoticePermit? 20 : 40),
                height: isNoticePermit ? 60 : 100,
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
                    const SizedBox(width: 12),
                    Text("알림설정",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: isNoticePermit? Colors.black87 : Colors.black54
                      ),
                    ),
                    const Spacer(),
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
                child: const Align(
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
                        detailDialog(context, details[index]);
                      }else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text("상세내역을 찾지 못했습니다."),
                            duration: const Duration(seconds: 3), 
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
                    margin: const EdgeInsets.all(1),
                    child: Stack(
                      children:[Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notifications[i]['title'], 
                              style: const  TextStyle(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.justify,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 4,),
                            Text(
                              notifications[i]['content'], 
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.justify,
                              maxLines: 2,
                            ),
                            const SizedBox(height: 4,),
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
      return const SizedBox.shrink();
    }
  }

  notificationDialog(int i) {
    Row setContent(String title, String content){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title),Text(content)]
      );
    }
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog.fullscreen(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context)),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('텔레마케팅 데이터 판매', style: fontSmallTitle),
                  const SizedBox(height: 15),
                  setContent("구매자", notifications[i]["tmdata"]["buyer"]),
                  setContent("연락처", notifications[i]["tmdata"]["cotact"]),
                  setContent("접수일시", notifications[i]["date"]),
                  const SizedBox(height: 20),
                  setContent("상태", notifications[i]["tmdata"]["state"]),
              ]),
            ),
          ]
        ),
      ),
    );
    
  }
}