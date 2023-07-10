import 'package:data_project/data/new_user_storage.dart';
import 'package:data_project/data/password_setter.dart';
import 'package:data_project/main.dart';
import 'package:data_project/screens/setting/basic_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SetPassword extends StatefulWidget {
  const SetPassword({super.key});

  @override
  State<SetPassword> createState() => _SetPassword();
}

class _SetPassword extends State<SetPassword> {
  PasswordStorage storage = PasswordStorage();
  NewUserStorage userStorage = NewUserStorage();

  bool _isVisibility = false;
  String _newPassword = "";
  String _checkNewPassword = ".";
  bool checkPassword(){
    if(_newPassword.length < 4){ return false;
    } else if (_newPassword == _checkNewPassword) { return true; 
    } else {return false;}  
  }
  bool isFirstLogin = false;

  @override
  void initState() {
    super.initState();
    if (userStorage.read() == "true"){
      setState(() {
        isFirstLogin = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      margin: EdgeInsets.only(top: 200),
        child: 
          Column(
          children: [
            Text("비밀번호 설정", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            SizedBox(height: 8,),
            Text("숫자 4자리"),
            SizedBox(height: 8,),
            IconButton(
              onPressed: () => setState(() => _isVisibility = !_isVisibility),
              icon: _isVisibility ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
              color: _isVisibility ? Colors.cyan : Colors.grey ,
            ),
            Padding(
              padding: EdgeInsets.only(left: 60, right:60,),
              child: 
                TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  obscureText : _isVisibility ? false : true,
                  maxLength: 4,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                  onChanged: (value){
                    setState(() => _newPassword = value.toString());
                    checkPassword();
                  },
                ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 60, right:60, bottom:40),
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                obscureText : _isVisibility ? false : true,
                maxLength: 4,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                onChanged: (value){
                  setState(() => _checkNewPassword = value.toString());
                  checkPassword();
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 60, right: 60),
              width: double.infinity,
              height: 40, 
              child: ElevatedButton(
                onPressed: 
                  checkPassword()
                  ?(){
                      storage.writePassword(_newPassword);
                      if (isFirstLogin) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) =>  BasicInfo(isNewUser: isFirstLogin)),
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
                  : null,                   
                child: Text('확인'), 
              )
            ),
          ],
        ),
      )
    );
  }
}