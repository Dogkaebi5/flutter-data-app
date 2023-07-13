import 'dart:convert';

import 'package:data_project/provider/new_user_provider.dart';
import 'package:data_project/provider/user_interest_data_provider.dart';
import 'package:data_project/screens/setting/additional_info.dart';
import 'package:data_project/screens/setting/data_setting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Interest extends StatefulWidget {
  const Interest({super.key});
  @override
  State<Interest> createState() => _InterestState();
}

String jsonUserInterest = '''{
  "보험설계": "false", 
  "대출": "false", 
  "예금/적금": "false", 
  "부동산": "false", 
  "주식": "false", 
  "가상자산": "false", 
  "골프": "false", 
  "테니스": "false", 
  "피트니스": "false", 
  "요가": "false", 
  "건강식품": "false", 
  "교육": "false", 
  "육아용품": "false", 
  "자동차": "false", 
  "국내여행": "false", 
  "해외여행": "false", 
  "캠핑": "false", 
  "낚시": "false", 
  "반려동물": "false"
}''';

class _InterestState extends State<Interest> {
  bool isNewUser = false;
  List<String> interestList = List.empty(growable: true);
  List isSelectedList = List.empty(growable: true);
  List selectedList = List.empty(growable: true);
  List selectedDate = List.empty(growable: true);
  int selectedCount = 0;
  UserInterestData userData = UserInterestData();

  @override
  void initState(){
    super.initState();
    setState(() {
      isNewUser = context.read<NewUserProvider>().isNewUser;
      userData = context.read<UserInterestData>();
      Map jsonData = jsonDecode(jsonUserInterest);
      jsonData.forEach((key, value) => interestList.add(key));
      isSelectedList = userData.isSelectedList;
      selectedList = userData.selectedList;
      selectedDate = userData.dateList;
      selectedCount = userData.interestCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('관심사'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20, left:20, right:20,),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('관심사를 최대 3개 선택하세요.'),
              Text('선택된 정보는 3개월간 수정 불가합니다.'),
              SizedBox(
                height: 88,
                child: createInterestListText(),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical:10),
                width: double.infinity,
                child:
                  Wrap(
                    direction: Axis.horizontal, 
                    children: [
                      for(var i = 0; i < interestList.length; i++)
                        createInterstCard(i)
                    ],
                  ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: (){
                    saveInterestData();
                    if(isNewUser){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddInfo()),
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
              Spacer(),
            ],
          )
        ),
      ),
    );
  }

  saveInterestData(){
    userData.setIsSelectedList(isSelectedList);
    userData.setSelecedList(selectedList);
    userData.setdateList(selectedDate);
    userData.setCount(selectedCount);
  }

  createInterestListText(){
    if(selectedCount>0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for(var i = 0; i < selectedList.length; i++)
            Row(children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(selectedList[i]),
              ),
              Spacer(),
              Text('저장 유지기간 : ~ ${selectedDate[i]}'),
            ],),
        ],
      );
    }
  }
  createInterstCard(i){
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(2),
        height: 60,
        width: 110,
        child: 
        Card(
          color: isSelectedList[i]? Color.fromARGB(255, 142, 57, 246) : Colors.white,
          child: Center(
            child:
              isSelectedList[i] ? 
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text((interestList[i]), style: TextStyle(color: Colors.white,),),
                    Icon(Icons.close, color: Colors.white, size: 16,),
                  ]),
              )
              : Text(
              interestList[i],
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      onTap: (){
        String after30days = DateTime.now().add(Duration(days: 30)).toString().split(" ")[0];
        setState(() {
          if(selectedList.contains(interestList[i])){
            isSelectedList[i] = false;
            selectedList.remove(interestList[i]);
            selectedCount --;
          }else if(selectedCount < 3){
            isSelectedList[i] = true;
            selectedList.add(interestList[i]);
            selectedDate.add(after30days);
            selectedCount ++;
          }
        });
      }
    );
  }
}