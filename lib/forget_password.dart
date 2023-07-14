import 'package:data_project/screens/setting/set_password.dart';
import 'package:flutter/material.dart';

forgetPasswordDialog(context) {

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
            SizedBox(height: 160,),
            Text("비밀번호 찾기", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            SizedBox(height: 28,),
            Text("본인인증으로 비밀번호를 다시 설정하세요"),
            SizedBox(height: 120,),

            Container(
              margin: EdgeInsets.only(left: 60, right: 60),
              width: double.infinity,
              height: 40, 
              child: ElevatedButton(
                onPressed: (){
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SetPassword()),
                    ModalRoute.withName('/'),
                  );
                },
                child: Text('본인인증'), 
              )
            ),
          ],
        ),
      )
    )
  );
}
