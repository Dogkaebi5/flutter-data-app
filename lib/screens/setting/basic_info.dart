import 'dart:convert';

import 'package:data_project/provider/new_user_provider.dart';
import 'package:data_project/provider/user_basic_data_provider.dart';
import 'package:data_project/screens/setting/data_setting.dart';
import 'package:data_project/screens/setting/interest_info.dart';
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
      "option" : ["관리직", "사무직", "학생", "무직"]
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
  bool isNewUser = true;
  String? userNickname, userEmail;
  String? married, childHas, education, occupation, income, residence;
  String? marriedDate, childHasDate, educationDate, occupationDate, incomeDate, residenceDate;
  List basicInfoList = List.empty(growable: true);
  List<String?> selectedList = List.empty(growable: true);
  List dateList = List.empty(growable: true);
  UserBasicData userData = UserBasicData();

  @override
  void initState(){
    super.initState();
    setState(() {
      Map mapBasicData = jsonDecode(jsonBasicDataSelect);
      basicInfoList = mapBasicData["basicInfo"];
      userData = context.read<UserBasicData>();
      isNewUser = context.read<NewUserProvider>().isNewUser;
      userNickname = userData.nickname;
      userEmail = userData.email;
      
      if (isNewUser) {
        selectedList = List.filled(basicInfoList.length, married);
        dateList = List.filled(basicInfoList.length, marriedDate);
      }else{
        selectedList = List.from(userData.selected);
        dateList = List.from(userData.selectedDate);
      }
      //temporary reader
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future(() => true),
      // => Future(() => false), 
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal:24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40,),
                  Row(
                    children: [
                      Icon(Icons.info, color: Colors.deepPurple.shade400, size: 32,),
                      SizedBox(width: 8,),
                      Text("기본정보",
                        style: TextStyle(
                          color: Colors.deepPurple.shade400,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                      ),),
                  ],),
                  SizedBox(height: 4,),
                  Text('정보가 많을 수록 더 많은 리워드를 받을 수 있습니다.',),
                  
                  SizedBox(height: 28,),
                  createTextInput("닉네임", userNickname),
                  SizedBox(height: 20,),
                  createTextInput("이메일", userEmail),
                  
                  SizedBox(height: 40,),
                  Text('※ 아래 입력된 정보는 3개월간 수정 불가합니다.',
                    style: TextStyle(color: Colors.deepPurple.shade400),
                  ),
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
                    height: 44,
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
          ),
        )
      ),
    );
  }
  
  saveBasicData(){
    userData.setNickname(userNickname!);
    userData.setEmail(userEmail!);
    userData.setMarried(selectedList[0], dateList[0]);
    userData.setChildHas(selectedList[1], dateList[1]);
    userData.setEducation(selectedList[2], dateList[2]);
    userData.setOccupation(selectedList[3], dateList[3]);
    userData.setIncome(selectedList[4], dateList[4]);
    userData.setResidence(selectedList[5], dateList[5]);
    //temporary writer
  }

  createTextInput(title, initValue)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title, 
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      SizedBox(height: 6,),
      TextFormField(
        initialValue: initValue, 
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.all(12),
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
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color.fromARGB(92, 209, 196, 233),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left:8, right:8),
                  child: DropdownButton(
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
                ),
              ],
            ),
          ),
          SizedBox(height: 8,)
        ],
      )
    );
  }
}