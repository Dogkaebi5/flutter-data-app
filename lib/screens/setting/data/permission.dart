import 'package:data_project/data/question.dart';
import 'package:data_project/firestoremodel/profile_controller.dart';
import 'package:data_project/provider/user_interest_data_provider.dart';
import 'package:data_project/widgets/permit_switch.dart';
import 'package:data_project/widgets/widget_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});
  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  final UserDataController controller = Get.put(UserDataController());
  List necessaryDataTexts = Questions.necessaryDataTexts;
  List userDataTexts = Questions.userDataTexts;
  List basciDataTexts = Questions.basicDataTitles.values.toList();
  
  List? interests = List.empty(growable: true);

  List? isPermitUsers = List.empty(growable: true);
  List isPermitBasics = List.empty(growable: true);
  List isPremitInterest = List.empty(growable: true);
  List basicDatas = List.empty(growable: true);
  String tmDate = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      interests = controller.originData.userInterests;
      isPermitUsers = controller.getUserData();
      isPermitBasics = controller.getIsPermitBasics();
      isPremitInterest = controller.getIsPermitInterestsWhichSelected();
      if(controller.originData.permitTelemarketingDate != null){
        tmDate = controller.originData.permitTelemarketingDate.toString() ;
      }
      basicDatas = controller.getBasicSelecteds();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('데이터 판매설정')),
      body: SingleChildScrollView(
        child : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < necessaryDataTexts.length; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(necessaryDataTexts[i], style: TextStyle(color: Colors.black87, fontSize: 16)),
                    const SizedBox(height: 36, width: 40,
                      child: Text('필수', style: TextStyle(color: Colors.deepPurple)))
                ]),
              
              for (int i = 0; i < userDataTexts.length-1; i++)
                PermitSwitch(
                  title: userDataTexts[i], 
                  hasValue: true,
                  switchValue: (isPermitUsers != null) ? isPermitUsers![i] : true, 
                  onChanged: (value) => setState((){
                    isPermitUsers![i] = value;
                    if(!isPermitUsers![3]){isPermitUsers![4] = false;}
                    controller.setUserPermit(i, isPermitUsers![i]);
                  }),
                ),

              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("— 텔레마케팅 동의",),
                  Switch(
                    value: isPermitUsers![4],
                    onChanged: (isPermitUsers![3])?(val){
                      setState(() {
                        isPermitUsers![4] = val;
                        tmDate = DateTime.now().toString().split(" ")[0];
                        controller.setUserPermit(4, isPermitUsers![4]);
                      });
                    }:null,
                  ),
              ]),

              if(isPermitUsers![4])
                Text("텔레마케팅 동의일자 : ${tmDate.split(" ")[0]}", style: fontSmallGrey),
              const SizedBox(height: 8,),

              for (int i = 0; i < basciDataTexts.length; i++)
                PermitSwitch(
                  title: basciDataTexts[i], 
                  hasValue: (basicDatas[i] != null),
                  switchValue: isPermitBasics[i], 
                  onChanged: (basicDatas[i] != null)
                    ?(val){
                      setState(() {
                        isPermitBasics[i] = val;
                        controller.setIsPermitBasics(i, isPermitBasics[i]);
                      });
                    }: null
                ),
              
              for (int i = 0; i < interests!.length; i++)
                PermitSwitch(
                  title: "관심사 ${(1+i).toString()} : ${interests![i]}", 
                  hasValue: true, 
                  switchValue: isPremitInterest[i], 
                  onChanged: (val){
                    setState(() {
                      isPremitInterest[i] = val;
                      controller.setIsPremitInterest(isPremitInterest);
                  });}
                )
            ],
          )
        ),
      )
    );
  }
}