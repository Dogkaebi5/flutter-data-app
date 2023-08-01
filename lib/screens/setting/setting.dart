import 'package:data_project/password_dialog.dart';
import 'package:data_project/provider/setting_provider.dart';
import 'package:data_project/screens/setting/data/data_setting.dart';
import 'package:data_project/screens/setting/del_user_dialog.dart';
import 'package:data_project/screens/setting/set_password.dart';
import 'package:data_project/screens/webview/webview.dart';
import 'package:data_project/screens/widget_style.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isServiceNotice = false;
  bool isMarketNotice = false;
  String mobile = "";

  @override
  void initState(){
    super.initState();
    setState(() {
      isServiceNotice = context.read<SettingProvider>().isNotice[0];
      isMarketNotice = context.read<SettingProvider>().isNotice[1];
      mobile = context.read<SettingProvider>().mobile;
    });
  }

  moveToData(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DataScreen()),
    );
  }
  moveToSetPassword(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SetPasswordScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(title: Text('설정'),
        shadowColor: const Color.fromARGB(0, 0, 0, 0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: .4,),
            InkWell(
              onTap: () => passwordDialog(context, moveToData),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 56, horizontal: 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple, Colors.deepPurple.shade300],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [BoxShadow(
                    color: Colors.grey.withOpacity(.6),
                    blurRadius: 6,
                    spreadRadius : 1,
                    offset: Offset(2, 4)
                  )],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.account_circle_outlined,
                          size: 40,
                          color: Colors.white,
                        ),
                        SizedBox(width: 12,),
                        Column(
                          children: [
                            Text("데이터 설정",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                            ),),
                            Text("데이터 수정하기",
                              style: TextStyle(
                                color: Colors.deepPurple.shade50),
                            )
                          ],
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios,
                    color: Colors.white,
                    ),
                  ]
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() => isServiceNotice = !isServiceNotice);
                          context.read<SettingProvider>().setNoticeService(isServiceNotice);
                        },
                        child: Text('서비스 알림 설정', style: fontSmallTitle),
                      ),
                      Switch(
                        value: isServiceNotice, 
                        onChanged: (value){
                          setState(() => isServiceNotice = value);
                          context.read<SettingProvider>().setNoticeService(value);
                        })
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() => isMarketNotice = !isMarketNotice);
                          context.read<SettingProvider>().setNoticeMarket(isMarketNotice);
                        },
                        child: Text('마케팅 알림 설정', style: fontSmallTitle),
                      ),
                      Switch(
                        value: isMarketNotice, 
                        onChanged: (value){
                          setState(() => isMarketNotice = value);
                          context.read<SettingProvider>().setNoticeMarket(value);
                        })
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 1,),
            InkWell(
              onTap: () => passwordDialog(context, moveToSetPassword),
              child: SizedBox(
                height: 60,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("비밀번호 설정", style: fontSmallTitle ),
                      Icon(Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 16
                      ),
                    ]
                  ),
                ),
              ),
            ),
            SizedBox(height: 1,),
            InkWell(
              onTap: () => navPush(context, Webview()),
              child: SizedBox(
                height: 60,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('휴대폰 변경 설정', style: fontSmallTitle ),
                          SizedBox(width: 8,),
                          Text("010-****-$mobile",
                            style: TextStyle(
                              color: Colors.black54,
                            )
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 16
                      ),
                    ]
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: TextButton(
                onPressed: () => navPush(context, Webview()),
                child: Text('이용약관')
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: TextButton(
                onPressed: () => navPush(context, Webview()),
                child: Text('고객센터')
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16,horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('버전 정보'),
                  Text('최신 1.0.0'),
                ],
              ),
            ),
            SizedBox(height: 12,),
            Center(child: OutlinedButton(onPressed: (){
              deleteUserDialog(context);
            }, child: Text('회원탈퇴')))
          ],
        ),
      ),
    );
  }
}