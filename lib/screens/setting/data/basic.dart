import 'package:data_project/firestoremodel/profile_controller.dart';
import 'package:data_project/data/question.dart';
import 'package:data_project/firestoremodel/user_model.dart';
// import 'package:data_project/provider/new_user_provider.dart';
// import 'package:data_project/provider/user_basic_data_provider.dart';
import 'package:data_project/screens/setting/data/interest.dart';
import 'package:data_project/widgets/data_pages_header.dart';
import 'package:data_project/widgets/question_dropdown.dart';
import 'package:data_project/widgets/widget_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:provider/provider.dart';

class BasicDataScreen extends StatefulWidget {
  const BasicDataScreen({super.key});

  @override
  State<BasicDataScreen> createState() => _BasicDataScreenState();
}

class _BasicDataScreenState extends State<BasicDataScreen> {
  final UserDataController contorller = Get.put(UserDataController());
  List basicQuestions = Questions().basicInfo;
  Map residenceMap = Questions().region;
  List residenceOptions = Questions().region.keys.toList();
  List<String?> areaOptions = List.empty(growable: true);

  late bool isNewUser;
  String? userNickname, userEmail;
  BasicData? married, children, education, occupation, income, residence, area;
  String? residenceSelected;
  
  List<String?> selecteds = List.empty(growable: true);
  List dateList = List.empty(growable: true);
  
  bool isBtnEnabled = true;
  // UserBasicData userData = UserBasicData();
  setDataState(origin, newVal) => setState(()=> origin = newVal);
  // late UserModel userData;

  @override
  void initState(){
    super.initState();
    setState(() {
      print("test1: ${contorller.myProfile().nickname}");
      print("test2: ${contorller.myProfile().email}");
      print("test3: ${contorller.myProfile().married?.selected}");
      // userData = contorller.myProfile();
      // userData = context.read<UserBasicData>();
      isNewUser = (contorller.myProfile().password == null)? true: false;
      userNickname = contorller.myProfile().nickname ?? contorller.myProfile().name;
      userEmail = contorller.myProfile().email ?? contorller.myProfile().gmail;
      married = contorller.myProfile().married;
      children = contorller.myProfile().children;
      education = contorller.myProfile().education;
      occupation = contorller.myProfile().occupation;
      income = contorller.myProfile().income;
      residence = contorller.myProfile().residence;
      area = contorller.myProfile().area;
      
      selecteds = [married?.selected, children?.selected, education?.selected, occupation?.selected, income?.selected, residence?.selected, area?.selected];
      dateList = [married?.selectedDate, children?.selectedDate, education?.selectedDate, occupation?.selectedDate, income?.selectedDate, residence?.selectedDate, area?.selectedDate];

      residenceSelected = contorller.myProfile().residence?.selected;
      // dateList = userData.selectedDate;
      if(residenceSelected != null){
        areaOptions = residenceMap[residenceSelected];
      }
      //temporary reader
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
                      contorller.setNickname(userNickname);
                      contorller.setEmail(userEmail);
                      contorller.setBasicData(selecteds, dateList);
                      if(isNewUser){
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