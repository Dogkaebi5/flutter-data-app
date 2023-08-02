import 'package:data_project/provider/setting_provider.dart';
import 'package:data_project/provider/user_basic_data_provider.dart';
import 'package:data_project/provider/user_interest_data_provider.dart';
import 'package:data_project/widgets/widget_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  static const List necessaryDataTexts = ["닉네임", "연령층", "이메일"];
  static const List userDataTexts = ["성함", "성별", "출생연도", "휴대폰", "텔레마케팅 동의"];
  static const List basciDataTexts = ['결혼정보', '자녀정보', '최종학력', '직업', '소득수준', '거주지역'];
  
  List interests = List.empty(growable: true);

  List isPermitUsers = List.empty(growable: true);
  List isPermitBasics = List.empty(growable: true);
  List isPremitInterest = List.empty(growable: true);
  List basicDatas = List.empty(growable: true);

  String? tmDate;
  final TextStyle _textStyle = TextStyle(
    color: Colors.black87,
    fontSize: 16,
  );

  @override
  void initState() {
    super.initState();
    setState(() {
      interests = context.read<UserInterestData>().selecteds;
      isPermitUsers = context.read<SettingProvider>().userDataPermissions;
      isPermitBasics = context.read<UserBasicData>().basicPermissions;
      isPremitInterest = context.read<UserInterestData>().permissions;
      tmDate = context.read<SettingProvider>().permitTmDate;
      basicDatas = context.read<UserBasicData>().selected;
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
                Row(
                  children: [
                    Text(necessaryDataTexts[i], style: _textStyle),
                    Spacer(),
                    SizedBox(height: 36, width: 40,
                      child: Text('필수', style: TextStyle(color: Colors.deepPurple))
                    )
                  ]
                ),
              
              for (int i = 0; i < userDataTexts.length-1; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(userDataTexts[i], style: _textStyle),
                    Switch(
                      value: isPermitUsers[i], 
                      onChanged: (val){
                        setState(() {
                          isPermitUsers[i] = val;
                          if(!isPermitUsers[3]){isPermitUsers[4] = false;}
                          context.read<SettingProvider>().setPermissions(isPermitUsers);
                      });}
                    )
                ]),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("— 텔레마케팅 동의",),
                  Switch(
                    value: isPermitUsers[4],
                    onChanged: 
                      (isPermitUsers[3])
                        ?(val){
                          setState(() {
                            isPermitUsers[4] = val;
                            tmDate = DateTime.now().toString().split(" ")[0];
                            context.read<SettingProvider>().setTmPermission(val);
                        });}
                        :null,
                  ),
              ]),

              if(isPermitUsers[4])
                Text("텔레마케팅 동의일자 : $tmDate", style: fontSmallGrey),
              SizedBox(height: 8,),

              for (int i = 0; i < basciDataTexts.length; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(basciDataTexts[i], style: _textStyle),
                    Switch(
                      value: isPermitBasics[i],
                      onChanged: (basicDatas[i] != null)
                        ?(val){
                          setState(() {
                            isPermitBasics[i] = val;
                            context.read<UserBasicData>().setPermissions(isPermitBasics);
                        });}
                        : null
                    )
                  ],
                ),
              
              for (int i = 0; i < interests.length; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("관심사 ${(i+1).toString()} : ${interests[i]}", style: _textStyle),
                    Switch(
                      value: isPremitInterest[i],
                      onChanged: (val){
                        setState(() {
                          isPremitInterest[i] = val;
                          context.read<UserInterestData>().setPermissions(isPremitInterest);
                      });}
                    )
                ]),
            ],
          )
        ),
      )
    );
  }

  createSwitch(title, value, void setter){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: _textStyle),
        Switch(
          value: value,
          onChanged: (val){
            setState(() => value = val);
            setter;
          }
        )
      ],
    );
  }
}