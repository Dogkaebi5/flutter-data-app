import 'package:data_project/firestoremodel/profile_controller.dart';
import 'package:data_project/screens/home/home.dart';
import 'package:data_project/screens/setting/data/basic.dart';
import 'package:data_project/widgets/widget_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreen();
}

class _SetPasswordScreen extends State<SetPasswordScreen> {
  bool _isVisibilityNew = false;
  bool _isVisibilityCheck = false;
  String _newPassword = "";
  String _checkNewPassword = "";
  bool? isCorrectPassword;

  void setNewPassword(String newPassword) => setState(() => _newPassword = newPassword);
  void setCheckNewPassword(String checkNewPassword) => setState(() => _checkNewPassword = checkNewPassword);
  final PageController _pageViewController = PageController();
  final UserDataController controller = Get.put(UserDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageViewController,
          children: [
            Column(
              children:[
                const SizedBox(height: 224,),
                const Text("새로운 비밀번호", style: fontSmallTitle),
                const SizedBox(height: 8,),
                const Text("숫자 4자리을 입력하세요"),
                const SizedBox(height: 8,),
                IconButton(
                  onPressed: () => setState(() => _isVisibilityNew = !_isVisibilityNew),
                  icon: _isVisibilityNew ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                  color: _isVisibilityNew ? const Color.fromRGBO(186, 104, 200, 1) : const Color.fromRGBO(158, 158, 158, 1) ,
                ),
                const SizedBox(height: 20,),
                Pinput(
                  defaultPinTheme: defaultPin,
                  focusedPinTheme: focusedPin,
                  submittedPinTheme: submittedPin,
                  autofocus : true,
                  obscureText : _isVisibilityNew? false :true,
                  obscuringCharacter: "⁕",
                  onChanged: (value)=> setState(()=> _newPassword = value),
                  onCompleted: (value){
                    _pageViewController.nextPage(
                      duration: const Duration(milliseconds: 300), 
                      curve: Curves.linear,
                  );}
            ),],),

            Column(
              children:[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: (){ 
                        _pageViewController.previousPage(
                          duration: const Duration(milliseconds: 300), 
                          curve: Curves.linear,);
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                ),
                const SizedBox(height: 160,),
                const Text("비밀번호 다시 확인", style: fontSmallTitle),
                const SizedBox(height: 8,),
                const Text("입력한 비밀번호를 다시 입력해주세요"),
                const SizedBox(height: 8,),
                IconButton(
                  onPressed: () => setState(() => _isVisibilityCheck = !_isVisibilityCheck),
                  icon: _isVisibilityCheck ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                  color: _isVisibilityCheck ? const Color.fromRGBO(186, 104, 200, 1) : const Color.fromRGBO(158, 158, 158, 1) ,
                ),
                const SizedBox(height: 20 ,),
                Pinput(
                  defaultPinTheme: defaultPin,
                  focusedPinTheme: focusedPin,
                  submittedPinTheme: submittedPin,
                  autofocus : true,
                  obscureText : _isVisibilityCheck? false :true,
                  obscuringCharacter: "⁕",
                  onChanged: (value)=> setState(()=> _checkNewPassword = value),
                  onCompleted: (value){
                    if(_newPassword == _checkNewPassword){
                      controller.setNewPassword(_newPassword);
                      if (controller.checkIsNewUser()) {
                        navPush(context, BasicDataScreen());
                      }else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      }
                    }else{
                      setState(()=> isCorrectPassword = false);
                    }
                  }
                ),
                const SizedBox(height: 20,),
                if (isCorrectPassword != null || isCorrectPassword == false)
                  const Text("비밀번호가 일치하지 않습니다", style: TextStyle(color: Colors.red)),
            ],)
        ],),
        ),
      );
  }
}