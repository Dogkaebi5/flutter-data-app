import 'dart:convert';

import 'package:data_project/data/user_data_setter.dart';
import 'package:data_project/provider/user_data_provider.dart';
import 'package:data_project/screens/setting/data_setting.dart';
import 'package:data_project/screens/setting/interest_info.dart';
import 'package:data_project/testpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BasicInfo extends StatefulWidget {
  const BasicInfo({super.key});

  @override
  State<BasicInfo> createState() => _BasicInfoState();
}

String jsonBasicDataSelect = '''{
  "basicInfo": [
    {
      "title": "결혼여부",
      "option" : ["미혼", "기혼"]
    },
    {
      "title": "자녀유무",
      "option" : ["없음", "있음"]
    },
    {
      "title": "최종학력",
      "option" : ["고졸 및 이하", "전문대", "대학", "대학원"]
    },
    {
      "title": "직종",
      "option" : ["관리직", "사무직"]
    },
    {
      "title": "소득수준",
      "option" : ["3000만 이하","3000만~5000만","5000만~1억", "1억 이상"]
    },
    {
      "title": "거주지역(도/시)",
      "option" : ["서울", "부산", "대구", "인천", "광주", "대전", "울산", "세종", "경기", "강원", "충청남", "충청북", "전라북", "전라남", "경상북", "경상남", "제주"]
    }]
}''';

class _BasicInfoState extends State<BasicInfo> {
  List basicInfoList = List.empty(growable: true);
  List<String?> selectedList = List.empty(growable: true);
  String? selected1, selected2, selected3, selected4, selected5, selected6;
  List dateList = List.empty(growable: true);
  String? date1, date2, date3, date4, date5, date6;
  String? userNickname;
  String? userEmail;
  bool isNewUser = true;

  @override
  void initState(){
    super.initState();
    setState(() {
      Map mapBasicData = jsonDecode(jsonBasicDataSelect);
      basicInfoList = mapBasicData["basicInfo"];
      isNewUser = context.read<NewUserProvider>().isNewUser;

      if (isNewUser) {
        userNickname = "홍길동";
        userEmail = "email@example.com";
        selectedList = [selected1, selected2, selected3, selected4, selected5, selected6];
        dateList = [date1, date2, date3, date4, date5, date6]; 
      }else{
        userNickname = "홍길순";
        userEmail = "eeemail@example.com";
        selectedList = List.filled(basicInfoList.length, selected1);
        dateList = List.filled(basicInfoList.length, date1);
      }
      //temporary reader
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('기본정보'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('정보가 많을 수록 더 많은 리워드를 받을 수 있습니다.'),
              SizedBox(height: 40,),
              createTextInput("닉네임", userNickname),
              SizedBox(height: 20,),
              createTextInput("이메일", userEmail),
              
              SizedBox(height: 40,),
              Text('아래 입력된 정보는 3개월간 수정 불가합니다.'),
              SizedBox(height: 40,),
              
              for (int i = 0; i < basicInfoList.length; i++)
                createBasicDataDropDown(
                  basicInfoList[i]['title'],
                  basicInfoList[i]['option'], 
                  i
                ),
              
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: (){
                    saveBasicData();
                    if(isNewUser){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Interest()),
                      );
                    }else{
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DataPage()),
                      );
                    }
                  }, 
                  child: Text('확인 저장')
                ),
              ),
            ],
          ),
        ),
      )
      
    );
  }
  
  saveBasicData(){
    String newData = '''
    {
      "nickname": "$userNickname",
      "email": "$userEmail",
      "data": "$selectedList",
      "date": "$dateList"
    }
    ''';
    UserBasicDataStorage().writeData(newData);
    //temporary writer
  }

  createTextInput(title, initValue)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title, 
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),
      ),
      SizedBox(height: 4,),
      TextFormField(
        initialValue: initValue, 
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.all(10),
        ),
        onChanged: (value) {
          (title == "닉네임")
          ?userNickname= value 
          :userEmail = value;
        },
      ),
    ],
  );

  createBasicDataDropDown(String title, List list, int i){ 
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          DropdownButton(
            isExpanded: true,
            value: selectedList[i],
            items: list.map((e)=> DropdownMenuItem(
              value: e,
              child: Text(e),
            )).toList(), 
            onChanged: (value) {
              setState((){
                selectedList[i] = value as String?;
                dateList[i] = DateTime.now().toString().split(" ")[0];
              });
            }
          ),
            SizedBox(height: 24,),
        ],
      )
    );
  }
}