import 'package:data_project/firestoremodel/profile_controller.dart';
import 'package:data_project/data/question.dart';
import 'package:data_project/firestoremodel/user_model.dart';
import 'package:data_project/screens/setting/data/interest.dart';
import 'package:data_project/widgets/data_pages_header.dart';
import 'package:data_project/widgets/question_dropdown.dart';
import 'package:data_project/widgets/widget_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BasicDataScreen extends StatefulWidget {
  const BasicDataScreen({super.key});

  @override
  State<BasicDataScreen> createState() => _BasicDataScreenState();
}

class _BasicDataScreenState extends State<BasicDataScreen> {
  final UserDataController controller = Get.put(UserDataController());
  
  List basicQuestions = Questions().basicInfo;
  Map residenceMap = Questions().region;
  List residenceOptions = Questions().region.keys.toList();
  List<String?> areaOptions = List.empty(growable: true);

  String? userNickname, userEmail;
  BasicData? married, children, education, occupation, income, residence, area;
  String? residenceSelected;
  
  String? 
  originUserNickname, 
  originUserEmail, 
  originMarriedSelected, 
  originChildrenSelected, 
  originEducationSelected, 
  originOccupationSelected, 
  originIncomeSelected, 
  originResidenceSelected, 
  originAreaSelected;
  
  List<String?> selecteds = List.empty(growable: true);
  List dateList = List.empty(growable: true);
  
  bool isBtnEnabled = true;
  setDataState(origin, newVal) => setState(()=> origin = newVal);


  @override
  void initState(){
    super.initState();
    setState(() {
      userNickname = controller.myProfile().nickname??controller.myProfile().name;
      userEmail = controller.myProfile().email??controller.myProfile().gmail;
      married = controller.myProfile().married;
      children = controller.myProfile().children;
      education = controller.myProfile().education;
      occupation = controller.myProfile().occupation;
      income = controller.myProfile().income;
      residence = controller.myProfile().residence;
      area = controller.myProfile().area;
      originUserNickname = controller.myProfile().nickname;
      originUserEmail = controller.myProfile().email;
      originMarriedSelected = married?.selected;
      originChildrenSelected = children?.selected;
      originEducationSelected = education?.selected;
      originOccupationSelected = occupation?.selected;
      originIncomeSelected = income?.selected;
      originResidenceSelected = residence?.selected;
      originAreaSelected = area?.selected;


      selecteds = [married?.selected, children?.selected, education?.selected, occupation?.selected, income?.selected, residence?.selected, area?.selected];
      dateList = [married?.selectedDate, children?.selectedDate, education?.selectedDate, occupation?.selectedDate, income?.selectedDate, residence?.selectedDate, area?.selectedDate];

      residenceSelected = controller.myProfile().residence?.selected;
      if(residenceSelected != null){
        areaOptions = residenceMap[residenceSelected];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
    WillPopScope(
      onWillPop: () => Future(() => true),
      // => Future(() => false), 
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal:24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DataPageHeader(
                    title: "기본정보", 
                    description: "정보가 많을 수록 더 많은 리워드를 받을 수 있습니다.",
                    icon: Icons.info),
                  const SizedBox(height: 28,),
                  const Text("닉네임", style: fontSmallTitle),
                  const SizedBox(height: 6,),
                  TextFormField(
                    initialValue: userNickname,
                    maxLength: 15,
                    decoration: inputDecoration,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp('[\\\\!@#%\\^\\*\\&()\\-\\+_=\$`~\\[\\]{};:\\\'",.<>/?\\s]'))],
                    onChanged: (value) {
                      setState(() {
                        userNickname = value;
                        isBtnEnabled = (value != "") ? true : false;
                      });
                    },
                  ),
                  const SizedBox(height: 20,),
                  const Text("이메일", style: fontSmallTitle),
                  const SizedBox(height: 6,),
                  TextFormField(
                    initialValue: userEmail,
                    decoration: inputDecoration,
                    onChanged: (value){
                      setState(() {
                        userEmail = value;
                        isBtnEnabled = (value != "") ? true : false;
                      });
                    }
                  ),
                  
                  const SizedBox(height: 40,),
                  const Text('※ 아래 입력된 정보는 3개월간 수정 불가합니다.', style: TextStyle(color: Colors.deepPurple)),
                  const SizedBox(height: 40,),
                  
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
                        residenceSelected = value;
                        selecteds[6] = null;
                        areaOptions = residenceMap[residenceSelected];
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
                  
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: btnStyle,
                    onPressed: (isBtnEnabled)?(){
                      if(originUserNickname != userNickname){controller.setNickname(userNickname);}
                      if(originUserEmail != userEmail){controller.setEmail(userEmail);}
                      if(originMarriedSelected != selecteds[0] ||
                      originChildrenSelected != selecteds[1] ||
                      originEducationSelected != selecteds[2] ||
                      originOccupationSelected != selecteds[3] ||
                      originIncomeSelected != selecteds[4] ||
                      originResidenceSelected != selecteds[5] ||
                      originAreaSelected != selecteds[6]){
                        controller.setBasicData(selecteds, dateList);
                      }
                      if(originUserNickname == null){
                        navPush(context, InterestScreen());
                      }else{
                        Navigator.pop(context);
                      }
                    }: null, 
                    child: const Text('확인 저장')
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