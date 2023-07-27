import 'package:data_project/data/question.dart';
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

class _InterestState extends State<Interest> {
  bool isNewUser = false;
  UserInterestData userData = UserInterestData();
  List<String> interestOptions = Questions().interests.keys.toList();
  List selecteds = List.empty(growable: true);
  List isSelecteds = List.empty(growable: true);
  List selectedDates = List.empty(growable: true);
  List permissions = List.empty(growable: true);
  int selectedCount = 0;
  
  @override
  void initState(){
    super.initState();
    setState(() {
      isNewUser = context.read<NewUserProvider>().isNewUser;
      userData = context.read<UserInterestData>();
      isSelecteds = userData.isSelecteds;
      selecteds = userData.selecteds;
      selectedDates = userData.selectedDates;
      permissions = userData.permissions;
      selectedCount = selecteds.length;
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
                  Text('선택된 정보는 3개월간 수정 불가합니다.'),
                  SizedBox(height: 4,),
                  Container(
                    padding: EdgeInsets.all(12),
                    height: 108,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade50,
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
                          for(var i = 0; i < interestOptions.length; i++)
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  saveInterestData(){
    userData.setSeleceds(selecteds);
    userData.setIsSelecteds(isSelecteds);
    userData.setDates(selectedDates);
    userData.setPermissions(permissions);
  }

  createInterestListText(){
    if(selectedCount>0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for(var i = 0; i < selectedCount; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(selecteds[i], 
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 16,
                ),),
              ),
              Text('저장 유지기간 : ~ ${selectedDates[i]}',),
            ],),
        ],
      );
    }
  }
  createInterstCard(i){
    return InkWell(
      child: SizedBox(
        height: 60,
        width: (MediaQuery.of(context).size.width > 360)
          ?MediaQuery.of(context).size.width/3 - 16
          :MediaQuery.of(context).size.width/2 - 24,
        child: 
        Card(
          color: isSelecteds[i]? Colors.deepPurple : Colors.white,
          child: Center(
            child:
              isSelecteds[i] ? 
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text((interestOptions[i]), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    Icon(Icons.close, color: Colors.white, size: 16,),
                  ]),
              )
              : Text(
              interestOptions[i],
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      onTap: (){
        setState(() {
          if(selecteds.contains(interestOptions[i])){
            isSelecteds[i] = false;
            selectedDates.removeAt(selecteds.indexOf(interestOptions[i]));
            permissions.removeAt(selecteds.indexOf(interestOptions[i]));
            selecteds.remove(interestOptions[i]);
            selectedCount --;
          }else if(selectedCount < 3){
            String after30days = DateTime.now().add(Duration(days: 30)).toString().split(" ")[0];
            isSelecteds[i] = true;
            selecteds.add(interestOptions[i]);
            selectedDates.add(after30days);
            permissions.add(true);
            selectedCount ++;
          }
        });
      }
    );
  }
}