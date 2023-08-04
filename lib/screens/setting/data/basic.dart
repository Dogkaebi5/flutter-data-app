import 'package:data_project/data/question.dart';
import 'package:data_project/provider/new_user_provider.dart';
import 'package:data_project/provider/user_basic_data_provider.dart';
import 'package:data_project/screens/setting/data/interest.dart';
import 'package:data_project/widgets/data_pages_header.dart';
import 'package:data_project/widgets/question_dropdown.dart';
import 'package:data_project/widgets/widget_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BasicDataScreen extends StatefulWidget {
  const BasicDataScreen({super.key});

  @override
  State<BasicDataScreen> createState() => _BasicDataScreenState();
}

class _BasicDataScreenState extends State<BasicDataScreen> {
  late bool isNewUser;
  String? userNickname, userEmail;
  String? residence;
  String? area;
  String? tempString;
  
  List selecteds = List.empty(growable: true);
  List dateList = List.empty(growable: true);

  List basicQuestions = Questions().basicInfo;
  Map residenceMap = Questions().region;
  List residenceOptions = Questions().region.keys.toList();
  List<String?> areaOptions = List.empty(growable: true);

  UserBasicData userData = UserBasicData();
  
  setDataState(origin, newVal) => setState(()=> origin = newVal);

  @override
  void initState(){
    super.initState();
    setState(() {
      userData = context.read<UserBasicData>();
      isNewUser = context.read<NewUserProvider>().isNewUser;
      userNickname = userData.nickname;
      userEmail = userData.email;
      selecteds = userData.selected;
      area = selecteds[6];
      dateList = userData.selectedDate;
      if(selecteds[5] != null){
        areaOptions = residenceMap[selecteds[5]];
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
                  DataPageHeader(
                    title: "기본정보", 
                    description: "정보가 많을 수록 더 많은 리워드를 받을 수 있습니다.",
                    icon: Icons.info),
                  SizedBox(height: 28,),
                  Text("닉네임", style: fontSmallTitle),
                  SizedBox(height: 6,),
                  TextFormField(
                    initialValue: userNickname, 
                    maxLength: 15,
                    decoration: inputDecoration,
                    onChanged: (value) => userNickname = value,
                  ),
                  SizedBox(height: 20,),
                  Text("이메일", style: fontSmallTitle),
                  SizedBox(height: 6,),
                  TextFormField(
                    initialValue: userEmail, 
                    decoration: inputDecoration,
                    onChanged: (value) => userEmail = value,
                  ),
                  
                  SizedBox(height: 40,),
                  Text('※ 아래 입력된 정보는 3개월간 수정 불가합니다.',
                    style: TextStyle(color: Colors.deepPurple)),
                  SizedBox(height: 40,),
                  
                  for (int i = 0; i < basicQuestions.length-2; i++)
                    QuestionDropDown(
                      isEnabled: dateList[i] == null, 
                      question: basicQuestions[i]["title"], 
                      options: basicQuestions[i]["option"], 
                      selected: selecteds[i],
                      onChanged: (value) => setState(() => selecteds[i] = value as String?)
                    ),
                  
                  QuestionDropDown(
                    isEnabled: dateList[5] == null, 
                    question: basicQuestions[5]["title"], 
                    options: residenceOptions, 
                    selected: selecteds[5], 
                    onChanged: (value){
                      setState((){
                        selecteds[5] = value as String?;
                        residence = value;
                        areaOptions = residenceMap[residence];
                        selecteds[6] = null;
                    });}
                  ),

                  QuestionDropDown(
                    isEnabled: dateList[6] == null, 
                    question: basicQuestions[6]["title"], 
                    options: areaOptions, 
                    selected: selecteds[6], 
                    onChanged: (value) {
                      setState((){
                        selecteds[6] = value as String?;
                      });
                    }
                  ),
                  
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: btnStyle,
                    onPressed: (){
                      userData.setData(selecteds);
                      if(isNewUser){
                        navPush(context, InterestScreen());
                      }else{
                        Navigator.pop(context);
                      }
                    }, 
                    child: Text('확인 저장')
                  ),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}