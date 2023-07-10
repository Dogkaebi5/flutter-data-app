import 'dart:convert';

import 'package:data_project/data/new_user_storage.dart';
import 'package:data_project/data/password_setter.dart';
import 'package:data_project/data/user_data_setter.dart';
import 'package:data_project/screens/home/home_dialog.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:data_project/screens/home/notifications.dart';
import 'package:data_project/screens/setting/setting.dart';
import 'package:data_project/screens/point/withdraw.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String jsonString = ''' 
    { "details": 
      [{
        "title": "데이터 판매",
        "id": "10000",
        "type": "리워드",
        "date": "2023-01-01 23:59:59",
        "point": "+ 20,000 P",
        "buyer": "(주)테스트회사",
        "info": ["닉네임", "연령층",  "이메일", "성함", "휴대폰", "성별","출생연도","결혼정보","자녀정보","최종학력","직업","소득수준","거주지역","관심사 1","관심사 2","관심사 3"]
      },
      {
        "title": "텔레마케팅 판매",
        "id": "20000",
        "type": "리워드",
        "date": "2023-01-01 23:59:59",
        "point": "+ 20,000 P",
        "buyer": "(주)테스트회사",
        "info": ["닉네임", "연령층",  "이메일", "성함", "휴대폰","텔레마케팅","성별","출생연도","결혼정보","자녀정보","최종학력","직업","소득수준","거주지역","관심사 1"]
      },
      {
        "title": "출금",
        "id": "30000",
        "type": "출금",
        "date": "2023-01-01 23:59:59",
        "point": "- 10,000 P",
        "withdraw": "10,000 P",
        "fee": "0 P",
        "tax": "660 원",
        "amount": "9,340 원",
        "account": ["홍길동", "카카오뱅크 3333123456789"],
        "status" : "접수"
      }
      ],

      "bank": {
        "username": "홍길동",
        "accountNum": "3333161234567",
        "bank": "카카오뱅크"
      },

      "point": "40000"
    }
  ''';
  List newDetails = List.empty(growable: true);
  int point = 0;
  Map bank = {};

  List<bool> _selections = [true, false];
  DateTime signUpDate = DateTime(2023, 1, 1);
  DateTime today = DateTime.now();
  String sortStartDate ="2023-01-01";
  String sortEndDate ="2023-01-31";
  
  setSortDateText(selectStartDate, selectEndDate){
    setState((){
      sortStartDate = selectStartDate;
      sortEndDate = selectEndDate;
    });
  }
  
  @override
  void initState(){
    super.initState();
    setState(() {
      Map jsonData = jsonDecode(jsonString);
      newDetails = jsonData["details"];
      point = int.parse(jsonData["point"]);
      bank = jsonData["bank"];
    });
    changeSortTextToMonth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("데이플러스"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationPage()),
              );
            }, 
            icon: Icon(Icons.notifications)
          ),
          IconButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingPage()),
              );
            }, 
            icon: Icon(Icons.settings)
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(left:20, right:20,),
        child: Column(
          children: [
            //포인트 표기
            Center(
              heightFactor: 3,
              child: Text("$point P", style: TextStyle(fontSize: 28),)
            ),
            //출금신청 링크
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Withdraw(point, bank)),
                );
              },
              child: Container(
                padding: EdgeInsets.all(20),
                color: const Color.fromARGB(255, 194, 226, 241) ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [Text("출금신청"), Icon(Icons.arrow_forward_ios),
                ]),
              ),
            ),
            Divider(thickness: 2,),
            
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //소팅선택
                ToggleButtons(
                  isSelected: _selections,
                  onPressed: (index) {
                    setState(() {
                      _selections = [false, false];
                      _selections[index] = !_selections[index];
                    });
                    if (index == 1) {
                      showDatePickerDialog();
                    } else {
                      changeSortTextToMonth();
                    }
                  },              
                  children: const [
                    SizedBox(
                      width: 164,
                      child: Text("1개월", textAlign: TextAlign.center,)
                    ),
                    SizedBox(
                      width: 164,
                      child: Text("직접입력", textAlign: TextAlign.center,)
                    ),
                  ],
                ),
                SizedBox(height: 8,),
                
                if(_selections[1])
                  Text(
                    '검색기간 : $sortStartDate ~ $sortEndDate', 
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),  
                  ),
              ],
            ),
            SizedBox(height: 20,),

            //디테일 링크
            if(newDetails.length < 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [Text("기록이 없습니다.")],
              )
              else 
                for(var i = 0; i < newDetails.length; i++)
                  createDetailCards(i),
            Spacer(),
            TextButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              child: Text("로그아웃")
            ),
            TextButton(
              onPressed: () {
                PasswordStorage().writePassword("");
              },
              child: Text("비번del"),
            ),
            TextButton(
              onPressed: () {
                PasswordStorage().writePassword("");
                UserBasicDataStorage().writeData("");
                NewUserStorage().write("");
              },
              child: Text("reset"),
            ),
          ]
        ),
      )
    );
  }
  
  void changeSortTextToMonth(){
    String monthAgo = today.subtract(Duration(days:30)).toString().split(' ')[0];
    String todayDate = today.toString().split(' ')[0];
    setSortDateText(monthAgo, todayDate);
  }

  showDatePickerDialog()=>
    showDialog(
      context: context, 
      builder: (BuildContext context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) => Dialog(
          child: 
          SfDateRangePicker(
            selectionMode: DateRangePickerSelectionMode.range,
            showActionButtons: true,
            maxDate: DateTime.now(),
            minDate: signUpDate,
            onCancel: () => Navigator.pop(context),
            onSubmit: (p0) {
              if (p0 == null) {
                Navigator.pop(context);
              }else {
                String selectSta = p0.toString().split(' ')[1];
                var selectEnd = p0.toString().split(' ')[4];
                if (selectEnd == 'null)'){
                  setSortDateText(selectSta, selectSta);
                }else {
                  setSortDateText(selectSta, selectEnd);
                }
              Navigator.pop(context);
              }
            }
          ),
        )
      )
    );

  createDetailCards(int loopInt){
    return InkWell(
      onTap: () => detailDialog(context, loopInt, newDetails), 
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(12),
        color: const Color.fromARGB(255, 194, 226, 241) ,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(newDetails[loopInt]['title'] + "  " + newDetails[loopInt]['point'],),
                SizedBox(height: 4,),
                Text(
                  newDetails[loopInt]['date'].split(' ')[0], 
                  style: TextStyle(
                    color: Colors.black45, 
                    fontSize: 12
                  ),
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios),
        ]),
      ),
    );
  }
}