import 'package:data_project/data/question.dart';
import 'package:data_project/firestoremodel/profile_controller.dart';
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
  List<String> interestOptions = Questions.interests.keys.toList();
  List<String> originSelecteds = List.empty(growable: true);
  List<String> newSelecteds = List.empty(growable: true);
  List<bool> isSelecteds = List.empty(growable: true);
  List newDates = List.empty(growable: true);
  int selectedCount = 0;
  
  @override
  void initState(){
    super.initState();
    setState(() {
      originSelecteds = List.from(controller.myProfile().userInterests??[]);
      isSelecteds = controller.createInterestIsSelectedsMap(originSelecteds).values.toList();
      newDates = List.from(controller.myProfile().userInterestDates??[]);
      newSelecteds = List.from(controller.myProfile().userInterests??[]);
      selectedCount = originSelecteds.length;
    });
  }

  bool checkCanChange(i){
    List dates = controller.createInterestDatesMap().values.toList();
    if(originSelecteds.isEmpty){
      return true;
    }else if (!originSelecteds.contains(interestOptions[i])){
      return true;
    }else if (controller.isDurationSmallerThanNow(dates[i])){
      return true;
    }else {
      return false;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future(() => true),
      // false),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(padding: const EdgeInsets.symmetric(vertical: 20, horizontal:24),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DataPageHeader(
                    title: "관심사", 
                    description: "관심사를 최대 3개 선택하세요.\n선택된 정보는 3개월간 수정 불가합니다.", 
                    icon: Icons.interests),
                  const SizedBox(height: 8),
                  Container(padding: const EdgeInsets.all(12),
                    height: 108,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(237, 231, 246, 1),
                      borderRadius: BorderRadius.circular(10)),
                    child: createInterestListText()),
                  Container(margin: const EdgeInsets.symmetric(vertical:10),
                    width: double.infinity,
                    child: Wrap(alignment: WrapAlignment.center,
                      children: [
                        for(var i = 0; i < interestOptions.length; i++)
                          createInterstCard(i)
                    ])
                  ),
                  ElevatedButton(
                    style: btnStyle,
                    onPressed: () {
                      if(controller.myProfile().isNewUser!){
                        controller.setInterests(newSelecteds);
                        navPush(context, AdditionalScreen());
                      }else{
                        controller.setInterests(newSelecteds);
                        Navigator.pop(context);
                      }
                    }, 
                    child: const Text('확인 저장')
                  ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  createInterstCard(i){
    bool canChange = checkCanChange(i);
    return InkWell(
      onTap: (!canChange)
        ? (){}
        : (){
          setState(() {
            if(newSelecteds.contains(interestOptions[i])){
              isSelecteds[i] = false;
              newDates.removeAt(newSelecteds.indexOf(interestOptions[i]));
              newSelecteds.remove(interestOptions[i]);
              selectedCount --;
            }else if(selectedCount < 3){
              isSelecteds[i] = true;
              newSelecteds.add(interestOptions[i]);
              newDates.add(controller.durationDate());
              selectedCount ++;
            }
          });
        },
      child: SizedBox(
        height: 60,
        width: (MediaQuery.of(context).size.width > 360)
          ? MediaQuery.of(context).size.width/3 - 18
          : MediaQuery.of(context).size.width/2 - 26,
        child: Card(
          color: (!canChange)
            ? Colors.deepPurple.shade200 : isSelecteds[i]
            ? Colors.deepPurple : Colors.white,
          child: Center(child:
            isSelecteds[i] 
              ? Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text((interestOptions[i]), 
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  if(canChange)
                    Icon(Icons.close, color: Colors.white, size: 16)
              ])
              : Text(interestOptions[i], textAlign: TextAlign.center),
          ),
        ),
      )
    );
  }
  
  createInterestListText(){
    if(selectedCount > 0){
      return Column(mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for(var i = 0; i < newSelecteds.length; i++)
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(padding: const EdgeInsets.all(2.0),
                  child: Text(newSelecteds[i], 
                    style: const TextStyle(color: Colors.deepPurple, fontSize: 16))),
                Text('저장 유지기간 : ~ ${newDates[i].toString().split(" ")[0]}'),
            ])
        ]
      );
    }
  }
}