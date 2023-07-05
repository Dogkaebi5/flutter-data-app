import 'package:flutter/material.dart';

class InfoPremission extends StatefulWidget {
  const InfoPremission({super.key});

  @override
  State<InfoPremission> createState() => _InfoPremissionState();
}

class _InfoPremissionState extends State<InfoPremission> {
  // final List _dataList = ['이메일', '성함', '휴대폰', '텔레마케팅 동의', '성별', '출생연도', '결혼정보', '자녀정보', '최종학력', '직업', '소득수준', '거주지역', '관심사 1', '관심사 2', '관심사 3'];
  // List<bool> dataStateList = List.filled(_dataList.length, false);
  final Map<String, bool> _dataState = {
    '이메일': false,
    '성함': false, 
    '휴대폰': false,
    '텔레마케팅 동의': false,
    '성별': false,
    '출생연도': false,
    '결혼정보': false,
    '자녀정보': false,
    '최종학력': false,
    '직업': false,
    '소득수준': false,
    '거주지역': false,
    '관심사 1': false,
    '관심사 2': false,
    '관심사 3': false,
  };

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
              for (int i = 0; i < _dataState.length; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_dataState.keys.toList()[i]),
                    Switch(
                      value: _dataState.values.toList()[i],
                      onChanged: (val){
                        setState(() {
                          _dataState[_dataState.keys.toList()[i]] = val;
                          // _dataState.values.toList()[i] = val;
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