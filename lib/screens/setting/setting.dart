import 'package:data_project/password_dialog.dart';
import 'package:data_project/screens/setting/data_setting.dart';
import 'package:data_project/screens/setting/set_password.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isServiceAlarm = false;
  bool isMarketAlarm = false;
  moveToData(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DataPage()),
    );
  }
  moveToSetPassword(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SetPassword()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('설정')),
      body: Container(
        margin: EdgeInsets.only(top: 20, left:20, right:20,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => passwordDialog(context, moveToData),
              child: Container(
                padding: EdgeInsets.all(20),
                color: const Color.fromARGB(255, 194, 226, 241) ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("데이터 설정"),
                    Icon(Icons.arrow_forward_ios),
                  ]
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Divider(color: Colors.black, thickness: 1,),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('서비스 알림 설정'),
                Switch(value: isServiceAlarm, onChanged: (value){
                  setState(() {
                      isServiceAlarm = value;
                    });
                })
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('마케팅 알림 설정'),
                Switch(value: isMarketAlarm, onChanged: (value){
                  setState(() {
                      isMarketAlarm = value;
                    });
                })
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Divider(color: Colors.black, thickness: 1,),
            ),
            InkWell(
              onTap: () => passwordDialog(context, moveToSetPassword),
              child: Container(
                padding: EdgeInsets.all(20),
                color: const Color.fromARGB(255, 194, 226, 241) ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("비밀번호 설정"),
                    Icon(Icons.arrow_forward_ios),
                  ]
                ),
              ),
            ),
            InkWell(
              onTap: () {
                
              },
              child: Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(20),
                color: const Color.fromARGB(255, 194, 226, 241) ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Column(
                      children: [
                        Text('휴대폰 변경 설정'),
                        Text('010-****-5678'),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ]
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Divider(color: Colors.black, thickness: 1,),
            ),
            TextButton(onPressed: (){}, child: Text('이용약관')),
            TextButton(onPressed: (){}, child: Text('고객센터')),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('버전 정보'),
                  Text('최신 1.0.0'),
                ],
              ),
            ),
            Center(child: TextButton(onPressed: (){}, child: Text('회원탈퇴')))
          ],
        ),
      ),
    );
  }
}