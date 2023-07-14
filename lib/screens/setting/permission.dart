import 'package:data_project/provider/user_basic_data_provider.dart';
import 'package:data_project/provider/user_interest_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoPremission extends StatefulWidget {
  const InfoPremission({super.key});

  @override
  State<InfoPremission> createState() => _InfoPremissionState();
}

class _InfoPremissionState extends State<InfoPremission> {
  List dateTexts = [
    '이메일', '성함', '휴대폰', '텔레마케팅 동의', '성별', '출생연도',
    '결혼정보', '자녀정보', '최종학력', '직업', '소득수준', '거주지역'];
  List isBasicPremissions = List.empty(growable: true);
  List interests = List.empty(growable: true);
  List isInterestPremissions = List.empty(growable: true);
  
  @override
  void initState() {
    super.initState();
    setState(() {
      interests = context.read<UserInterestData>().selectedList;
      isBasicPremissions = context.read<UserBasicData>().basicPremissions;
      isInterestPremissions = context.read<UserInterestData>().interestPremissions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('데이터 판매범위 설정')),
      body: SingleChildScrollView(
        child : Container(
          margin: EdgeInsets.only(top:30, left:20, right:20,),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20, right: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('닉네임'),Text('필수'),
                    ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, right: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('연령층'),Text('필수'),
                    ]
                ),
              ),
              for (int i = 0; i < dateTexts.length; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(dateTexts[i]),
                    Switch(
                      value: isBasicPremissions[i],
                      onChanged: (val){
                        setState(() {
                          isBasicPremissions[i] = val;
                          context.read<UserBasicData>().setBasicPremissions(isBasicPremissions);
                      });}
                    )
                  ],
                ),
              for (int i = 0; i < interests.length; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("관심사 ${(i+1).toString()} : ${interests[i]}"),
                    //수정 필요 invalid value empty 에러 << newUser가 아님 조건 변경 필요--
                    Switch(
                      value: isInterestPremissions[i],
                      onChanged: (val){
                        setState(() {
                          isInterestPremissions[i] = val;
                          context.read<UserInterestData>().setInterestPremissions(isInterestPremissions);
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