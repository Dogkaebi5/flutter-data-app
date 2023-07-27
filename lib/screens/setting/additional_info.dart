import 'package:data_project/data/question.dart';
import 'package:data_project/provider/new_user_provider.dart';
import 'package:data_project/provider/user_interest_data_provider.dart';
import 'package:data_project/screens/home/home.dart';
import 'package:data_project/screens/setting/data_setting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddInfo extends StatefulWidget {
  const AddInfo({super.key});

  @override
  State<AddInfo> createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  bool isNewUser = false;
  String? tempString;

  List interstSelecteds = List.empty(growable: true);
  List interestDates = List.empty(growable: true);
  int interestCount = 0;

  List<bool> toggleSelects = List.empty(growable: true);
  int nowToggleIndex = 0;

  Map questions = Questions().interests;
  List nowSelectedQuestions = List.empty(growable: true);
  Map additionalSeleteds = {};
  
  List quests = List.empty(growable: true);
  
  @override
  void initState() {
    super.initState();
    setState(() {
      isNewUser = context.read<NewUserProvider>().isNewUser;
      interstSelecteds = context.read<UserInterestData>().selecteds;
      interestDates = context.read<UserInterestData>().selectedDates;
      interestCount = interstSelecteds.length;
      if (interestCount > 0) {
        nowSelectedQuestions = questions[interstSelecteds[0]];
      }
      // toggleSelects.indexOf(true);
      switch(interestCount){
        case 1 : toggleSelects = [true]; break;
        case 2 : toggleSelects = [true, false]; break;
        case 3 : toggleSelects = [true, false, false]; break;
      }
      additionalSeleteds = context.read<UserInterestData>().additionalData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future(() => true),
      // false),
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
                    Icon(Icons.library_add, color: Colors.deepPurple.shade400, size: 32,),
                    SizedBox(width: 8,),
                    Text("추가정보",
                      style: TextStyle(
                        color: Colors.deepPurple.shade400,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                    ),),
                  ],),
                  SizedBox(height: 4,),
                  Text('정보가 많을 수록 판매될 확률이 높아집니다.'),
                  Text('입력된 정보는 3개월간 수정 불가합니다.'),
                  SizedBox(height: 32,),

                  (interestCount > 0)
                  ?Column(
                    children: [
                      Center(
                        child: ToggleButtons(
                          onPressed: (index) {
                            setState(() {
                              toggleSelects = List.filled(toggleSelects.length, false);
                              toggleSelects[index] = !toggleSelects[index];
                              nowToggleIndex = index;
                              nowSelectedQuestions = questions[interstSelecteds[index]];
                            });
                          },
                          isSelected: toggleSelects,
                          children: [
                            for (int i = 0; i < interstSelecteds.length; i++)
                              Container(
                                width: 100,
                                padding: EdgeInsets.all(2),
                                child: Text(interstSelecteds[i], 
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                      ),),],),),
                      SizedBox(height: 12,),
                      createInterestDateText(),
                      SizedBox(height: 40,),

                      for (int i = 0; i < nowSelectedQuestions.length; i++)
                        Column(
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
                                    nowSelectedQuestions[i]["title"],
                                    style: TextStyle(fontWeight: FontWeight.bold,),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    child: DropdownButton(
                                      isExpanded: true,
                                      value: additionalSeleteds[interstSelecteds[nowToggleIndex]][i],
                                      items: (nowSelectedQuestions[i]["option"] as List).map((e)=> 
                                        DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        )).toList(), 
                                      onChanged: (value) {
                                        setState((){
                                          additionalSeleteds[interstSelecteds[nowToggleIndex]][i] = value;
                                        });
                                      }
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 24,),
                          ],
                        ),
                  ])
                  : Column(
                    children: const [
                      Text("선택한 관심사가 없습니다."),
                      SizedBox(height: 80,),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: (){
                        switch (interestCount) {
                          case 1 : setData(); router(); break;
                          case 2 : 
                            if(toggleSelects[0]){
                              setState((){
                                nowToggleIndex++;
                                toggleSelects = [false, true];
                                nowSelectedQuestions = questions[interstSelecteds[nowToggleIndex]];
                              });
                            }else{setData(); router(); break;}
                          case 3 : 
                            if(toggleSelects[0]){
                              setState((){
                                nowToggleIndex++;
                                toggleSelects = [false, true, false];
                                nowSelectedQuestions = questions[interstSelecteds[nowToggleIndex]];
                              });
                            }else if (toggleSelects[1]){
                              setState((){
                                nowToggleIndex++;
                                toggleSelects = [false, false, true];
                                nowSelectedQuestions = questions[interstSelecteds[nowToggleIndex]];
                              });
                            }else {setData(); router(); break;}
                          default: setData(); router(); break;
                        }
                      }, 
                      child: Text('확인 저장')
                    ),
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            )
          ),
        )
      ),
    );
  }

  router(){
    if (isNewUser){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }else{
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DataPage()),
      );
    }
  }
  setData(){
    context.read<NewUserProvider>().notNewUser();
  }

  createInterestDateText(){
    if (toggleSelects.isEmpty){return Center(child: Text(""),);
    }else if (toggleSelects[0]){return Center(child:Text("내용유지 : ~ ${interestDates[0]}"));
    }else if (toggleSelects[1]){return Center(child:Text("내용유지 : ~ ${interestDates[1]}"));
    }else if (toggleSelects[2]){return Center(child:Text("내용유지 : ~ ${interestDates[2]}"));
    }else {return Text("예상하지 못한 에러");}
  }
}