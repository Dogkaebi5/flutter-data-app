import 'package:data_project/widgets/widget_style.dart';
import 'package:flutter/material.dart';

deleteUserDialog(context) {
  bool isCheck = false;

  return showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) => Dialog.fullscreen(
        child: Column(children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: (){Navigator.pop(context);}, 
                icon: const Icon(Icons.close))]),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 160),
                SizedBox(width: double.infinity,
                  child: const Text("회원탈퇴", 
                    textAlign: TextAlign.center, 
                    style: fontSmallTitle)),
                const SizedBox(height: 20,),
                const Text(
'''회원님의 포인트가 전부 소멸됩니다.
회원님의 응답은 삭제되지 않습니다.
회원님의 이미 거래된 내용은 삭제되지 않습니다.
'''),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("내용을 확인했습니다."),
                    Checkbox(
                      value: isCheck, 
                      onChanged: (value){setState(()=> isCheck = !isCheck);
                      }
                    ),
                ]),
                const SizedBox(height: 36),
                ElevatedButton(
                  style: btnStyle,
                  onPressed: isCheck?(){}:null ,
                  child: const Text('탈퇴하기'), 
                )
            ])
          )
        ])
      )
    )
  );
}