import 'package:data_project/provider/setting_provider.dart';
import 'package:data_project/provider/user_basic_data_provider.dart';
import 'package:data_project/provider/user_interest_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Infopermission extends StatefulWidget {
  const Infopermission({super.key});

  @override
  State<Infopermission> createState() => _InfopermissionState();
}

class _InfopermissionState extends State<Infopermission> {
  List necessaryDataTexts = ["닉네임", "연령층", "이메일"];
  List userDataTexts = ["성함", "성별", "출생연도", "휴대폰", "텔레마케팅 동의"];
  List basciDataTexts = ['결혼정보', '자녀정보', '최종학력', '직업', '소득수준', '거주지역'];
  
  List interests = List.empty(growable: true);

  List isPermitUsers = List.empty(growable: true);
  List isPermitBasics = List.empty(growable: true);
  List isPremitInterest = List.empty(growable: true);

  String? tmDate;
  
  @override
  void initState() {
    super.initState();
    setState(() {
      interests = context.read<UserInterestData>().selectedList;
      isPermitUsers = context.read<SettingProvider>().userDataPermissions;
      isPermitBasics = context.read<UserBasicData>().basicPermissions;
      isPremitInterest = context.read<UserInterestData>().interestPermissions;
      tmDate = context.read<SettingProvider>().permitTmDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('데이터 판매설정')),
      body: SingleChildScrollView(
        child : Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < necessaryDataTexts.length; i++)
                Padding(
                  padding: EdgeInsets.only(bottom: 16, right: 16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(necessaryDataTexts[i],
                          style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          ),
                        ),
                        Text('필수', 
                          style: TextStyle(
                            color: Colors.deepPurple,
                          ),
                        ),
                      ]
                  ),
                ),
              
              for (int i = 0; i < userDataTexts.length-1; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(userDataTexts[i],
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    Switch(
                      value: isPermitUsers[i], 
                      onChanged: (val){
                        setState(() {
                          isPermitUsers[i] = val;
                          if(!isPermitUsers[3]){isPermitUsers[4] = false;}
                          context.read<SettingProvider>().setPermissions(isPermitUsers);
                      });}
                    )
                  ],
                ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("— 텔레마케팅 동의",),
                    Switch(
                      value: isPermitUsers[4],
                      onChanged: (isPermitUsers[3])?
                        (val){
                          setState(() {
                            isPermitUsers[4] = val;
                            tmDate = DateTime.now().toString().split(" ")[0];
                            context.read<SettingProvider>().setTmPermission(val, tmDate);
                          });
                        }
                      : null,
                    ),
                  ],
                ),
              if(isPermitUsers[4])
                Text("텔레마케팅 동의일자 : $tmDate",
                  style: TextStyle(
                    fontSize: 12,
                  ),),
              SizedBox(height: 8,),
              for (int i = 0; i < basciDataTexts.length; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(basciDataTexts[i],
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    Switch(
                      value: isPermitBasics[i],
                      onChanged: (val){
                        setState(() {
                          isPermitBasics[i] = val;
                          context.read<UserBasicData>().setBasicpermissions(isPermitBasics);
                      });}
                    )
                  ],
                ),
              
              for (int i = 0; i < interests.length; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("관심사 ${(i+1).toString()} : ${interests[i]}",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    Switch(
                      value: isPremitInterest[i],
                      onChanged: (val){
                        setState(() {
                          isPremitInterest[i] = val;
                          context.read<UserInterestData>().setInterestpermissions(isPremitInterest);
                      });}
                    )
                  ],
                ),
              
              SizedBox(height: 20,)
            ],
          )
        ),
      )
    );
  }
}