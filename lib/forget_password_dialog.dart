import 'package:data_project/screens/setting/set_password.dart';
import 'package:data_project/widgets/widget_style.dart';
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
              children: [IconButton(
                onPressed: (){Navigator.pop(context);}, 
                icon: const Icon(Icons.close),
              ),
            ]),
            const SizedBox(height: 160,),
            const Text("비밀번호 찾기", style: fontSmallTitle),
            const SizedBox(height: 28,),
            const Text("본인인증으로 비밀번호를 다시 설정하세요"),
            const SizedBox(height: 120,),

            Container(
              margin: const EdgeInsets.only(left: 60, right: 60),
              width: double.infinity,
              height: 40, 
              child: ElevatedButton(
                onPressed: () => navPush(context, SetPasswordScreen()),
                child: const Text('본인인증'), 
              )
            ),
          ],
        ),
      )
    )
  );
}
