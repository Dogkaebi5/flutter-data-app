import 'package:data_project/password_dialog.dart';
import 'package:data_project/provider/setting_provider.dart';
import 'package:data_project/screens/setting/data/data_setting.dart';
import 'package:data_project/screens/setting/del_user_dialog.dart';
import 'package:data_project/screens/setting/set_password.dart';
import 'package:data_project/screens/webview/webview.dart';
import 'package:data_project/widgets/widget_style.dart';
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
    nav() => Navigator.push(context,
      MaterialPageRoute(builder: (context) => const SetPasswordScreen()));
    passwordDialog(context, nav);
  }
  moveToTextWebview(){navPush(context, Webview());}
  setLinkCard(String title, navigator, String? infoText){
    return InkWell(
      onTap: () => navigator(),
      child: Container(
        margin: const EdgeInsets.only(top:1),
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: const Color.fromRGBO(255, 255, 255, 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: fontSmallTitle ),
            const SizedBox(width: 8,),
            if(infoText != null)
              Text(infoText, style: const TextStyle(color: Colors.black54)),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
        ]),
    ));
  }

  StatefulBuilder setSwitch(String title, bool isOn, callback){
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState){
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(child: Text(title, style: fontSmallTitle),
              onTap: () => setState((){
                isOn = !isOn;
                callback();
              }),
            ),
            Switch(
              value: isOn, 
              onChanged: (value) => setState((){
                isOn = value;
                callback();
              }),
            )
          ],
        );
      }
    );
  }
  void changeServiceNoticePermit(){
    setState(() => isServiceNotice = !isServiceNotice);
    context.read<SettingProvider>().setNoticeService(isServiceNotice);
  }
  void changeMarketingNoticePermit(){
    setState(() => isMarketNotice = !isMarketNotice);
    context.read<SettingProvider>().setNoticeMarket(isMarketNotice);
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(title: const Text('설정'),
        shadowColor: const Color.fromARGB(0, 0, 0, 0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: .4,),
            InkWell(
              onTap: () => passwordDialog(context, moveToData),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 56, horizontal: 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: const [Colors.deepPurple, Color.fromRGBO(149, 117, 205, 1)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [greyShadow],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
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
                            Text("데이터 수정하기", style: TextStyle(color: Color.fromRGBO(237, 231, 246, 1)))
                        ]),
                    ]),
                    Icon(Icons.arrow_forward_ios,color: Colors.white,
                    ),
                  ]
            ))),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              color: const Color.fromRGBO(255, 255, 255, 1),
              child: Column(
                children: [
                  setSwitch("서비스 알림 설정", 
                    isServiceNotice, 
                    changeServiceNoticePermit),
                  setSwitch("마케팅 알림 설정", 
                    isMarketNotice, 
                    changeMarketingNoticePermit),
              ]),
            ),
            setLinkCard("비밀번호 설정", moveToSetPassword, null),
            setLinkCard("휴대폰 변경 설정", moveToTextWebview, "010-****-$mobile"),
            const SizedBox(height: 20),
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