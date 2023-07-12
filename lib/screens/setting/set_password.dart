import 'package:data_project/data/password_setter.dart';
import 'package:data_project/main.dart';
import 'package:data_project/provider/user_data_provider.dart';
import 'package:data_project/screens/setting/basic_info.dart';
import 'package:data_project/testpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SetPassword extends StatefulWidget {
  const SetPassword({super.key});

  @override
  State<SetPassword> createState() => _SetPassword();
}

//basic 호출할 때 파라미터 전달 말로 provider로 수정 필요
//isFirstLogin 삭제 필요

class _SetPassword extends State<SetPassword> {
  bool _isVisibility = false;
  bool isCorrectPassword = true;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      margin: EdgeInsets.only(top: 200, left: 60, right: 60),
        child: Column(
          children:[
            Text(
              "비밀번호 설정", 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            SizedBox(height: 8,),
            Text("숫자 4자리"),
            SizedBox(height: 8,),
            IconButton(
              onPressed: () => setState(() => _isVisibility = !_isVisibility),
              icon: _isVisibility ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
              color: _isVisibility ? Colors.cyan : Colors.grey ,
            ),
            passwordTextField(setNewPassword),
            passwordTextField(setCheckNewPassword),
            SizedBox(height: 40,),
            SizedBox(
              width: double.infinity,
              height: 40, 
              child: ElevatedButton(
                onPressed: 
                  (_newPassword.length > 3 && _checkNewPassword.length > 3)
                  ?(){
                    checkPassword();
                    if(isCorrectPassword){
                      PasswordStorage().writePassword(_newPassword);
                      if (context.read<NewUserProvider>().isNewUser) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) =>  BasicInfo()),
                          ModalRoute.withName('/'),
                        );
                      }else {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) =>  MyApp()),
                          ModalRoute.withName('/'),
                        );
                      }
                    }
                  }: null,                   
                child: Text('확인'), 
              ),
            ),
            SizedBox(height: 20,),
            if (!isCorrectPassword)
              Text("비밀번호가 일치하지 않습니다", style: TextStyle(color: Colors.red),)
          ],
        ),
      )
    );
  }

  passwordTextField(setter){
    return TextField(
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      obscureText : _isVisibility ? false : true,
      maxLength: 4,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
      onChanged: (value){
        setter(value);
      },
    );
  }
}