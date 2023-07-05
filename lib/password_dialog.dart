import 'package:data_project/data/data_setter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

passwordDialog(context, callback) {
  bool isVisibility = false;
  String password = "";
  var callbackFunc = callback;

  return showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) => Dialog.fullscreen(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: (){Navigator.pop(context);}, 
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            SizedBox(height: 200,),
            Text("비밀번호", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            SizedBox(height: 8,),
            Text("비밀번호를 입력하세요"),
            SizedBox(height: 8,),
            IconButton(
              onPressed: () => setState(() {
                isVisibility = !isVisibility;
              }), 
              icon: isVisibility ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
              color: isVisibility ? Colors.cyan : Colors.grey ,
            ),
            Padding(
              padding: EdgeInsets.only(left: 60, right:60,),
              child: 
                TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  obscureText : isVisibility ? false : true,
                  maxLength: 4,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                  onChanged: (value){ setState(() => password = value.toString());}
                ),
            ),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(left: 60, right: 60),
              width: double.infinity,
              height: 40, 
              child: ElevatedButton(
                onPressed: 
                  password.length < 4 ? null 
                  :() async{
                    var isCorrect = await checkPassword(password);
                    if(isCorrect){
                      print(isCorrect);
                      Navigator.pop(context);
                      callbackFunc();
                      // ignore: use_build_context_synchronously
                      // 
                    } else {
                      print("wrong");
                    }
                  } ,
                child: Text('확인'), 
              )
            ),
            // Text(
            //   (!checkPassword(input)||)? '비밀번호가 일치하지 않습니다' : '',
            //   style: TextStyle(color: Colors.red),
            // )
          ],
        ),
      )
    )
  );
}

Future<bool> checkPassword(String input) async{
  bool isCorrect = false;
  PasswordStorage storage = PasswordStorage();
  String correctPassword = await storage.readPassword();
  if (input == correctPassword) {
    isCorrect = true;
  }
  return isCorrect;
}