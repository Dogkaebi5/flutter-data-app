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
  "보험설계": "false", "대출": "false", "예금/적금": "false", 
  "부동산": "false", "주식": "false", "가상자산": "false", 
  "골프": "false", "테니스": "false", "피트니스": "false", 
  "요가": "false", "건강식품": "false", "교육": "false", 
  "육아용품": "false", "자동차": "false", "국내여행": "false", 
  "해외여행": "false", "캠핑": "false", "낚시": "false", 
  "반려동물": "false"
}''';

class _InterestState extends State<Interest> {
  bool isNewUser = false;
  List<String> interestList = List.empty(growable: true);
  List isSelectedList = List.empty(growable: true);
  List selectedList = List.empty(growable: true);
  List selectedDate = List.empty(growable: true);
  List permissions = List.empty(growable: true);
  int selectedCount = 0;
  UserInterestData userData = UserInterestData();

  @override
  void initState(){
    super.initState();
    setState(() {
      Map jsonData = jsonDecode(jsonUserInterest);
      jsonData.forEach((key, value) => interestList.add(key));

      isNewUser = context.read<NewUserProvider>().isNewUser;
      userData = context.read<UserInterestData>();
      isSelectedList = userData.isSelectedList;
      selectedList = userData.selectedList;
      selectedDate = userData.dateList;
      selectedCount = userData.interestCount;
      permissions = userData.interestPermissions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future(() => true),
      // false),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal:24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40,),
                Row(
                  children: [
                    Icon(Icons.interests, color: Colors.deepPurple.shade400, size: 32,),
                    SizedBox(width: 8,),
                    Text("관심사",
                      style: TextStyle(
                        color: Colors.deepPurple.shade400,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                    ),),
                ],),
                SizedBox(height: 4,),
                Text('관심사를 최대 3개 선택하세요.'),
                SizedBox(height: 2,),
                Text('선택된 정보는 3개월간 수정 불가합니다.'),
                SizedBox(height: 4,),
                Container(
                  padding: EdgeInsets.all(12),
                  height: 108,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(39, 104, 58, 183),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: createInterestListText(),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical:10),
                  width: double.infinity,
                  child:
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        for(var i = 0; i < interestList.length; i++)
                          createInterstCard(i)
                      ],
                    ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: (){
                      saveInterestData();
                      setAddselectInit();
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
            ),
          ),
        ),
      ),
    );
  }

  saveInterestData(){
    userData.setIsSelectedList(isSelectedList);
    userData.setSelecedList(selectedList);
    userData.setdateList(selectedDate);
    userData.setCount(selectedCount);
    userData.setInterestpermissions(permissions);
  }
  setAddselectInit(){

  }

  createInterestListText(){
    if(selectedCount>0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for(var i = 0; i < selectedList.length; i++)
            Row(children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(selectedList[i], 
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 16,
                ),),
              ),
              Spacer(),
              Text('저장 유지기간 : ~ ${selectedDate[i]}',),
            ],),
        ],
      );
    }
  }
  createInterstCard(i){
    return InkWell(
      child: SizedBox(
        height: 60,
        width: 110,
        child: 
        Card(
          color: isSelectedList[i]? Colors.deepPurple : Colors.white,
          child: Center(
            child:
              isSelectedList[i] ? 
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text((interestList[i]), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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
            permissions.removeLast();
            selectedCount --;
          }else if(selectedCount < 3){
            isSelectedList[i] = true;
            selectedList.add(interestList[i]);
            selectedDate.add(after30days);
            permissions.add(true);
            selectedCount ++;
          }
        });
      }
    );
  }
}