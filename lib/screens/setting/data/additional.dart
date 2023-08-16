import 'package:data_project/data/question.dart';
import 'package:data_project/firestoremodel/profile_controller.dart';
import 'package:data_project/provider/new_user_provider.dart';
import 'package:data_project/screens/home/home.dart';
import 'package:data_project/widgets/data_pages_header.dart';
import 'package:data_project/widgets/question_dropdown.dart';
import 'package:data_project/widgets/widget_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AdditionalScreen extends StatefulWidget {
  const AdditionalScreen({super.key});

  @override
  State<AdditionalScreen> createState() => _AdditionalScreenState();
}

class _AdditionalScreenState extends State<AdditionalScreen> {
  UserDataController controller = Get.put(UserDataController());

  List? interstSelecteds;
  List<DateTime?> interestDates = [];
  int interestCount = 0;

  // Map questions = Questions.interests;
  Map originalAnswers = {};
  Map newAnswers = {};
  List? nowSelectedQuestions;

  List<bool> toggleSelects = List.empty(growable: true);
  int nowToggleIndex = 0;

  router(){
    if(controller.myProfile().isNewUser){
      Navigator.pushAndRemoveUntil(
        context, 
        MaterialPageRoute(builder: (context) => HomeScreen()), 
        ModalRoute.withName('/'),
      );
    }else{
      Navigator.pop(context);
    }
  }
  setData(){
    context.read<NewUserProvider>().notNewUser();
  }

  createInterestDateText(){
    if (toggleSelects.isEmpty){return Center(child: Text(""),);
    }else if (toggleSelects[0]){return Center(child: Text("내용유지 : ~ ${interestDates[0]}"));
    }else if (toggleSelects[1]){return Center(child: Text("내용유지 : ~ ${interestDates[1]}"));
    }else if (toggleSelects[2]){return Center(child: Text("내용유지 : ~ ${interestDates[2]}"));
    }else {return const Text("예상하지 못한 에러");}
  }
  
  @override
  void initState() {
    super.initState();
    setState(() {
      interstSelecteds = controller.myProfile().userInterests;
      interestDates = controller.getInterestDates();
      interestCount = (interstSelecteds != null)? interstSelecteds!.length : 0;
      if (interestCount > 0) {
        nowSelectedQuestions = Questions.interests[interstSelecteds![0]];
      }
      switch(interestCount){
        case 1 : toggleSelects = [true]; break;
        case 2 : toggleSelects = [true, false]; break;
        case 3 : toggleSelects = [true, false, false]; break;
      }
      newAnswers = controller.getAdditionalAnswersMap();
      originalAnswers = controller.getAdditionalAnswersMap();
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
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal:24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DataPageHeader(
                    title: "추가정보", 
                    description: "정보가 많을 수록 판매될 확률이 높아집니다.\n입력된 정보는 3개월간 수정 불가합니다.", 
                    icon: Icons.library_add),
                  const SizedBox(height: 32,),
                  (interestCount > 0)
                  ?Column(
                    children: [
                      ToggleButtons(
                        onPressed:  (index) {
                          if (index != nowToggleIndex){
                            setState(() {
                              toggleSelects = List.filled(toggleSelects.length, false);
                              toggleSelects[index] = true;
                              nowToggleIndex = index;
                              nowSelectedQuestions = Questions.interests[interstSelecteds![index]];
                            });
                          }
                        },
                        isSelected: toggleSelects,
                        children: [
                          for (int i = 0; i < interstSelecteds!.length; i++)
                            Container(
                              width: 100,
                              padding: const EdgeInsets.all(2),
                              child: Text(interstSelecteds![i], 
                                textAlign: TextAlign.center,
                                style: fontSmallTitle,
                            )),
                      ]),
                      const SizedBox(height: 12,),
                      createInterestDateText(),
                      const SizedBox(height: 40,),
                      if(nowSelectedQuestions != null)
                        for (int i = 0; i < nowSelectedQuestions!.length; i++)
                          QuestionDropDown(
                            isEnabled: (originalAnswers[interstSelecteds![nowToggleIndex]][i] == null), 
                            question: nowSelectedQuestions![i]["title"], 
                            options: nowSelectedQuestions![i]["option"], 
                            selected: newAnswers[interstSelecteds![nowToggleIndex]][i], 
                            onChanged: (value) {
                              setState((){
                                newAnswers[interstSelecteds![nowToggleIndex]][i] = value;
                              });}
                            ),

                  ])
                  : Column(
                    children: const [
                      Text("선택한 관심사가 없습니다."),
                      SizedBox(height: 80,),
                    ],
                  ),
                  ElevatedButton(
                    style: btnStyle,
                    onPressed: (){
                      switch (interestCount) {
                        case 1 : setData(); router(); break;
                        case 2 : 
                          if(toggleSelects[0]){
                            setState((){
                              nowToggleIndex++;
                              toggleSelects = [false, true];
                              nowSelectedQuestions = Questions.interests[interstSelecteds![nowToggleIndex]];
                            });
                          }else{setData(); router(); break;}
                        case 3 : 
                          if(toggleSelects[0]){
                            setState((){
                              nowToggleIndex++;
                              toggleSelects = [false, true, false];
                              nowSelectedQuestions = Questions.interests[interstSelecteds![nowToggleIndex]];
                            });
                          }else if (toggleSelects[1]){
                            setState((){
                              nowToggleIndex++;
                              toggleSelects = [false, false, true];
                              nowSelectedQuestions = Questions.interests[interstSelecteds![nowToggleIndex]];
                            });
                          }else {setData(); router(); break;}
                        default: setData(); router(); break;
                      }
                    }, 
                    child: const Text('확인 저장')
                  ),
                  const SizedBox(height: 20,),
                ],
              ),
            )
          ),
        )
      ),
    );
  }
}