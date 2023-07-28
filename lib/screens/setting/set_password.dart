import 'package:data_project/data/password_setter.dart';
import 'package:data_project/main.dart';
import 'package:data_project/provider/new_user_provider.dart';
import 'package:data_project/screens/setting/data/basic.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreen();
}

class _SetPasswordScreen extends State<SetPasswordScreen> {
  bool _isVisibilityNew = false;
  bool _isVisibilityCheck = false;
  bool? isCorrectPassword;
  String _newPassword = "";
  String _checkNewPassword = "";

  void setNewPassword(String newPassword){
    setState(() => _newPassword = newPassword);
  }
  void setCheckNewPassword(String checkNewPassword){
    setState(() => _checkNewPassword = checkNewPassword);
  }
  void checkPassword(){
    (_newPassword == _checkNewPassword)
      ?setState(() => isCorrectPassword = true)
      :setState(() => isCorrectPassword = false);
  }
  final PageController _pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageViewController,
          children: [
            Column(
              children:[
                SizedBox(height: 224,),
                Text(
                  "새로운 비밀번호", 
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                SizedBox(height: 8,),
                Text("숫자 4자리을 입력하세요"),
                SizedBox(height: 8,),
                IconButton(
                  onPressed: () => setState(() => _isVisibilityNew = !_isVisibilityNew),
                  icon: _isVisibilityNew ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                  color: _isVisibilityNew ? Colors.purple.shade300 : Colors.grey ,
                ),
                SizedBox(height: 20,),
                Pinput(
                  defaultPinTheme: PinTheme(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20)
                  )),
                  focusedPinTheme: PinTheme(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.purple.shade100,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.purple, width: 1.2 )
                  ),),
                  submittedPinTheme: PinTheme(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.purple.shade200, width: 1),
                  )),
                  autofocus : true,
                  obscureText : _isVisibilityNew? false :true,
                  obscuringCharacter: "⁕",
                  onChanged: (value)=> setState(()=> _newPassword = value),
                  onCompleted: (value){
                    _pageViewController.nextPage(
                      duration: Duration(milliseconds: 300), 
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
                          duration: Duration(milliseconds: 300), 
                          curve: Curves.linear,);
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                ),
                SizedBox(height: 160,),
                Text(
                  "비밀번호 다시 확인", 
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                SizedBox(height: 8,),
                Text("입력한 비밀번호를 다시 입력해주세요"),
                SizedBox(height: 8,),
                IconButton(
                  onPressed: () => setState(() => _isVisibilityCheck = !_isVisibilityCheck),
                  icon: _isVisibilityCheck ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                  color: _isVisibilityCheck ? Colors.purple.shade300 : Colors.grey ,
                ),
                SizedBox(height: 20 ,),
                Pinput(
                  defaultPinTheme: PinTheme(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20)
                  )),
                  focusedPinTheme: PinTheme(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.purple.shade100,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.purple, width: 1.2 )
                  ),),
                  submittedPinTheme: PinTheme(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.purple.shade200, width: 1),
                  )),
                  autofocus : true,
                  obscureText : _isVisibilityCheck? false :true,
                  obscuringCharacter: "⁕",
                  onChanged: (value)=> setState(()=> _checkNewPassword = value),
                  onCompleted: (value){
                    if(_newPassword == _checkNewPassword){
                      PasswordStorage().writePassword(_newPassword);
                      if (context.read<NewUserProvider>().isNewUser) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) =>  BasicDataScreen()),
                          ModalRoute.withName('/'),
                        );
                      }else {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) =>  MyApp()),
                          ModalRoute.withName('/'),
                        );
                      }
                    }else{
                      setState(()=> isCorrectPassword = false);
                    }
                  }
                ),
                SizedBox(height: 20,),
                if (isCorrectPassword != null && isCorrectPassword == false)
                  Text("비밀번호가 일치하지 않습니다", style: TextStyle(color: Colors.red),),
            ],)
        ],),
        ),
      );
  }
}