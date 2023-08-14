import 'package:data_project/data/question.dart';
import 'package:data_project/firestoremodel/profile_controller.dart';
import 'package:data_project/firestoremodel/user_model.dart';
import 'package:data_project/screens/setting/data/additional.dart';
import 'package:data_project/widgets/data_pages_header.dart';
import 'package:data_project/widgets/widget_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});
  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  UserDataController controller = Get.put(UserDataController());  
  List<String> interestOptions = Questions().interestQuestions.keys.toList();
  late List<String> originSelecteds = List.empty(growable: true);
  List<String> newSelecteds = List.empty(growable: true);
  List<bool> isSelecteds = List.empty(growable: true);
  List<DateTime?> durationDates = List.empty(growable: true);
  int selectedCount = 0;
  
  bool checkChanged(){
    bool tf = true;
    if(originSelecteds.length != selectedCount){
      tf = true;
    }else{for(int i = 0; i < selectedCount; i++){
      if(originSelecteds[i] == newSelecteds[i]){
        tf = false;
        break;
    }}}
    return tf;
  }


  @override
  void initState(){
    super.initState();
    setState(() {
      UserModel user = controller.myProfile();
      isSelecteds = [
        user.insurance!.isSelected, user.loan!.isSelected, user.deposit!.isSelected, 
        user.immovables!.isSelected, user.stock!.isSelected, user.cryto!.isSelected, 
        user.golf!.isSelected, user.tennis!.isSelected, user.fitness!.isSelected, 
        user.yoga!.isSelected, user.dietary!.isSelected, user.educate!.isSelected, 
        user.parental!.isSelected, user.automobile!.isSelected, user.localTrip!.isSelected, 
        user.overseatrip!.isSelected, user.camp!.isSelected, user.fishing!.isSelected, 
        user.pet!.isSelected];
      durationDates = [
        user.insurance?.selectedDate, user.loan?.selectedDate, user.deposit?.selectedDate, 
        user.immovables?.selectedDate, user.stock?.selectedDate, user.cryto?.selectedDate, 
        user.golf?.selectedDate, user.tennis?.selectedDate, user.fitness?.selectedDate, 
        user.yoga?.selectedDate, user.dietary?.selectedDate, user.educate?.selectedDate, 
        user.parental?.selectedDate, user.automobile?.selectedDate, user.localTrip?.selectedDate, 
        user.overseatrip?.selectedDate, user.camp?.selectedDate, user.fishing?.selectedDate, 
        user.pet?.selectedDate];
      
      originSelecteds = List.from(user.userInterests??[]);
      
      newSelecteds = List.from(user.userInterests??[]);
      selectedCount = originSelecteds.length;
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
                    title: "관심사", 
                    description: "관심사를 최대 3개 선택하세요.\n선택된 정보는 3개월간 수정 불가합니다.", 
                    icon: Icons.interests),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    height: 108,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(237, 231, 246, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: createInterestListText(),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical:10),
                    width: double.infinity,
                    child:Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        for(var i = 0; i < interestOptions.length; i++)
                          createInterstCard(i)
                    ]),
                  ),
                  ElevatedButton(
                    style: btnStyle,
                    onPressed: (){
                      if(controller.myProfile().isNewUser!){
                        if(checkChanged()){controller.setInterests(newSelecteds, durationDates);}
                        navPush(context, AdditionalScreen());
                      }else{
                        if(checkChanged()){controller.setInterests(newSelecteds, durationDates);}
                        Navigator.pop(context);
                      }
                    }, 
                    child: const Text('확인 저장')
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  createInterstCard(i){
    return InkWell(
      onTap: (originSelecteds.contains(interestOptions[i]))
        ? (){}
        : (){
        setState(() {
          if(newSelecteds.contains(interestOptions[i])){
            isSelecteds[i] = false;
            durationDates[i] = null;
            newSelecteds.remove(interestOptions[i]);
            selectedCount --;
          }else if(selectedCount < 3){
            DateTime after30days = DateTime.now().add(Duration(days: 30));
            isSelecteds[i] = true;
            newSelecteds.add(interestOptions[i]);
            durationDates[i]= after30days;
            selectedCount ++;
          }
        });
      },
      child: SizedBox(
        height: 60,
        width: (MediaQuery.of(context).size.width > 360)
          ?MediaQuery.of(context).size.width/3 - 18
          :MediaQuery.of(context).size.width/2 - 26,
        child: 
        Card(
          color: (originSelecteds.contains(interestOptions[i]))
            ?Colors.deepPurple.shade200
            : isSelecteds[i]? Colors.deepPurple : Colors.white,
          child: Center(
            child:
              isSelecteds[i] ? 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text((interestOptions[i]), 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
                  if(!originSelecteds.contains(interestOptions[i]))
                    Icon(Icons.close, color: Colors.white, size: 16,),
                ])
              : Text(
              interestOptions[i],
              textAlign: TextAlign.center,
            ),
          ),
        ),
      )
    );
  }
  
  createInterestListText(){
    if(selectedCount>0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for(var i = 0; i < isSelecteds.length; i++)
            if(isSelecteds[i])
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(interestOptions[i], style: const TextStyle(color: Colors.deepPurple, fontSize: 16)),
                  ),
                  Text('저장 유지기간 : ~ ${durationDates[i].toString().split(" ")[0]}',),
              ],),
        ],
      );
    }
  }
}