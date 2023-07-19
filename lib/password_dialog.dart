import 'package:data_project/data/password_setter.dart';
import 'package:data_project/forget_password.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

passwordDialog(context, callback) {
  bool isVisibility = false;
  String password = "";
  var callbackFunc = callback;
  bool isPasswordCorrect = true;
  int unCorrectCount = 0;

  return showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) => Dialog.fullscreen(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal:20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: (){Navigator.pop(context);},
                      child: const Icon(Icons.close),
                    ),
                  ),
              
              SizedBox(height: 174,),
              Text("비밀번호", 
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              SizedBox(height: 8,),
              Text("비밀번호를 입력하세요"),
              SizedBox(height: 8,),
              IconButton(
                onPressed: () => setState(() => isVisibility = !isVisibility), 
                icon: isVisibility ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                color: isVisibility ? Colors.purple.shade300 : Colors.grey ,
              ),
              SizedBox(height: 20,),
              Pinput(
                defaultPinTheme: PinTheme(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20)
                  )
                ),
                focusedPinTheme: PinTheme(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.purple.shade100,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.purple, width: 1.2 )
                  ),
                ),
                submittedPinTheme: PinTheme(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.purple.shade200, width: 1),
                  )
                ),
                autofocus : true,
                obscureText : isVisibility? false :true,
                obscuringCharacter: "⁕",
                onChanged: (value)=> setState(() => password = value.toString()),
                onCompleted: (value)async{
                  var isCorrect = await checkPassword(password);
                  if(isCorrect){
                    Navigator.pop(context);
                    callbackFunc();
                  } else {
                    setState((){
                      isPasswordCorrect = false;
                      unCorrectCount++;
                    });
                  }
                },
              ),
              SizedBox(height: 12,),
              if (!isPasswordCorrect)
                (unCorrectCount < 5)?
                Text(
                  '비밀번호가 일치하지 않습니다. (${unCorrectCount.toString()}/5)',
                  style: TextStyle(color: Colors.red),
                )
                :Text(
                  '비밀번호를 다시 설정해주세요.',
                  style: TextStyle(color: Colors.red),
                ),
              OutlinedButton(
                onPressed: (){
                  forgetPasswordDialog(context);
                }, 
                child: Text("비밀번호 찾기")),
            ],
          ),
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