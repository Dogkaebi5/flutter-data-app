import 'package:data_project/data/question.dart';
import 'package:data_project/provider/new_user_provider.dart';
import 'package:data_project/provider/user_basic_data_provider.dart';
import 'package:data_project/screens/setting/data_setting.dart';
import 'package:data_project/screens/setting/interest_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BasicInfo extends StatefulWidget {
  const BasicInfo({super.key});

  @override
  State<BasicInfo> createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  bool isNewUser = true;
  String? userNickname, userEmail;
  String? residence;
  String? tempString;
  List? selecteds = List.empty(growable: true);
  List? dateList = List.empty(growable: true);

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
      dateList = userData.selectedDate;
      if(selecteds?[5] != null){
        areaOptions = residenceMap[selecteds?[5]];
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
                  SizedBox(height: 40,),
                  Row(
                    children: [
                      Icon(Icons.info, color: Colors.deepPurple.shade400, size: 32,),
                      SizedBox(width: 8,),
                      Text("기본정보",
                        style: TextStyle(
                          color: Colors.deepPurple.shade400,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                      ),),
                  ],),
                  SizedBox(height: 4,),
                  Text('정보가 많을 수록 더 많은 리워드를 받을 수 있습니다.',),
                  
                  SizedBox(height: 28,),
                  Text("닉네임", 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 6,),
                  TextFormField(
                    initialValue: userNickname, 
                    maxLength: 15,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(12),
                      counterText: "",
                    ),
                    onChanged: (value) => userNickname = value,
                  ),
                  SizedBox(height: 20,),
                  Text("이메일", 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 6,),
                  TextFormField(
                    initialValue: userEmail, 
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(12),
                      
                    ),
                    onChanged: (value) => userEmail = value,
                  ),
                  
                  SizedBox(height: 40,),
                  Text('※ 아래 입력된 정보는 3개월간 수정 불가합니다.',
                    style: TextStyle(color: Colors.deepPurple.shade400),
                  ),
                  SizedBox(height: 40,),
                  
                  for (int i = 0; i < basicQuestions.length-2; i++) 
                    createBasicDataDropDown(
                      basicQuestions[i]["title"], 
                      basicQuestions[i]["option"], 
                      i),
                  
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(92, 209, 196, 233),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(basicQuestions[5]["title"],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left:8, right:8),
                          child: DropdownButton(
                            isExpanded: true,
                            value: selecteds?[5],
                            items: residenceOptions.map((e)=> DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            )).toList(), 
                            onChanged: (value) {
                              setState((){
                                selecteds?[5] = value as String?;
                                selecteds?[6] = tempString;
                                residence = value as String?;
                                areaOptions = residenceMap[residence];
                              });
                            }
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8,),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(92, 209, 196, 233),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(basicQuestions[6]["title"],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left:8, right:8),
                          child: DropdownButton(
                            isExpanded: true,
                            value: selecteds?[6],
                            items: areaOptions.map((e)=> DropdownMenuItem(
                              value: e,
                              child: Text(e!),
                            )).toList(), 
                            onChanged: (value) {
                              setState((){
                                selecteds?[6] = value as String?;
                              });
                            }
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    width: double.maxFinite,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: (){
                        userData.setData(selecteds);
                        if(isNewUser){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Interest()),
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
        )
      ),
    );
  }
  

  createBasicDataDropDown(String title, List option, int i){ 
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) => Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: (dateList?[i] == null || dateList?[i] == "")
              ? Colors.deepPurple.shade50
              : Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left:8, right:8),
                  child: DropdownButton(
                    isExpanded: true,
                    value: selecteds?[i],
                    items: 
                      option.map((e) =>
                        DropdownMenuItem(
                          value: e,
                          enabled: (dateList?[i] == null || dateList?[i] == "")?true:false,
                          child: Text(e),
                        )
                      ).toList(), 
                    onChanged: (value) {
                      setState((){
                        selecteds?[i] = value as String?;
                      });
                    }
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8,)
        ],
      )
    );
  }

}