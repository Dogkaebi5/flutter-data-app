import 'dart:convert';

import 'package:data_project/provider/new_user_provider.dart';
import 'package:data_project/provider/user_interest_data_provider.dart';
import 'package:data_project/screens/home/home.dart';
import 'package:data_project/screens/setting/data_setting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String jsonUserInterest = '''{
  "userInterest": [
    {
      "title": "보험설계", 
      "date": "2023-03-20",
      "question": [
        {
          "title": "가입한 보험이 있으신가요?",
          "option": ["10개 이상", "6~10개", "3~5개", "1~2개", "없음"],
          "selected": ""
        },
        {
          "title": "어떻게 해당 보험에 가입하셨나요?",
          "option" : ["소설광고", "지인 소개", "영업 전화", "검색", "기타"],
          "selected": ""
        },
        {
          "title": "월 평균 납입하는 보험료는?",
          "option" : ["100만 이상", "50~100만", "10~50만", "10만 이하", "없음"],
          "selected": ""
        },
        {
          "title": "신규/추가로 보험 상담/가입할 의향이 있나요?",
          "option" : ["가능한 빨리", "1~3개월 내", "3~6개월", "6개월 ~ 1년", "없음"],
          "selected": ""
        },
        {
          "title": "보험 구매에 중요시 하는 점은?",
          "option" : ["보상", "비용", "전문성", "지인추천", "소셜 및 입소문"],
          "selected": ""
        },
        {
          "title": "현재 관심있는 보험의 종류는 무엇인가요?",
          "option" : ["생명", "중질환", "전문성", "치아", "실비보험", "기타"],
          "selected": ""
        }
      ]
    },
    {
      "title":"대출",
      "date": "2023-03-21",
      "question": [
        {
          "title": "현재 대출이 있으신가요?",
          "option" : ["주택담보대출", "신용대출", "없음"],
          "selected": ""
        },
        {
          "title": "어떻게 대출 상품을 선택하셨나요?",
          "option" : ["소설광고", "지인 소개", "영업 전화", "직접 방문 신청", "검색"],
          "selected": ""
        },
        {
          "title": "대출금 현황은?",
          "option" : ["1억 이상", "5000~1억", "3000~5000만", "3000만 이하", "없음"],
          "selected": ""
        },
        {
          "title": "월 상환금액은 얼마나 되나요?",
          "option" : ["800만 이상", "500~800만", "200~500만", "100~200만", "100만 이하"],
          "selected": ""
        },
        {
          "title": "신규/추가로 대출받을 계획이 있나요?",
          "option" : ["가능한 빨리", "1~3개월 내", "3~6개월", "6개월 ~ 1년", "없음"],
          "selected": ""
        },
        {
          "title": "대출에 중요시 하는 점은?",
          "option" : ["가능 최대액", "이자율", "전문가 추천", "지인추천", "소셜 및 입소문"],
          "selected": ""
        },
        {
          "title": "현재 기타 관심있는 대출은 무엇인가요?",
          "option" : ["주택담보대출", "자동차 담보대출", "신용대출"],
          "selected": ""
        }
      ]
    },
    {
      "title": "예금/적금", 
      "date": "2023-03-22",
      "question": [
        {
          "title": "가입한 정기 예/적금이 있으신가요?",
          "option" : ["1억 이상", "5000~1억", "1000~5000만", "1000만 이하", "없음"],
          "selected": ""
        },
        {
          "title": "어떻게 대출 상품을 선택하셨나요?",
          "option" : ["소설광고", "지인 소개", "영업 전화", "직접 방문 신청", "검색"],
          "selected": ""
        },
        {
          "title": "가입한 상품의 저축 기간은 얼마나 되나요?",
          "option" : ["5년 이상", "3~5년", "1~3년", "1년 미만", "없음"],
          "selected": ""
        },
        {
          "title": "월 정기 저축하고 있는 금액이 얼마인가요?",
          "option" : ["500만 이상", "100~300만", "50~100만", "50만", "없음"],
          "selected": ""
        },
        {
          "title": "신규/추가로 대출받을 계획이 있나요?",
          "option" : ["가능한 빨리", "1~3개월 내", "3~6개월", "6개월 ~ 1년", "없음"],
          "selected": ""
        },
        {
          "title": "예/적금 상품 가입시 중요시하는 점은?",
          "option" : ["금리", "최대금액", "은행 신용도", "지인추천", "소셜 및 입소문"],
          "selected": ""
        }
      ]
    }
  ]
  }''';

class AddInfo extends StatefulWidget {
  const AddInfo({super.key});

  @override
  State<AddInfo> createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  List<bool> _selections = List.empty(growable: true);
  List userInterestList = List.empty(growable: true);
  List quests = List.empty(growable: true);
  
  bool isNewUser = false;
  int trueIndex = 0;
  int selectedInterestCount = 0;
  List selectedInterestList = List.empty(growable: true);
  List selectedInterestDates = List.empty(growable: true);
  List addSelected = List.empty(growable: true);
  String? temporaryText;

  @override
  void initState() {
    super.initState();
    setState(() {
      Map mapData = jsonDecode(jsonUserInterest);
      userInterestList= mapData["userInterest"];
      List q1 = userInterestList[0]["question"];
      List q2 = userInterestList[1]["question"];
      List q3 = userInterestList[2]["question"];

      List addDataList = context.read<UserInterestData>().addData;
      var addData0 = addDataList[0];
      var addData1 = addDataList[1];
      var addData2 = addDataList[2];

      isNewUser = context.read<NewUserProvider>().isNewUser;
      
      selectedInterestList = context.read<UserInterestData>().selectedList;
      selectedInterestCount = context.read<UserInterestData>().interestCount;
      selectedInterestDates = context.read<UserInterestData>().dateList;
            
      switch(selectedInterestCount){
        case 1 : 
          _selections = [true]; 
          addSelected = [
            List.filled(q1.length, temporaryText),"",""];
          break;
        case 2 :
          _selections = [true, false];
          addSelected = [
            List.filled(q1.length, temporaryText),
            List.filled(q2.length, temporaryText),""];
          break;
        case 3 : 
          _selections = [true, false, false];
          addSelected = [
            List.filled(q1.length, temporaryText),
            List.filled(q2.length, temporaryText),
            List.filled(q3.length, temporaryText)];
          break;
        default : break;
      }
      if(addData0.isNotEmpty){addSelected[0] = addData0;}
      if(addData1.isNotEmpty){addSelected[1] = addData1;}
      if(addData2.isNotEmpty){addSelected[2] = addData2;}
      if(selectedInterestCount > 0){setQuestValue();}
    });
  }

  void setQuestValue(){
    trueIndex = _selections.indexOf(true);
    quests = userInterestList[trueIndex]["question"];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future(() => false),
      child: Scaffold(
        appBar: AppBar(
          title: Text('추가정보'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: 
        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top:20, left:20, right:20,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('정보가 많을 수록 판매될 확률이 높아집니다.'),
                Text('입력된 정보는 3개월간 수정 불가합니다.'),
                SizedBox(height: 20,),
    
                (selectedInterestCount > 0)
                  ?Column(
                    children: [
                      Center(
                        child: ToggleButtons(
                          onPressed: (index) {
                            setState(() {
                              _selections = List.filled(_selections.length, false);
                              _selections[index] = !_selections[index];
                              setQuestValue();
                            });
                          },
                          isSelected: _selections,
                          children: [
                            for (int i = 0; i < selectedInterestList.length; i++)
                              Container(
                                width: 100,
                                padding: EdgeInsets.all(2),
                                child: Text(selectedInterestList[i], textAlign: TextAlign.center,),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12,),
                      createInterestDateText(),
                      SizedBox(height: 40,),
                      for (int i = 0; i < quests.length; i++)
                        createQuestionDropDowns(i),
                    ])
                  : Column(
                    children: const [
                      Text("선택한 관심사가 없습니다."),
                      SizedBox(height: 80,),
                    ],
                  ),
    
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: (){
                      switch (selectedInterestCount) {
                        case 1 : setData(); router(); break;
                        case 2 : 
                          if(_selections[0]){
                            setState((){
                              _selections = [false, true];
                              setQuestValue();
                            });
                          }else{setData(); router(); break;}
                        case 3 : 
                          if(_selections[0]){
                            setState((){
                              _selections = [false, true, false];
                              setQuestValue();
                            });
                          }else if (_selections[1]){
                            setState((){
                              _selections = [false, false, true];
                              setQuestValue();
                            });
                          }else {setData(); router(); break;}
                        default: router(); break;
                      }
                    }, 
                    child: Text('확인 저장')
                  ),
                ),
                SizedBox(height: 20,),
              ],
            ),
          )
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
    context.read<UserInterestData>().setAdd(addSelected);
  }

  createInterestDateText(){
    if (_selections.isEmpty){return Center(child: Text(""),);
    }else if (_selections[0]){return Center(child:Text("내용유지 : ~ ${selectedInterestDates[0]}"));
    }else if (_selections[1]){return Center(child:Text("내용유지 : ~ ${selectedInterestDates[1]}"));
    }else if (_selections[2]){return Center(child:Text("내용유지 : ~ ${selectedInterestDates[2]}"));
    }else {return Text("예상하지 못한 에러");}
  }

  createQuestionDropDowns(i){
    List selecteds = addSelected[trueIndex];
    String? selected = selecteds[i];
    String question = quests[i]['title'];
    List options = quests[i]['option'];
    
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          DropdownButton(
            isExpanded: true,
            value: selected,
            items: options.map((e)=> 
              DropdownMenuItem(
                value: e,
                child: Text(e),
              )).toList(), 
            onChanged: (value) {
              setState((){
                selected = value as String? ;
                addSelected[trueIndex][i] = value;
              });
            }
          ),
          SizedBox(height: 24,),
        ],
      )
    );
  }
}