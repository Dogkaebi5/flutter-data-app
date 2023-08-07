import 'package:data_project/data/password_setter.dart';
import 'package:data_project/forget_password_dialog.dart';
import 'package:data_project/widgets/widget_style.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

passwordDialog(context, callback) {
  bool isVisibility = false;
  String password = "";
  var callbackFunc = callback;
  bool isPasswordCorrect = true;
  int unCorrectCount = 0;

  Future<bool> checkPassword(String input) async{
    bool isCorrect = false;
    PasswordStorage storage = PasswordStorage();
    String correctPassword = await storage.readPassword();
    if (input == correctPassword) {
      isCorrect = true;
    }
    return isCorrect;
  }

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
              const SizedBox(height: 174,),
              const Text("비밀번호", style: fontSmallTitle),
              const SizedBox(height: 8,),
              const Text("비밀번호를 입력하세요"),
              const SizedBox(height: 8,),
              IconButton(
                onPressed: () => setState(() => isVisibility = !isVisibility), 
                icon: isVisibility ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                color: isVisibility ? const Color.fromRGBO(186, 104, 200, 1) : const Color.fromRGBO(158, 158, 158, 1) ,
              ),
              const SizedBox(height: 20,),
              Pinput(
                defaultPinTheme: defaultPin,
                focusedPinTheme: focusedPin,
                submittedPinTheme: submittedPin,
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
              const SizedBox(height: 12,),
              if (!isPasswordCorrect)
                (unCorrectCount < 5)?
                Text(
                  '비밀번호가 일치하지 않습니다. (${unCorrectCount.toString()}/5)',
                  style: const TextStyle(color: Colors.red),
                )
                :const Text(
                  '비밀번호를 다시 설정해주세요.',
                  style: TextStyle(color: Colors.red),
                ),
              OutlinedButton(
                onPressed: () => forgetPasswordDialog(context),
                child: const Text("비밀번호 찾기")),
            ],
          ),
        ),
      )
    )
  );
}

