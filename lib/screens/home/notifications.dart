import 'dart:convert';

import 'package:data_project/screens/home/home.dart';
import 'package:data_project/screens/setting/setting.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String jsonString = ''' 
    { "notification": 
      [
        {
        "id": "20000",
        "type": "tele", 
        "title": "[데이플러스] 텔레마케팅 접수 안내",
        "content": "텔레마케팅 구매가 접수되었습니다. 업체의 마케팅 전화를 유의하세요.",
        "date": "2023.01.01 23:59:59",
        "tmdata": 
          {
            "buyer": "(주)테스트회사",
            "cotact": "02)1234-5678",
            "state": "거래접수"
          }
        },
        {
        "id": "10000",
        "type": "normal", 
        "title": "[데이플러스] 리워드 안내",
        "content": "판매 접수된 정보가 구매 확정되어 포인트가 적립되었습니다!",
        "date": "2023.01.01 23:59:59"
        }
      ]
    }
  ''';

  List notifications = List.empty(growable: true);

  @override
  void initState(){
    super.initState();
    setState(() {
      Map jsonData = jsonDecode(jsonString);
      notifications = jsonData["notification"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("알림"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top:30, left:20, right:20,),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingPage()));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.all(20),
                color: const Color.fromARGB(255, 194, 226, 241) ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Row(
                      children: [
                        Icon(Icons.notifications_on),
                        SizedBox(width: 8),
                        Text(
                          "알림설정",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,  
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ]
                ),
              ),
            ),
            Divider(thickness: 1,),

            for(var i = 0; i < notifications.length; i++)
              InkWell(
                onTap: () => notificationDialog(i),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(12),
                  color: const Color.fromARGB(255, 194, 226, 241) ,
                  child: 
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                      Column(
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
                    //   Container(
                    //     width: 10,
                    //     height: 10,
                    //     decoration: BoxDecoration(
                    //       color: Colors.red,
                    //       shape: BoxShape.circle,
                    //     ),
                    //   ),
                    // ]
                  // ),
                ),
              ),
          ]
        ),
      )
    );
  }

  notificationDialog(int i) {
    if (notifications[i]['type'] == "tele") {
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
    }else if(notifications[i]['type'] == "normal"){
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }
}